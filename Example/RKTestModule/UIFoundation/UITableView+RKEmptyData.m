//
//  UITableView+RKEmptyData.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2021/6/18.
//  Copyright © 2021 beedroid. All rights reserved.
//

#import "UITableView+RKEmptyData.h"
#include <objc/runtime.h>

@implementation UITableView (RKEmptyData)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(self, @selector(reloadData));
        Method currentMethod = class_getInstanceMethod(self, @selector(lg_reloadData));
        method_exchangeImplementations(originalMethod, currentMethod);
    });
    
}
- (void)lg_reloadData{
    // need to call original reloadData function at first
    [self lg_reloadData];
    [self fillDefaultView];
}
- (void)fillDefaultView{
    
    // lazy create lgDefaultView
    if(self.lgDefaultView == nil){
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nodata.jpg"]];
        iv.frame = CGRectMake(0, 0, 200, 200);
        iv.center = self.center;
        [self addSubview:iv];
        self.lgDefaultView = iv;
    }
    
    id<UITableViewDataSource> dataSource = self.dataSource;
    
    NSInteger sectionNum = 1;
    if([dataSource respondsToSelector:@selector(numberOfSections)]){
        sectionNum = [dataSource numberOfSectionsInTableView:self];
    }
    
    NSInteger rowNum = 0;
    for(NSInteger i=0; i<sectionNum; i++){
        rowNum += [dataSource tableView:self numberOfRowsInSection:i];
    }
    
    if(rowNum == 0){
        // draw default picture for tableview
        self.lgDefaultView.hidden = NO;
    }else{
        self.lgDefaultView.hidden = YES;
    }
    
}

# pragma mark - Setter&Getter
static NSString *LGDefaultView = @"LGDefaultView";
- (void)setLgDefaultView:(UIView *)lgDefaultView{
    objc_setAssociatedObject(self, &LGDefaultView, lgDefaultView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)lgDefaultView{
    return objc_getAssociatedObject(self, &LGDefaultView);
}
@end
