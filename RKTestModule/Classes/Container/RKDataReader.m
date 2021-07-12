//
//  RKDataReader.m
//  RKMicAppContainerModule
//
//  Created by 贾晓滨 on 2021/6/29.
//

#import "RKDataReader.h"
#import "RKContainerUtils.h"
#include <mach-o/getsect.h>
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <dlfcn.h>

static NSString *configuration = @"";
const struct mach_header_64 *machHeader = NULL;

@interface RKDataReader()

@end

@implementation RKDataReader

__attribute__((constructor))
void initProphet() {
    _dyld_register_func_for_add_image(dyld_callback);
}

static void dyld_callback(const struct mach_header *mhp, intptr_t vmaddr_slide)
{
    NSArray *mods = BHReadConfiguration("RKModules", mhp);
    if(mods.count>0){
        NSLog(@"-JXB---%@",mods);
    }
}

NSArray<NSString *>* BHReadConfiguration(char *sectionName,const struct mach_header *mhp)
{
    NSMutableArray *configs = [NSMutableArray array];
    unsigned long size = 0;
    const struct mach_header_64 *mhp64 = (const struct mach_header_64 *)mhp;
    uintptr_t *memory = (uintptr_t*)getsectiondata(mhp64, SEG_DATA, sectionName, &size);
    
    unsigned long counter = size/sizeof(void*);
    for(int idx = 0; idx < counter; ++idx){
        char *string = (char*)memory[idx];
        NSString *str = [NSString stringWithUTF8String:string];
        if(!str)continue;
        if(str) [configs addObject:str];
    }
    
    return configs;
}

//获取data段数据
+ (NSMutableArray *)readConfigFromSectionName:(NSString *)sectionName
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
    if ([RKContainerUtils validateString:sectionName])
    {
        if (machHeader == NULL)
        {
            Dl_info info;
            dladdr((__bridge const void *)(configuration), &info);
            machHeader = (struct mach_header_64*)info.dli_fbase;
        }
        unsigned long size = 0;
        uintptr_t *memory = (uintptr_t*)getsectiondata(machHeader, SEG_DATA, [sectionName UTF8String], &size);
        
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
