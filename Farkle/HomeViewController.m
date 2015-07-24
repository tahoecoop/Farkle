//
//  HomeViewController.m
//  Farkle
//
//  Created by Benjamin COOPER on 7/23/15.
//  Copyright (c) 2015 Ben Cooper. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *playerListTableView;
@property (weak, nonatomic) IBOutlet UITextField *playerNameTextField;
@property (nonatomic, strong) NSMutableArray *playersArray;


@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.playersArray = [[NSMutableArray alloc] init];

}

- (IBAction)onAddPlayerButtonPressed:(UIButton *)button
{
    Player *player = [[Player alloc] initWithName:self.playerNameTextField.text];
    [self.playersArray addObject:player];
    [self.playerListTableView reloadData];
    self.playerNameTextField.text = nil;
    [self.playerNameTextField resignFirstResponder];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.playersArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Player *player = [self.playersArray objectAtIndex:indexPath.row];

    cell.textLabel.text = player.name;

    return cell;
}

- (IBAction)onStartGameButtonPressed:(UIButton *)sender
{
    NSArray *players = [self.playersArray copy];
    Game *game = [[Game alloc] initWithPlayers:players];
    self.game = game;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PlayViewController *VC = segue.destinationViewController;
    VC.game = self.game;
}



@end
