//
//  RKContainer.m
//  RKMicAppContainerModule
//
//  Created by 贾晓滨 on 2021/6/29.
//

#import "RKContainer.h"
#import "RKModuleProtocol.h"
#import "RKServiceProtocol.h"
#import "RKContainerUtils.h"
#import "RKDefines.h"
#import "RKDataReader.h"
#import "RKContext.h"

@interface RKContainer()
@property (nonatomic, strong) NSMutableArray<id<RKModuleProtocol>> *modulesArray;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSMutableArray<id<RKModuleProtocol>> *> *moduleEventMap;
@property (nonatomic, strong) NSMutableDictionary *servicesMap;
@property (nonatomic, strong) NSRecursiveLock *lock;
@end

@implementation RKContainer

#pragma mark - 单例实现
static RKContainer *_sharedInstance;
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
        _sharedInstance.context = [[RKContext alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - Manage API
- (void)registModule:(Class)moduleClass{
    NSParameterAssert(moduleClass != nil);
    NSString *moduleName = NSStringFromClass(moduleClass);
    NSLog(@"注册Module：-->%@", (NSString *)moduleName);
    // 查找当前全局module列表中是否已经注册了当前module
    __block BOOL flag = YES;
    [self.modulesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:moduleClass]) {
            flag = NO;
            *stop = YES;
        }
    }];
    if (!flag) {
        return;
    }
    // 实现了RKModuleProtocol协议的module才会被添加
    if ([moduleClass conformsToProtocol:@protocol(RKModuleProtocol)]){
        id<RKModuleProtocol> moduleInstance = [[moduleClass alloc] init];
        [self.modulesArray addObject:moduleInstance];
        // 根据该Module监听的系统事件存储到哈希表中
        [self registerEventsListener:moduleInstance];
    }
}
- (void)registService:(Class)serviceClass forProtocol:(Protocol *)protocol{
    NSParameterAssert(serviceClass != nil);
    NSParameterAssert(protocol != nil);
    
    NSString *protocolName= NSStringFromProtocol(protocol);
    NSString *protocolService = NSStringFromClass(serviceClass);
    if(![serviceClass conformsToProtocol:protocol]){
        if (self.context.env == RKEnvTypeDebug) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:@"sercice 与 protocol 不匹配"
                                         userInfo:nil];
        }
        return;
    }
    
    
    NSLog(@"注册Service：%@-->%@", (NSString *)protocolName, (NSString *)protocolService);
    
    NSString *serviceImplStr = [[self servicesInfo] objectForKey:protocolName];
    if ([RKContainerUtils validateString:serviceImplStr]) {
        if (self.context.env == RKEnvTypeDebug) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:@"module与protocol 映射关系已存在"
                                         userInfo:nil];
        }
        return;
    }
    
    if ([RKContainerUtils validateString:protocolName] && [RKContainerUtils validateString:protocolService]) {
        [self.lock lock];
        [self.servicesMap addEntriesFromDictionary:@{protocolName:protocolService}];
        [self.lock unlock];
    }
}
- (id)loadServiceForProtocol:(Protocol *)protocol{
    NSString *protocolName = NSStringFromProtocol(protocol);
    NSString *serviceImplStr = [[self servicesInfo] objectForKey:protocolName];
    id implInstance = nil;
    Class implClass = nil;
    if (![RKContainerUtils validateString:serviceImplStr]) {
        if (self.context.env == RKEnvTypeDebug) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                           reason:[NSString stringWithFormat:@"该 protocol[%@] 对应的服务未注册", protocolName]
                                         userInfo:nil];
        }
        return nil;
    }else{
        implClass = NSClassFromString(serviceImplStr);
    }
    // ...需要加缓存逻辑
    // 得到当前service的具体实现class
    if ([[implClass class] respondsToSelector:@selector(singleton)] && [[implClass class] singleton]) {
        if ([[implClass class] respondsToSelector:@selector(shareInstance)]){
            implInstance = [[implClass class] shareInstance];
        }else{
            if (self.context.env == RKEnvTypeDebug) {
                @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                               reason:@"该 protocol 对应的 Service 为单例对象，必须实现shareInstance方法"
                                             userInfo:nil];
            }
            return nil;
        }
        return implInstance;
    }
    return [[implClass alloc] init];
}
- (void)configEnv:(RKEnvType)envType{
    self.context.env = envType;
}
- (void)configRootVC:(UINavigationController *)rootVC {
    self.context.rootVC = rootVC;
}

