//
//  Player.h
//  Farkle
//
//  Created by Benjamin COOPER on 7/23/15.
//  Copyright (c) 2015 Ben Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSInteger totalScore;
@property (nonatomic, strong) NSMutableArray *turns;

-(instancetype) initWithName:(NSString *)name;

@end
