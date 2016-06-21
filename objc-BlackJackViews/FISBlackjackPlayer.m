//
//  FISBlackjackPlayer.m
//  BlackJack
//
//  Created by Max Tkach on 6/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackPlayer.h"

@implementation FISBlackjackPlayer

- (instancetype)init {
    return [self initWithName:@""];
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    
    if (self) {
        _name = name;
        _cardsInHand = [[NSMutableArray alloc] init];
        _aceInHand = NO;
        _blackjack = NO;
        _busted = NO;
        _stayed = NO;
        _handscore = 0;
        _wins = 0;
        _losses = 0;
    }

    return self;
}

- (void)resetForNewGame {
    [self.cardsInHand removeAllObjects];
    self.handscore = 0;
    self.aceInHand = NO;
    self.blackjack = NO;
    self.busted = NO;
    self.stayed = NO;
}

- (void)acceptCard:(FISCard *)card {
    [self.cardsInHand addObject:card];
    self.handscore += card.cardValue;
    if (card.cardValue == 1) {
        self.aceInHand = YES;
        if (self.handscore <= 11) {
            self.handscore += 10;
        }
    }
    if (self.handscore == 21) {
        self.blackjack = YES;
    } else if (self.handscore > 21) {
        self.busted = YES;
    }
    
}

- (BOOL)shouldHit {
    if (self.handscore > 16) {
        self.stayed = YES;
        return NO;
    }
    return YES;
}

- (NSString *)description {
    NSMutableString *cards = [[NSMutableString alloc] init];
    if (self.cardsInHand.count == 0) {
        [cards appendString:@"no cards yet"];
    }
    for (FISCard *card in self.cardsInHand) {
        [cards appendFormat:@"%@ ", card];
    }
    
    
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendFormat:@"FISBlackjackPlayer:\nname: %@", self.name];
    [result appendFormat:@"\ncards: %@", cards];
    [result appendFormat:@"\nhandscore   : %lu", self.handscore];
    [result appendFormat:@"\nace in hand : %d",self.aceInHand];
    [result appendFormat:@"\nstayed      : %d",self.stayed];
    [result appendFormat:@"\nblackjack   : %d",self.blackjack];
    [result appendFormat:@"\nbusted      : %d",self.busted];
    [result appendFormat:@"\nwins  : %lu",self.wins];
    [result appendFormat:@"\nlosses: %lu",self.losses];
    
    return result;
}

@end