#pragma mark - Event dispatch
- (void)dispatchEvent:(RKEventType)eventType {
    NSArray<id<RKModuleProtocol>> *modules = [self.moduleEventMap objectForKey:@(eventType)];
    NSString *selectorStr = [[self eventSelectors] objectForKey:@(eventType)];
    SEL seletorItem = NSSelectorFromString(selectorStr);
    [modules enumerateObjectsUsingBlock:^(id<RKModuleProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id<RKModuleProtocol> moduleItem = obj;
        if([moduleItem respondsToSelector:seletorItem]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            // 忽略performSelector选择器未知引起泄漏
            // 模块事件处理监控
            NSString *moduleName = NSStringFromClass([moduleItem class]);
            NSLog(@"事件监控埋点start：%@--事件<%ld>", moduleName, eventType);
            [moduleItem performSelector:seletorItem withObject:nil];
            NSLog(@"事件监控埋点end：%@--事件<%ld>", moduleName, eventType);
#pragma clang diagnostic pop
        }
    }];
}
- (void)registerEventsListener:(id<RKModuleProtocol>)moduleInstance{
    NSDictionary *eventSelectors = [self eventSelectors];
    [eventSelectors enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSNumber *eventTypeNum = (NSNumber *)key;
        NSString *selectorStr = (NSString *)obj;
        SEL selector = NSSelectorFromString(selectorStr);
        if (!selector || ![moduleInstance respondsToSelector:selector]) {
            // 如果Module未实现当前selector，不用继续添加监听
            return;
        }
        if (!self.moduleEventMap[eventTypeNum]) {
            [self.moduleEventMap setObject:@[].mutableCopy forKey:eventTypeNum];
        }
        NSMutableArray *moduleArrayForEvent = [self.moduleEventMap objectForKey:eventTypeNum];
        if ([moduleArrayForEvent containsObject:moduleInstance]){
            // 当前module已注册
            return;
        }
        // 将当前module添加到event对应的队列中
        [moduleArrayForEvent addObject:moduleInstance];
    }];
}

#pragma mark - inner
- (void)loadAllModuleAndService{
    // 读取所有modules
    NSMutableArray *modules = [RKDataReader readConfigFromSectionName:RKModuleSectionName];
    NSLog(@"%@", modules);
    [modules enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class moduleClass = NSClassFromString((NSString *)obj);
        if(moduleClass){
            [self registModule:moduleClass];
        }
    }];
    
    // 读取所有services
    NSMutableArray *servicesInfoArray = [RKDataReader readConfigFromSectionName:RKServiceSectionName];
    NSMutableDictionary *services = [NSMutableDictionary dictionary];
    for(int idx = 0; idx < servicesInfoArray.count; ++idx){
        NSString *str = [servicesInfoArray objectAtIndex:idx];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *converError = nil;
        if (data) {
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&converError];
            if (json && [json isKindOfClass:[NSDictionary class]])
            {
                [services addEntriesFromDictionary:json];
            }
        }
    }
    [services enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        Protocol * serviceProtocol = NSProtocolFromString((NSString *)key);
        Class serviceClass = NSClassFromString((NSString *)obj);
        if(serviceProtocol && serviceClass){
            [self registService:serviceClass forProtocol:serviceProtocol];
        }
    }];
    NSLog(@"%@", services);
}

#pragma mark - Lazy
- (NSRecursiveLock *)lock{
    if (!_lock) {
        _lock = [[NSRecursiveLock alloc] init];
    }
    return _lock;
}
- (NSMutableDictionary *)servicesMap{
    if (!_servicesMap) {
        _servicesMap = [NSMutableDictionary dictionary];
    }
    return _servicesMap;
}
- (NSDictionary *)servicesInfo{
    [self.lock lock];
    NSDictionary *dict = [self.servicesMap copy];
    [self.lock unlock];
    return dict;
}
- (NSDictionary *)eventSelectors{
    return @{
        @(RKBeforeDidFinishLaunchingEvent):@"kBeforeDidFinishLaunching",
        @(RKDidFinishLaunchingEvent):@"kDidFinishLaunching",
        @(RKAfterFinishLaunchingEvent):@"kAfterFinishLaunching",
        @(RKDidEnterBackgroundEvent):@"kDidEnterBackground",
        @(RKWillEnterForegroundEvent):@"kWillEnterForeground",
        @(RKDidBecomeActiveEvent):@"kDidBecomeActive",
        @(RKWillTerminateEvent):@"kWillTerminate"
    };
}
- (NSMutableDictionary<NSNumber *, NSMutableArray<id<RKModuleProtocol>> *> *)moduleEventMap{
    if (!_moduleEventMap) {
        _moduleEventMap = @{}.mutableCopy;
    }
    return _moduleEventMap;
}

@end
