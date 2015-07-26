//
//  ViewController.m
//  Farkle
//
//  Created by Benjamin COOPER on 7/23/15.
//  Copyright (c) 2015 Ben Cooper. All rights reserved.
//

#import "PlayViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PlayViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currentPlayerTurnLabel;

@property (weak, nonatomic) IBOutlet UILabel *turnScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLabel;

@property (nonatomic) NSMutableArray *arrayOfLabels;
@property NSMutableArray *arrayOfLabelOriginalPoints;

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic) BOOL areLabelsFannedOut;
@property (weak, nonatomic) IBOutlet UIButton *rollDiceButton;

@property UIColor *diceLabelBaseColor;
@property UIColor *diceLabelSelectedColor;


@end

@implementation PlayViewController



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.diceLabelBaseColor = [UIColor grayColor];
    self.diceLabelSelectedColor = [UIColor redColor];
    [self setUpLabelArray];
    [self addTurnToEveryPlayer];

    NSArray *players = self.game.players;
    Player *firstPlayer = [players objectAtIndex:0];
    self.currentPlayer = firstPlayer;

    Turn *turn = [firstPlayer.turns objectAtIndex:0];

//    [self setUpFakeDiceValues:turn];

    [self updateDiceView:turn];

    [self.rollDiceButton addTarget:self action:@selector(fanLabels:) forControlEvents:UIControlEventTouchUpInside];
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    self.areLabelsFannedOut = NO;

}




- (void)addTurnToEveryPlayer
{
    for (Player *player in self.game.players)
    {
        Turn *turn = [[Turn alloc] initWithDice];
        [player.turns addObject:turn];
    }
}

-(void)setUpLabelArray
{
    self.arrayOfLabels = [[NSMutableArray alloc] init];
    for(int i = 0; i < 6; i++) {
        CGRect labelRect = CGRectMake(150, 430, 75, 75);
        UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 10;
        [self.arrayOfLabels addObject:label];
    }
}

-(void)updateDiceView:(Turn *)turn
{
    for (int i = 0; i < 6; i++)
    {
        UILabel *label = [self.arrayOfLabels objectAtIndex:i];
        Dice *dice = [turn.dice objectAtIndex:i];

        label.text = [NSString stringWithFormat:@"%li", dice.value];
        label.backgroundColor = self.diceLabelBaseColor;
        label.tag = i;
        [label setUserInteractionEnabled:YES];

        [self.view addSubview:label];
        [self.view sendSubviewToBack:label];
        UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onLabelTap:)];
        [label addGestureRecognizer:labelTap];
    }
}

- (void)onLabelTap:(UIGestureRecognizer *)gesture
{
    UILabel *label = (UILabel *)gesture.view;
    NSInteger *diceIndex = label.tag;

    Turn *turn = [self.currentPlayer currentTurn];
    Dice *selectedDice = [turn.dice objectAtIndex:diceIndex];

//    NSLog(@"%li", selectedDice.value);
    [selectedDice toggleUnderConsideration];
    [self toggleLabelColor:(UILabel *)label];

    NSLog(@"FINAL SCORE****%li", [turn evaluateSelectedDiceForPoints]);
}

- (void)toggleLabelColor:(UILabel *)label
{
    if (label.backgroundColor == self.diceLabelBaseColor)
    {
        label.backgroundColor = self.diceLabelSelectedColor;
    }
    else
    {
        label.backgroundColor = self.diceLabelBaseColor;
    }
}

- (void)fanLabels:(UILabel *)sender
{
    [self.dynamicAnimator removeAllBehaviors];
    if (self.areLabelsFannedOut)
    {
        [self fanIn];
    }
    else
    {
        [self fanOut];
    }
    self.areLabelsFannedOut = !self.areLabelsFannedOut;
}

-(void)fanIn
{
    for (UILabel *label in self.arrayOfLabels) {
        UISnapBehavior *snapBehavior;
        snapBehavior = [[UISnapBehavior alloc] initWithItem:label snapToPoint:self.rollDiceButton.center];
        [self.dynamicAnimator addBehavior:snapBehavior];
    }
}

-(void)fanOut
{
    CGPoint point;
    UISnapBehavior *snapBehavior;

    int bX = self.rollDiceButton.frame.origin.x;
    int bY = self.rollDiceButton.frame.origin.y;

    NSArray *arrayOfSnapPoints = [[NSArray alloc] initWithObjects:
        [NSValue valueWithCGPoint:CGPointMake(bX - (40 + arc4random() %30), bY - (200 + arc4random() %30))],
        [NSValue valueWithCGPoint:CGPointMake(bX + (60 + arc4random() %30), bY - (190 + arc4random() %30))],
        [NSValue valueWithCGPoint:CGPointMake(bX + (190 + arc4random() %30), bY - (200 + arc4random() %30))],
        [NSValue valueWithCGPoint:CGPointMake(bX - (40 + arc4random() %30), bY - (60 + arc4random() %30))],
        [NSValue valueWithCGPoint:CGPointMake(bX + (60 + arc4random() %30), bY - (60 + arc4random() %30))],
        [NSValue valueWithCGPoint:CGPointMake(bX + (190 + arc4random() %30), bY - (60 + arc4random() %30))],
                                  nil];

    for (int i = 0; i < 6; i++) {
        UILabel *label = self.arrayOfLabels[i];
        NSValue *value = arrayOfSnapPoints[i];

        CGPoint point = value.CGPointValue;
        snapBehavior = [[UISnapBehavior alloc] initWithItem:label snapToPoint: point];
        [self.dynamicAnimator addBehavior:snapBehavior];
    }
}

#pragma mark - testing methods

//-(void)setUpFakeDiceValues:(Turn *)turn
//{
//    ((Dice *)([turn.dice objectAtIndex:0])).value = 1;
//    ((Dice *)([turn.dice objectAtIndex:1])).value = 1;
//    ((Dice *)([turn.dice objectAtIndex:2])).value = 5;
//    ((Dice *)([turn.dice objectAtIndex:3])).value = 5;
//    ((Dice *)([turn.dice objectAtIndex:4])).value = 5;
//    ((Dice *)([turn.dice objectAtIndex:5])).value = 5;
//}


@end
