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

-(NSInteger)evaluateSelectedDiceForPoints
{
    NSMutableArray *consideredDice = [[NSMutableArray alloc] init];

    // Selecting only dice that the user has selected

    for (Dice *dice in self.dice)
    {
        if (dice.isUnderConsideration)
        {
            [consideredDice addObject:dice];
        }
    }

    //Preparing our scoring data structure for analysis
    NSMutableArray *scoringArray = [[NSMutableArray alloc] init];
    for (int i=1; i<=6; i++)
    {
        NSInteger numberOfDiceOfValueI = 0;

        for (Dice *dice in consideredDice) {
            if (dice.value == i) {
                numberOfDiceOfValueI++;
            }
        }
        NSNumber *total = [NSNumber numberWithInteger:numberOfDiceOfValueI];
        [scoringArray addObject:total];
    }

    // Calling scoring methods
    self.provisionalScore += [self basicScoring:scoringArray];

    return self.provisionalScore;
}

-(NSInteger)basicScoring:(NSMutableArray *)scoringArray {


    NSInteger score = 0;

    for (int i = 0; i < 6; i++) {
        NSNumber *numberOfDiceAtValue = scoringArray[i];
        NSInteger numberOfDice = [numberOfDiceAtValue intValue];
        BOOL detectedFirstTriple = NO;

        if (numberOfDice == 6) {
            if(i == 0) {
                score = score + (8000);
            } else {
                score = score + (800 * (i + 1));
            }
        }
        else if (numberOfDice == 5) {
            if(i == 0) {
                score = score + (4000);
            } else {
                score = score + (400 * (i + 1));
            }
        }
        else if (numberOfDice == 4) {
            if(i == 0) {
                score = score + (2000);
            } else {
                score = score + (200 * (i + 1));
            }
        }
        else if (numberOfDice == 3) {
            if(i == 0) {
                score = score + 1000;
            } else {
                score = score + (100 * (i + 1));
            }
            if (detectedFirstTriple) { score = score + 300; }
            detectedFirstTriple = YES;
        }
        else if (numberOfDice == 1) {
            if (i == 0) {
                score = score + 100;
            }
            else if (i == 4) {
                score = score + 50;
            }
        }
    }
    return score;
}

@end
