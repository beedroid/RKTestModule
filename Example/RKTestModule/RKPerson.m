//
//  RKPerson.m
//  RKTestModule_Example
//
//  Created by 贾晓滨 on 2021/4/25.
//  Copyright © 2021 beedroid. All rights reserved.
//

#import "RKPerson.h"

@implementation RKPerson {
    int _score;
}

- (id)copyWithZone:(nullable NSZone *)zone{
    RKPerson *person = [[[self class] allocWithZone:zone] init];
    person.score = self.score;
    return person;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone{
    return self;
}


@end
