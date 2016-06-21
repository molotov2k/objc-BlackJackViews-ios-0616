//
//  FISBlackjackViewController.h
//  objc-BlackJackViews
//
//  Created by Max Tkach on 6/21/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISBlackjackGame.h"

@interface FISBlackjackViewController : UIViewController

@property (strong, nonatomic) FISBlackjackGame *game;

@property (weak, nonatomic) IBOutlet UILabel *winnerLabel;

@property (weak, nonatomic) IBOutlet UILabel *houseLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseStayedLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseWinsLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseLossesLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseBustedLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseBlackjackLabel;

@property (weak, nonatomic) IBOutlet UILabel *playerLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerStayedLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerWinsLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerLossesLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerBustedLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerBlackjackLabel;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;


@property (weak, nonatomic) IBOutlet UIButton *hitButton;
@property (weak, nonatomic) IBOutlet UIButton *stayButton;




@property (strong, nonatomic) NSArray *cardLabels;
@property (weak, nonatomic) IBOutlet UILabel *houseCard1Label;
@property (weak, nonatomic) IBOutlet UILabel *houseCard2Label;
@property (weak, nonatomic) IBOutlet UILabel *houseCard3Label;
@property (weak, nonatomic) IBOutlet UILabel *houseCard4Label;
@property (weak, nonatomic) IBOutlet UILabel *houseCard5Label;
@property (weak, nonatomic) IBOutlet UILabel *playerCard1Label;
@property (weak, nonatomic) IBOutlet UILabel *playerCard2Label;
@property (weak, nonatomic) IBOutlet UILabel *playerCard3Label;
@property (weak, nonatomic) IBOutlet UILabel *playerCard4Label;
@property (weak, nonatomic) IBOutlet UILabel *playerCard5Label;






@end
