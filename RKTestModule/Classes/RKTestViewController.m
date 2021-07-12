//
//  RKTestViewController.m
//  Pods-RKTestModule_Example
//
//  Created by 贾晓滨 on 2019/12/26.
//

#import "RKTestViewController.h"
#import "RKDefines.h"

//@RKModule(HomeModule)
//@RKModule(ChatModule)
//@RKModule(ContactsModule)
//@RKModule(DiscoverModule)
//@RKModule(MineModule)
//@RKModule(AAModule)
//char * kAModule_module __attribute((used, section("__DATA,""RKModules"" "))) = """b""";
// char * kBModule_module __attribute((used, section("__DATA,""RKModules"" "))) = """b1""";
// char * kCModule_module __attribute((used, section("__DATA,""RKModules"" "))) = """b2""";
//@RKModule(RKTechModule)

@interface RKTestViewController ()

@end

@implementation RKTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor= [UIColor cyanColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    [label setTextColor:[UIColor redColor]];
    [label setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:label];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
