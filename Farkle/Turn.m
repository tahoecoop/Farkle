//
//  Turn.m
//  Farkle
//
//  Created by Benjamin COOPER on 7/23/15.
//  Copyright (c) 2015 Ben Cooper. All rights reserved.
//

#import "Turn.h"

@implementation Turn

-(instancetype) initWithDice
{
    if (self = [super init]) {

        _dice = @[[[Dice alloc]initWithDefaults],
                  [[Dice alloc]initWithDefaults],
                  [[Dice alloc]initWithDefaults],
                  [[Dice alloc]initWithDefaults],
                  [[Dice alloc]initWithDefaults],
                  [[Dice alloc]initWithDefaults]];
        _provisionalScore = 0;
    }
    return self;
}

@end
