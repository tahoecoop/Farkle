//
//  Player.m
//  Farkle
//
//  Created by Benjamin COOPER on 7/23/15.
//  Copyright (c) 2015 Ben Cooper. All rights reserved.
//

#import "Player.h"

@implementation Player

-(instancetype) initWithName:(NSString *)name
{
    if (self = [super init])
    {
        _name = name;
        _turns = [[NSMutableArray alloc] init];
        _totalScore = 0;
    }
    return self;
}



@end
