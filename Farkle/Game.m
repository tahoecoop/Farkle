//
//  Game.m
//  Farkle
//
//  Created by Benjamin COOPER on 7/23/15.
//  Copyright (c) 2015 Ben Cooper. All rights reserved.
//

#import "Game.h"

@implementation Game

-(instancetype) initWithPlayers:(NSArray *)players
{
    if (self = [super init])
    {
        _players = players;
        _winningScore = 10000;
    }
    return self;
}

@end
