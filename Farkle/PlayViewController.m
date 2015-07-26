//
//  ViewController.m
//  Farkle
//
//  Created by Benjamin COOPER on 7/23/15.
//  Copyright (c) 2015 Ben Cooper. All rights reserved.
//

#import "PlayViewController.h"

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

    //access the turns dice and set the properties of the dice to set value
    //create method that accepts a turn as a property and allows me to set the every dice to an arbitrary value. returns void

    [self setUpFakeDiceValues:turn];
    

    [self updateDiceView:turn];

}

-(void)setUpFakeDiceValues:(Turn *)turn
{
    Dice *dice1 = [[Dice alloc] init];

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




@end
