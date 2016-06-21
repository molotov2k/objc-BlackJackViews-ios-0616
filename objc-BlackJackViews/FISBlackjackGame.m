//
//  FISBlackJackGame.m
//  BlackJack
//
//  Created by Max Tkach on 6/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackJackGame.h"


@implementation FISBlackjackGame

- (instancetype) init {
    self = [super init];
    
    if (self) {
        _deck = [[FISCardDeck alloc] init];
        _player = [[FISBlackjackPlayer alloc] initWithName:@"Player"];
        _house = [[FISBlackjackPlayer alloc] initWithName:@"House"];
    }
    
    return self;
}


- (void)playBlackjack {
    [self dealNewRound];
    for (NSUInteger i = 0; i < 3; i++) {
        [self processPlayerTurn];
        if (self.player.busted) {
            break;
        }
        [self processHouseTurn];
        if (self.house.busted) {
            break;
        }
    }
    [self incrementWinsAndLossesForHouseWins:[self houseWins]];
}

- (void)dealNewRound {
    [self.deck resetDeck];
    [self.player resetForNewGame];
    [self.house resetForNewGame];
    while (self.player.cardsInHand.count < 2) {
        [self dealCardToPlayer];
        [self dealCardToHouse];
    }
}

- (void)dealCardToPlayer {
    [self.player acceptCard:self.deck.drawNextCard];
}

- (void)dealCardToHouse {
    [self.house acceptCard:self.deck.drawNextCard];
}

- (void)processPlayerTurn {
    if ([self.player shouldHit] && !self.player.busted && !self.player.stayed) {
        [self dealCardToPlayer];
    }
}

- (void)processHouseTurn {
    if ([self.house shouldHit] && !self.house.busted && !self.house.stayed) {
        [self dealCardToHouse];
    }
}

- (BOOL)houseWins {
    if (self.player.busted) {
        return YES;
    } else if (self.house.busted) {
        return NO;
    }
    if (self.player.blackjack && self.house.blackjack) {
        return NO;
    }
    if (self.house.handscore >= self.player.handscore) {
        return YES;
    }
    return NO;
}

- (void)incrementWinsAndLossesForHouseWins:(BOOL)houseWins {
    if (houseWins) {
        self.house.wins += 1;
        self.player.losses += 1;
    } else {
        self.player.wins += 1;
        self.house.losses += 1;
    }
    NSLog(@"%@\n\n%@", self.player, self.house);
}

@end
