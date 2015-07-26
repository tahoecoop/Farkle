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
    if (self = [super init])
    {
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

        for (Dice *dice in consideredDice)
        {
            if (dice.value == i)
            {
                numberOfDiceOfValueI++;
            }
        }
        NSNumber *total = [NSNumber numberWithInteger:numberOfDiceOfValueI];
        [scoringArray addObject:total];
    }

    // Calling scoring methods
    
    self.provisionalScore = 0;
    self.provisionalScore += [self complexScoring:scoringArray];

    if (self.provisionalScore == 0)
    {
        self.provisionalScore += [self basicScoring:scoringArray];
    }
    return self.provisionalScore;
}

-(NSInteger)complexScoring:(NSMutableArray *)scoringArray
{
    NSInteger score = 0;
    NSInteger straightCounter = 0;
    NSInteger fourCounter = 0;
    NSInteger twoCounter = 0;
    NSInteger twoTripletsCounter = 0;

    for (int i = 0; i < 6; i++)
    {
        NSLog(@"--------------outForLoopBegin");
        NSNumber *numberOfDiceAtValue = scoringArray[i];
        NSInteger numberOfDice = [numberOfDiceAtValue intValue];


        NSLog(@"value at current dice position: %i", i);
        NSLog(@"number of dice at postion i : %li", numberOfDice);
        NSLog(@"CURRENT SCORE: %li", score);

        if (numberOfDice == 1)
        {
            straightCounter += 1;
        }
        else if (numberOfDice == 4)
        {
            fourCounter += 1;
            NSLog(@"FourCounter: %li", fourCounter);
        }
        else if (numberOfDice == 2)
        {
            twoCounter += 1;
            NSLog(@"TwoCounter: %li", twoCounter);
        }
        else if (numberOfDice == 3)
        {
            twoTripletsCounter += 1;
            NSLog(@"TwoTriplets: %li", twoTripletsCounter);
        }
    }

    if (straightCounter == 6)
    {
        score = score + (1500);
        NSLog(@"$$$$STRAIGHT$$$$$");
    }
    else if (fourCounter == 1 && twoCounter == 1)
    {
        score = score + (1500);
        NSLog(@"$$$$4AND2$$$$$");
    }
    else if (twoTripletsCounter == 2)
    {
        score = score + (1500);
        NSLog(@"$$$$TWOTRIPLETS$$$$$");
    }
    else if (twoCounter == 3)
    {
        score = score + (1500);
        NSLog(@"$$$$3PAIRS$$$$$");
    }

    return score;
}


-(NSInteger)basicScoring:(NSMutableArray *)scoringArray
{
    NSInteger score = 0;
    NSLog(@"0000000000000000000000000000000000");
    for (int i = 0; i < 6; i++)
    {
        NSLog(@"--------------outForLoopBegin");
        NSNumber *numberOfDiceAtValue = scoringArray[i];
        NSInteger numberOfDice = [numberOfDiceAtValue intValue];
        BOOL detectedFirstTriple = NO;

           NSLog(@"value at current dice position: %i", i);
       NSLog(@"number of dice at postion i : %li", numberOfDice);
       NSLog(@"CURRENT SCORE: %li", score);
        if (numberOfDice == 6)
        {
            if(i == 0)
            {
                score = score + (8000);
                NSLog(@"6 ones: %li", score);
        
            }
            else
            {
                score = score + (800 * (i + 1));
                NSLog(@"6 other than ones: %li", score);
            }
        }
        else if (numberOfDice == 5)
        {
            if(i == 0)
            {
                score = score + (4000);
                NSLog(@"5 ones: %li", score);
            }
            else
            {
                score = score + (400 * (i + 1));
                NSLog(@"5 other than ones: %li", score);
            }
        }
        else if (numberOfDice == 4)
        {
            if(i == 0)
            {
                score = score + (2000);
                NSLog(@"4 ones: %li", score);
            }
            else
            {
                score = score + (200 * (i + 1));
                NSLog(@"4 other than ones: %li", score);
            }
        }
        else if (numberOfDice == 3)
        {
            if(i == 0)
            {
                score = score + 1000;
                NSLog(@"3 ones: %li", score);
            }
            else
            {
                score = score + (100 * (i + 1));
                NSLog(@"3 other than ones: %li", score);
            }

            if (detectedFirstTriple)
            {
                score = score + 300;
                NSLog(@"3 ones, first detected triple: %li", score);
            }
            detectedFirstTriple = YES;
        }
        else if (numberOfDice == 2)
        {
            if (i == 0)
            {
                score = score + 200;
                NSLog(@"2 ones: %li", score);
            }
            else if (i == 4)
            {
                score = score + 100;
                NSLog(@"2 other than ones: %li", score);
            }
        }
        else if (numberOfDice == 1)
        {
            if (i == 0)
            {
                
                score = score + 100;
                NSLog(@"1 one: %li", score);
            }
            else if (i == 4)
            {
                score = score + 50;
                NSLog(@"1 other than one: %li", score);
            }
        }
    }
    return score;
}

@end
