//
//  RKDefines.h
//  Pods
//
//  Created by 贾晓滨 on 2021/7/10.
//

#ifndef RKDefines_h
#define RKDefines_h

#ifndef RKModuleSectionName

#define RKModuleSectionName @"RKModules"

#endif

#ifndef RKServiceSectionName

#define RKServiceSectionName @"RKServices"

#endif


#define RKDATA(sectname) __attribute((used, section("__DATA,"#sectname" ")))

// char * kAModule_module __attribute((used, section("__DATA,""RKModules"" "))) = """AModule""";
#define RKModule(moduleName) \
class RKContainer; char * k##moduleName##_module RKDATA(RKModules) = ""#moduleName"";

// char * kAService_service __attribute((used, section("__DATA,""RKServices"" "))) = """AService""""
#define RKService(serviceName, serviceIMP) \
class RKContainer; char * k##servicename##_service RKDATA(RKServices) = "{ \""#serviceName"\" : \""#serviceIMP"\"}";


/**
 *  成功block
 *
 */
typedef void (^RKSuccessBlock)(id result);

/**
 *  失败block
 *
 */
typedef void (^RKFailBlock)(NSError *error);

#endif /* RKDefines_h */
