//
//  FISCardDeck.m
//  OOP-Cards-Model
//
//  Created by Max Tkach on 6/16/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCardDeck.h"
#import "FISCard.h"

@implementation FISCardDeck

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _dealtCards = [[NSMutableArray alloc] init];
        _remainingCards = [[NSMutableArray alloc] init];
        [self constructDeck];
    }
    return self;
}

- (FISCard *) drawNextCard {
    if (self.remainingCards.count < 1) {
        return nil;
    }
    
    FISCard *newCard = self.remainingCards[0];
    
    [self.dealtCards addObject:newCard];
    [self.remainingCards removeObjectAtIndex:0];
    
    return newCard;
}

- (void)constructDeck {
    NSMutableArray *deck = [[NSMutableArray alloc] init];
    NSArray *validRanks = FISCard.validRanks;
    NSArray *validSuits = FISCard.validSuits;
    
    for (NSString *rank in validRanks) {
        for (NSString *suit in validSuits) {
            FISCard *card = [[FISCard alloc] initWithSuit:suit rank:rank];
            [deck addObject:card];
        }
    }
    
    self.remainingCards = deck;
}

- (void)resetDeck {
    [self gatherDealtCards];
    [self shuffleRemainingCards];
}

- (void)gatherDealtCards {
    [self.remainingCards addObjectsFromArray:self.dealtCards];
    [self.dealtCards removeAllObjects];
}

- (void)shuffleRemainingCards {
    NSMutableArray *shuffledCards = [[NSMutableArray alloc] init];
    
    while (self.remainingCards.count > 0) {
        NSUInteger randomIndex = arc4random_uniform((u_int32_t)self.remainingCards.count);
        [shuffledCards addObject:self.remainingCards[randomIndex]];
        [self.remainingCards removeObjectAtIndex:randomIndex];
    }
    
    self.remainingCards = shuffledCards;
}

- (NSString *)description {
    NSMutableString *remainingCardsAsString = [[NSMutableString alloc] init];
    for (FISCard *card in self.remainingCards) {
        [remainingCardsAsString appendFormat:@"  %@", card];
    }
    
    return [NSString stringWithFormat:@"FISCardDeck\ncount: %lu\ncards:\n%@", self.remainingCards.count, remainingCardsAsString];
}

@end
