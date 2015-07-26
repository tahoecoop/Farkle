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


@property (weak, nonatomic) IBOutlet UILabel *dieOne;
@property (weak, nonatomic) IBOutlet UILabel *dieTwo;
@property (weak, nonatomic) IBOutlet UILabel *dieThree;
@property (weak, nonatomic) IBOutlet UILabel *dieFour;
@property (weak, nonatomic) IBOutlet UILabel *dieFive;
@property (weak, nonatomic) IBOutlet UILabel *dieSix;
@property (nonatomic) NSArray *arrayOfLabels;

@property (weak, nonatomic) IBOutlet UILabel *turnScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLabel;
@property NSMutableArray *arrayOfLabelOriginalPoints;

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic) BOOL areLabelsFannedOut;
@property (weak, nonatomic) IBOutlet UIButton *rollDiceButton;



@end

@implementation PlayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpLabelArray];
    [self addTurnToEveryPlayer];

    NSArray *players = self.game.players;
    Player *firstPlayer = [players objectAtIndex:0];
    self.currentPlayer = firstPlayer;

    Turn *turn = [firstPlayer.turns objectAtIndex:0];

    [self setUpFakeDiceValues:turn];

    [self updateDiceView:turn];

    [self.rollDiceButton addTarget:self action:@selector(fanLabels:) forControlEvents:UIControlEventTouchUpInside];
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    self.dieOne.layer.masksToBounds = YES;
    self.dieOne.layer.cornerRadius = 10;
    self.dieTwo.layer.masksToBounds = YES;
    self.dieTwo.layer.cornerRadius = 10;
    self.dieThree.layer.masksToBounds = YES;
    self.dieThree.layer.cornerRadius = 10;
    self.dieFour.layer.masksToBounds = YES;
    self.dieFour.layer.cornerRadius = 10;
    self.dieFive.layer.masksToBounds = YES;
    self.dieFive.layer.cornerRadius = 10;
    self.dieSix.layer.masksToBounds = YES;
    self.dieSix.layer.cornerRadius = 10;

    self.areLabelsFannedOut = YES;

//    [self storeLabelOrigins];
}

//-(void)storeLabelOrigins {
//    self.arrayOfLabelOriginalPoints = [[NSMutableArray alloc] init];
//    for (UILabel* label in self.arrayOfLabels) {
//        CGPoint origin = CGPointMake(label.frame.origin.x, label.frame.origin.y);
//        [self.arrayOfLabelOriginalPoints addObject:[NSValue valueWithCGPoint:origin]];
//    }
//
//}

-(void)setUpFakeDiceValues:(Turn *)turn
{
    ((Dice *)([turn.dice objectAtIndex:0])).value = 1;
    ((Dice *)([turn.dice objectAtIndex:1])).value = 1;
    ((Dice *)([turn.dice objectAtIndex:2])).value = 5;
    ((Dice *)([turn.dice objectAtIndex:3])).value = 5;
    ((Dice *)([turn.dice objectAtIndex:4])).value = 5;
    ((Dice *)([turn.dice objectAtIndex:5])).value = 5;
}

- (IBAction)onDiceRollButtonPressed:(UIButton *)sender
{

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

        label.tag = i;
        [label setUserInteractionEnabled:YES];

        UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onLabelTap:)];
        [label addGestureRecognizer:labelTap];
    }
}


-(void)setUpLabelArray
{
    NSArray *arrayOfLabels = [[NSArray alloc] initWithObjects:self.dieOne, self.dieTwo, self.dieThree, self.dieFour, self.dieFive, self.dieSix, nil];
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
    NSLog(@"FINAL SCORE****%li", [turn evaluateSelectedDiceForPoints]);
}

- (IBAction)onRollDiceButtonPressed:(UIButton *)sender
{
    
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
    UISnapBehavior *snapBehavior;
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieOne snapToPoint:self.rollDiceButton.center];
    [self.dynamicAnimator addBehavior:snapBehavior];

    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieTwo snapToPoint:self.rollDiceButton.center];
    [self.dynamicAnimator addBehavior:snapBehavior];

    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieThree snapToPoint:self.rollDiceButton.center];
    [self.dynamicAnimator addBehavior:snapBehavior];

    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieFour snapToPoint:self.rollDiceButton.center];
    [self.dynamicAnimator addBehavior:snapBehavior];

    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieFive snapToPoint:self.rollDiceButton.center];
    [self.dynamicAnimator addBehavior:snapBehavior];

    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieSix snapToPoint:self.rollDiceButton.center];
    [self.dynamicAnimator addBehavior:snapBehavior];
}

-(void)fanOut
{
    CGPoint point;
    UISnapBehavior *snapBehavior;

    point = CGPointMake(self.rollDiceButton.frame.origin.x - (40 + arc4random() %30), self.rollDiceButton.frame.origin.y - (200 + arc4random() %30));
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieOne snapToPoint:point];
    [self.dynamicAnimator addBehavior:snapBehavior];

    point = CGPointMake(self.rollDiceButton.frame.origin.x + (60 + arc4random() %30), self.rollDiceButton.frame.origin.y - (190 + arc4random() %30));
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieTwo snapToPoint:point];
    [self.dynamicAnimator addBehavior:snapBehavior];

    point = CGPointMake(self.rollDiceButton.frame.origin.x + (190 + arc4random() %30), self.rollDiceButton.frame.origin.y - (200 + arc4random() %30));
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieThree snapToPoint:point];
    [self.dynamicAnimator addBehavior:snapBehavior];

    point = CGPointMake(self.rollDiceButton.frame.origin.x - (40 + arc4random() %30), self.rollDiceButton.frame.origin.y - (60 + arc4random() %30));
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieFour snapToPoint:point];
    [self.dynamicAnimator addBehavior:snapBehavior];

    point = CGPointMake(self.rollDiceButton.frame.origin.x + (60 + arc4random() %30), self.rollDiceButton.frame.origin.y - (60 + arc4random() %30));
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieFive snapToPoint:point];
    [self.dynamicAnimator addBehavior:snapBehavior];

    point = CGPointMake(self.rollDiceButton.frame.origin.x + (190 + arc4random() %30), self.rollDiceButton.frame.origin.y - (60 + arc4random() %30));
    snapBehavior = [[UISnapBehavior alloc] initWithItem:self.dieSix snapToPoint:point];
    [self.dynamicAnimator addBehavior:snapBehavior];
}

@end
