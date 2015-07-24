//
//  Game.h
//  Farkle
//
//  Created by Benjamin COOPER on 7/23/15.
//  Copyright (c) 2015 Ben Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

@property (nonatomic) NSArray *players;
@property (nonatomic) NSInteger winningScore;

-(instancetype) initWithPlayers:(NSArray *)players;

@end
