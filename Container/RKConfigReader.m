//
//  RKConfigReader.m
//  AFNetworking
//
//  Created by 贾晓滨 on 2021/7/10.
//

#import "RKConfigReader.h"
#import "RKUtils.h"
#include <mach-o/getsect.h>
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <dlfcn.h>

static NSString *configuration = @"";
const struct mach_header_64 *machHeader = NULL;
static  NSMutableDictionary *aresConfigs = nil;

@interface RKConfigReader()

@end

@implementation RKConfigReader
//获取data段数据
+ (NSMutableArray *)readConfigFromSectionName:(NSString *)sectionName
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
    if ([RKUtils validateString:sectionName])
    {
        if (machHeader == NULL)
        {
            Dl_info info;
            dladdr((__bridge const void *)(configuration), &info);
            machHeader = (struct mach_header_64*)info.dli_fbase;
        }
        unsigned long size = 0;
        uintptr_t *memory = (uintptr_t*)getsectiondata(machHeader, SEG_DATA, [sectionName UTF8String], & size);
        
        NSUInteger counter = size/sizeof(void*);
        for(int idx = 0; idx < counter; ++idx){
            char *string = (char*)memory[idx];
            
            NSString *str = [NSString stringWithUTF8String:string];
            [result addObject:str];
            
        }
    }
    return result;
}
@end
