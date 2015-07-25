//
//  Dice.m
//  Farkle
//
//  Created by Benjamin COOPER on 7/23/15.
//  Copyright (c) 2015 Ben Cooper. All rights reserved.
//

#import "Dice.h"


@implementation Dice

- (instancetype)initWithDefaults
{
    if (self = [super init])
    {
        _isLocked = NO;
        _value = arc4random() %6 + 1;
    }
    return  self;
}

- (void)toggleUnderConsideration
{
    self.isUnderConsideration = !self.isUnderConsideration;
}

@end
