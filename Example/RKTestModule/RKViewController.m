//
//  RKViewController.m
//  RKTestModule
//
//  Created by beedroid on 12/26/2019.
//  Copyright (c) 2019 beedroid. All rights reserved.
//

#import "RKViewController.h"
#import <RKContainer.h>
#import <RKDefines.h>

//char * kAModule_module __attribute((used, section("__DATA,""RKModules2"" "))) = """AModule""";
//char * kBModule_module __attribute((used, section("__DATA,""RKModules"" "))) = """a""";

char * kAModule_module111 __attribute((used, section("__DATA,""RKModules"" "))) = """b0""";

//char * kCModule_module __attribute((used, section("__DATA,""RKModules2"" "))) = """CModule""";
//
//char * kTest2Service_service __attribute((used, section("__DATA,""RKServices2"" "))) = "{\"EXRKTest2Protocol\":\"Test2Service\"}";
//char * kTest3Service_service __attribute((used, section("__DATA,""RKServices2"" "))) = "{\"EXRKTest3Protocol\":\"Test3Service\"}";
//@class RKContainer; char * kBModule_module __attribute((used, section("__DATA,""RKModules"" "))) = """BModule""";

@interface RKViewController ()
@end

@implementation RKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
