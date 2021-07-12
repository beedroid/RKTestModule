//
//  RKGirlFriend.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2021/6/17.
//  Copyright © 2021 beedroid. All rights reserved.
//

#import "RKGirlFriend.h"
#include <objc/runtime.h>
#import "RKSpireWheel.h"

@implementation RKGirlFriend
#pragma mark - 方法调用
- (void)sayMessage1:(NSString *)msg{
    NSLog(@"RKGirlFriend<方法调用> say :%@", msg);
}

#pragma mark - 动态转发,为当前类动态添加方法
// 参数：对象、方法编号、
void addDynamicCMethodIMP(id self, SEL _cmd, NSString *msg){
    NSLog(@"RKGirlFriend<resolveInstanceMethod 动态转发> 动态添加C方法IMP:%@", msg);
}
- (void)addDynamicOCMethod{
    NSLog(@"RKGirlFriend<resolveInstanceMethod 动态转发> 动态添加OC对象方法IMP");
}

+ (void)addClassDynamicOCMethod{
    NSLog(@"RKGirlFriend<resolveInstanceMethod 动态转发> 动态添加OC类方法IMP");
}
/**
 对象：在接受到无法解读的消息的时候 首先会调用所属类的类方法

 @param sel 传递进入的方法
 @return 如果YES则能接受消息 NO不能接受消息 进入第二步
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSString *methodName = NSStringFromSelector(sel);
    if([methodName isEqualToString:@"sayCMessage:"]){
        //class_addMethod(Class _Nullable cls, SEL _Nonnull name, IMP _Nonnull imp,const char * _Nullable types)
        // 第四个参数含义：添加的IMP实现对应的方法签名，第1个V代表返回值是Void，第2个@表示第一个参数是id类型，第3个冒号表示第二个参数是SEL（方法编号），第四个@表示第三个参数是id类型
        class_addMethod([self class], sel, (IMP)addDynamicCMethodIMP, "v@:@");// 第三个参数是一个C方法
        
        return YES;
    }else if([methodName isEqualToString:@"sayOCMessage:"]){
        //获取实现的方法内容
        Method funtionRealMethod = class_getInstanceMethod(self, @selector(addDynamicOCMethod));
        //实现方法的IMP
        IMP methodIMP = method_getImplementation(funtionRealMethod);
        //实现方法的类别 返回类型 携带参数 等
        const char * types = method_getTypeEncoding(funtionRealMethod);
        //对类对象添加成员方法
        class_addMethod([self class], sel, methodIMP, types);// 第三个参数是一个OC方法
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

/**
 类：如果是类方法的调用，首先会触发该类方法
 
 @param sel 传递进入的方法
 @return 如果YES则能接受消息 NO不能接受消息 进入第二步
 */
+(BOOL)resolveClassMethod:(SEL)sel{

    if ([NSStringFromSelector(sel) isEqualToString:@"sayPlusMessage:"]) {
        //转换字符串类别
        const  char *classChar = [NSStringFromClass([self class]) UTF8String];
        //需要char的字符串 获取元类
        Class metaClass = objc_getMetaClass(classChar);
        
        //获取实现的方法内容
        Method funtionRealMethod = class_getInstanceMethod(metaClass, @selector(addClassDynamicOCMethod));
        //实现方法的IMP
        IMP methodIMP = method_getImplementation(funtionRealMethod);
        //实现方法的类别 返回类型 携带参数 等
        const char * types = method_getTypeEncoding(funtionRealMethod);
        
        //对元类对象添加类方法
        class_addMethod(metaClass, sel, methodIMP, types);// 第三个参数是一个OC方法
        return YES;
    }
    return [super resolveClassMethod:sel];
}
#pragma mark - 快速转发
/**
 转发SEL去对象内部的其他可以响应的对象

 @param aSelector 需要被响应的方法SEL
 @return 返回一个可以被响应的该SEL的对象 如果返回self或者nil,则说明没有可以响应的目标 则进入第三步
 */
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSString *methodName = NSStringFromSelector(aSelector);
    if([methodName isEqualToString:@"sayMessage3:"]){
        // 如果这个消息可以由备胎实现，就返回备胎
        return [[RKSpireWheel alloc] init];
    }
    // 继续正常的转发流程
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark - 消息机制的第三步 完整的消息转发机制 总共2个步骤
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    /**
    1.手动创建签名 但是尽量少使用 因为容易创建错误 可以按照这个规则来创建
    https://blog.csdn.net/ssirreplaceable/article/details/53376915
    根据OBJC的编码类别进行编写后面的char （但是容易写错误，所以建议使用下面的方法）
    NSMethodSignature *sign = [NSMethodSignature signatureWithObjCTypes:"v@:"];
     //写法例子
     //例子"v@:@"
     //v@:@ v:返回值类型void;@ id类型,执行sel的对象;：SEL;@参数
     //例子"@@:"
     //@:返回值类型id;@id类型,执行sel的对象;：SEL
    2.自动创建签名
     BackupTestMessage * backUp = [BackupTestMessage new];
     NSMethodSignature * sign = [backUp methodSignatureForSelector:aSelector];
     使用对象本身的methodSignatureForSelector自动获取该SEL对应类别的签名
    */
    
    //如果返回为nil则进行手动创建签名
    NSString *methodName = NSStringFromSelector(aSelector);
    if([methodName isEqualToString:@"sayMessage4:"]){
        // 返回IMP的方法签名
        // 如果返回为nil则进行手动创建签名
        if ([super methodSignatureForSelector:aSelector]==nil) {
            NSMethodSignature * sign = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
            return sign;
        }
    }
    
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL sel = [anInvocation selector];
    RKSpireWheel *tmpObj = [[RKSpireWheel alloc] init];
    if([tmpObj respondsToSelector:sel]){
        [anInvocation invokeWithTarget:tmpObj];
    }else{
        [super forwardInvocation:anInvocation];
    }
}

#pragma mark - 找不到该方法

- (void)doesNotRecognizeSelector:(SEL)aSelector{
    NSLog(@"RKGirlFriend：找不到该方法");
}

@end
