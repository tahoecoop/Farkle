//
//  Turn.h
//  Farkle
//
//  Created by Benjamin COOPER on 7/23/15.
//  Copyright (c) 2015 Ben Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dice.h"

@interface Turn : NSObject

@property (nonatomic) NSInteger provisionalScore;
@property (nonatomic) NSArray *dice;

-(instancetype) initWithDice;

@end
