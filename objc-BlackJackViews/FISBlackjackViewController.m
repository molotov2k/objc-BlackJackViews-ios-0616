//
//  FISBlackjackViewController.m
//  objc-BlackJackViews
//
//  Created by Max Tkach on 6/21/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackViewController.h"

@implementation FISBlackjackViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.game = [[FISBlackjackGame alloc] init];
    self.cardLabels = [[NSArray alloc] initWithObjects: self.playerCard1Label,
                                                        self.playerCard2Label,
                                                        self.playerCard3Label,
                                                        self.playerCard4Label,
                                                        self.playerCard5Label,
                                                        self.houseCard1Label,
                                                        self.houseCard2Label,
                                                        self.houseCard3Label,
                                                        self.houseCard4Label,
                                                        self.houseCard5Label,
                                                        nil];
}


- (IBAction)dealButtonPressed:(id)sender {
    [self prepareForNewRound];
    [self.game dealNewRound];
    [self updateLabels];
    [self updateButtonStatesAfterNewDeal];

}

- (IBAction)playerHitButtonPressed:(id)sender {
    [self.game dealCardToPlayer];
    if (!self.game.player.busted) {
//        self.hitButton.enabled = false;
//        self.stayButton.enabled = false;
        [self.game processHouseTurn];
    }
    [self updateLabels];
    if (self.game.player.busted || self.game.house.busted) {
        [self winUpdates];
    }
}

- (IBAction)playerStayButtonPressed:(id)sender {
    self.playerStayedLabel.hidden = false;
    self.hitButton.enabled = false;
    self.stayButton.enabled = false;
    while (self.game.house.shouldHit && self.game.house.cardsInHand.count < 6) {
        [self.game processHouseTurn];
        [self updateLabels];
    }
//    while (self.game.house.handscore < self.game.player.handscore && !self.game.house.stayed &&
//           !self.game.house.busted && self.game.house.cardsInHand.count < 6) {
//        [self.game dealCardToHouse];
//        [self.game processHouseTurn];
//        [self updateLabels];
//    }
    [self winUpdates];
}

- (void)prepareForNewRound {
    for (UILabel *card in self.cardLabels) {
        card.hidden = true;
    }
    self.playerScoreLabel.hidden = true;
    self.houseScoreLabel.hidden = true;
    self.hitButton.enabled = false;
    self.stayButton.enabled = false;
    self.dealButton.enabled = true;
    self.playerStayedLabel.hidden = true;
    self.houseStayedLabel.hidden = true;
    self.playerBustedLabel.hidden = true;
    self.houseBustedLabel.hidden = true;
    self.playerBlackjackLabel.hidden = true;
    self.houseBlackjackLabel.hidden = true;
    self.winnerLabel.hidden = true;
    [self updateWinsAndLosses];
}

- (void)showCards {
    for (NSUInteger i = 0; i < self.game.player.cardsInHand.count; i++) {
        UILabel *cardLabel = self.cardLabels[i];
        cardLabel.hidden = false;
        cardLabel.text = [self.game.player.cardsInHand[i] cardLabel];
    }
    for (NSUInteger i = 5; i < self.game.house.cardsInHand.count + 5; i++) {
        UILabel *cardLabel = self.cardLabels[i];
        cardLabel.hidden = false;
        cardLabel.text = [self.game.house.cardsInHand[i - 5] cardLabel];
    }
}

- (void)updateButtonStatesAfterNewDeal {
    self.hitButton.enabled = true;
    self.stayButton.enabled = true;
    self.dealButton.enabled = false;
    self.playerScoreLabel.hidden = false;
    self.houseScoreLabel.hidden = false;
}

- (void)updateLabels {
    [self showCards];
    self.playerScoreLabel.text = [NSString stringWithFormat:@"%lu", self.game.player.handscore];
    self.houseScoreLabel.text = [NSString stringWithFormat:@"%lu", self.game.house.handscore];
    if (self.game.player.busted) {
        self.playerBustedLabel.hidden = false;
    }
    if (self.game.house.busted) {
        self.houseBustedLabel.hidden = false;
    }
    if (self.game.player.blackjack) {
        self.playerBlackjackLabel.hidden = false;
    }
    if (self.game.house.blackjack) {
        self.houseBlackjackLabel.hidden = false;
    }
    if (self.game.house.stayed) {
        self.houseStayedLabel.hidden = false;
    }
}

- (void)winUpdates {
    BOOL houseWins = [self.game houseWins];
    [self.game incrementWinsAndLossesForHouseWins:houseWins];
    self.winnerLabel.hidden = false;
    if (houseWins) {
        self.winnerLabel.text = @"House wins!";
        NSLog(@"\n\n\nHOUSE WINS!");
    } else {
        self.winnerLabel.text = @"Player wins!";
        NSLog(@"\n\n\nPLAYER WINS");
    }
    [self updateWinsAndLosses];
    self.dealButton.enabled = true;
    self.hitButton.enabled = false;
    self.stayButton.enabled = false;
}

- (void)updateWinsAndLosses {
    self.playerWinsLabel.text = [@"Wins: " stringByAppendingFormat:@"%lu", self.game.player.wins];
    self.playerLossesLabel.text = [@"Losses: " stringByAppendingFormat:@"%lu", self.game.player.losses];
    self.houseWinsLabel.text = [@"Wins: " stringByAppendingFormat:@"%lu", self.game.house.wins];
    self.houseLossesLabel.text = [@"Losses: " stringByAppendingFormat:@"%lu", self.game.house.losses];
}
    


@end
