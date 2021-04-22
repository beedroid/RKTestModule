//
//  RKClient.m
//  RKBaseModule
//
//  Created by 贾晓滨 on 2020/1/2.
//

#import "RKClient.h"
//model
#import <sys/utsname.h>
//idfa
#import <AdSupport/AdSupport.h>
#import "RKUserDefault.h"
#import "RKGlobalValue.h"
#import "UIDevice+IdentifierAddition.h"

#define phoneTrackid @"123"
#define phoneTrackName @"appstore_iphone"

#define padTrackid @"10442025702"
#define padTrackName @"appstore_ipad"

@implementation RKClient

DEF_SINGLETON(RKClient)

- (id)init {
    self = [super init];
    if (self) {
        _clientAppVersion = [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        _clientVersion = [[UIDevice currentDevice] systemVersion];
        _deviceCode = [NSString stringWithString:[[UIDevice currentDevice] uniqueDeviceIdentifier]];
        _unionKey = phoneTrackid;

        if (IS_IPHONE_DEVICE) {
            _unionKey = phoneTrackid;
            _clientSystem = @"iPhone";
            
        }else {
            _unionKey = padTrackid;
            _clientSystem = @"ipad";
        }
}
    
    return self;
}


- (NSString *)idfa{
    if ([ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString!=nil) {
        return [ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString;
    }
    return _idfa;
}

- (void)setLongitude:(NSNumber *)longitude
{
    _longitude = longitude;
}

- (void)setLatitude:(NSNumber *)latitude
{
    _latitude = latitude;
}

- (NSString*) phoneType
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    static NSDictionary* deviceNamesByCode = nil;
    
    if (!deviceNamesByCode) {
        
        deviceNamesByCode = @{
                              
                              @"i386"      :@"Simulator",
                              @"x86_64"    :@"Simulator",
                              
                              @"iPod1,1"   :@"iPod Touch ",        // (Original)
                              @"iPod2,1"   :@"iPod Touch 2G",        // (Second Generation)
                              @"iPod3,1"   :@"iPod Touch 3G",        // (Third Generation)
                              @"iPod4,1"   :@"iPod Touch 4G",        // (Fourth Generation)
                              @"iPod5,1"    :@"iPod Touch 5G",
                              @"iPod7,1"   :@"iPod Touch  6G",        // (6th Generation)
                              
                              @"iPhone1,1" :@"iPhone",            // (Original)
                              @"iPhone1,2" :@"iPhone3G",            // (3G)
                              @"iPhone2,1" :@"iPhone3GS",            // (3GS)
                              @"iPhone3,1" :@"iPhone 4",          // (GSM)
                              @"iPhone3,2" :@"iPhone 4",          // (GSM)
                              @"iPhone3,3" :@"iPhone 4",          // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" :@"iPhone 4S",         //
                              @"iPhone5,1" :@"iPhone 5",          // (model A1428, AT&T/Canada)
                              @"iPhone5,2" :@"iPhone 5",          // (model A1429, everything else)
                              @"iPhone5,3" :@"iPhone 5c",         // (model A1456, A1532 | GSM)
                              @"iPhone5,4" :@"iPhone 5c",         // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" :@"iPhone 5s",         // (model A1433, A1533 | GSM)
                              @"iPhone6,2" :@"iPhone 5s",         // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" :@"iPhone 6 Plus",     //
                              @"iPhone7,2" :@"iPhone 6",          //
                              @"iPhone8,1" :@"iPhone 6S",         //
                              @"iPhone8,2" :@"iPhone 6S Plus",    //
                              @"iPhone8,4" :@"iPhone SE",         //
                              
                              @"iPad1,1"   :@"iPad",              // (Original)
                              @"iPad2,1"   :@"iPad 2",            //（A1395）
                              @"iPad2,2"   :@"iPad 2",            // （A1396）
                              @"iPad2,3"   :@"iPad 2",            // （A1397）
                              @"iPad2,4"   :@"iPad 2",            // （A1395）
                              @"iPad3,1"   :@"iPad 3",              // (3rd Generation)A1416
                              @"iPad3,2"   :@"iPad 3",              // (3rd Generation)A1403
                              @"iPad3,3"   :@"iPad 3",              // (3rd Generation)A1430
                              @"iPad3,4"   :@"iPad 4",              // (4th Generation)A1458
                              @"iPad3,5"   :@"iPad 4",              // (4th Generation)A1459
                              @"iPad3,6"   :@"iPad 4",              // (4th Generation)A1460
                              @"iPad4,1"   :@"iPad Air",          // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   :@"iPad Air",          // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,3"   :@"iPad Air",          // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad5,3"   :@"iPad Air2",          // 5th Generation iPad (iPad Air2) - WifiA1566
                              @"iPad5,4"   :@"iPad Air2",          // 5th Generation iPad (iPad Air2) - CellularA1567
                              @"iPad2,5"   :@"iPad Mini",         // (Original)  A1432
                              @"iPad2,6"   :@"iPad Mini",         // (Original)  A1454
                              @"iPad2,7"   :@"iPad Mini",         // (Original)  A1455
                              @"iPad4,4"   :@"iPad Mini 2",         // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   :@"iPad Mini 2",         // (2nd Generation iPad Mini - Cellular)
                              @"iPad4,6"   :@"iPad Mini 2",         // (3rd Generation iPad Mini - Wifi (model A1599))
                              @"iPad4,7"   :@"iPad Mini 3",         //
                              @"iPad4,8"   :@"iPad Mini 3",         //
                              @"iPad4,9"   :@"iPad Mini 3",         //
                              @"iPad5,1"   :@"iPad Mini 4",         //
                              @"iPad5,2"   :@"iPad Mini 4",         //
                              @"iPad6,7"   :@"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1584)
                              @"iPad6,8"   :@"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1652)
                              @"iPad6,3"   :@"iPad Pro (9.7\")",  // iPad Pro 9.7 inches - (model A1673)
                              @"iPad6,4"   :@"iPad Pro (9.7\")"   // iPad Pro 9.7 inches - (models A1674 and A1675)
                              
                              };
    }
    
    NSString* phoneType = [deviceNamesByCode objectForKey:code];
    
    if (phoneType.length <= 0) {
        // Not found on database. At least guess main device type from string contents:
        
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            phoneType = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            phoneType = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            phoneType = @"iPhone";
        }
        else {
            phoneType = @"Unknown";
        }
    }
    
    return phoneType;
}
@end
