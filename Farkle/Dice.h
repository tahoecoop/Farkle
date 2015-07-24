//
//  Dice.h
//  Farkle
//
//  Created by Benjamin COOPER on 7/23/15.
//  Copyright (c) 2015 Ben Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dice : NSObject

@property (nonatomic) NSInteger value;
@property BOOL isLocked;
@property (nonatomic, assign) NSInteger lockedOnRoll;

- (instancetype)initWithDefaults;

@end
