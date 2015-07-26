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

        UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onLabelTap:)];
        [label addGestureRecognizer:labelTap];
    }
}


-(void)setUpLabelArray
{
    NSMutableArray *arrayOfLabels = [[NSMutableArray alloc] init];
    for(int i = 0; i < 6; i++) {
        CGRect labelRect = CGRectMake(self.rollDiceButton.frame.origin.x, self.rollDiceButton.frame.origin.y, 20, 20);
        UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 10;
        [self.arrayOfLabels addObject:label];
    }
    self.arrayOfLabels = arrayOfLabels;

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

    NSArray *arrayOfSnapPoints = [[NSArray alloc] initWithObjects:
        CGPointMake(self.rollDiceButton.frame.origin.x - (40 + arc4random() %30), self.rollDiceButton.frame.origin.y - (200 + arc4random() %30)),
        CGPointMake(self.rollDiceButton.frame.origin.x + (60 + arc4random() %30), self.rollDiceButton.frame.origin.y - (190 + arc4random() %30)),
        CGPointMake(self.rollDiceButton.frame.origin.x + (190 + arc4random() %30), self.rollDiceButton.frame.origin.y - (200 + arc4random() %30)),
        CGPointMake(self.rollDiceButton.frame.origin.x - (40 + arc4random() %30), self.rollDiceButton.frame.origin.y - (60 + arc4random() %30)),
        CGPointMake(self.rollDiceButton.frame.origin.x + (60 + arc4random() %30), self.rollDiceButton.frame.origin.y - (60 + arc4random() %30)),
        CGPointMake(self.rollDiceButton.frame.origin.x + (190 + arc4random() %30), self.rollDiceButton.frame.origin.y - (60 + arc4random() %30)),
                                  nil];

    nil

    point = ;
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieOne snapToPoint:point];
    [self.dynamicAnimator addBehavior:snapBehavior];

    point = ;
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieTwo snapToPoint:point];
    [self.dynamicAnimator addBehavior:snapBehavior];

    point = ;
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieThree snapToPoint:point];
    [self.dynamicAnimator addBehavior:snapBehavior];

    point = ;
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieFour snapToPoint:point];
    [self.dynamicAnimator addBehavior:snapBehavior];

    point =
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieFive snapToPoint:point];
    [self.dynamicAnimator addBehavior:snapBehavior];

    point = ;
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieSix snapToPoint:point];
    [self.dynamicAnimator addBehavior:snapBehavior];
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
