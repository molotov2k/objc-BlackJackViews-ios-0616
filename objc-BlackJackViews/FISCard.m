//
//  FISCard.m
//  OOP-Cards-Model
//
//  Created by Max Tkach on 6/16/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCard.h"

@interface FISCard()

@property (strong, nonatomic, readwrite) NSString *suit;
@property (strong, nonatomic, readwrite) NSString *rank;
@property (strong, nonatomic, readwrite) NSString *cardLabel;
@property (nonatomic, readwrite) NSUInteger cardValue;

@end

@implementation FISCard

- (instancetype) init {
    return [self initWithSuit:@"!" rank:@"N"];
}

- (instancetype) initWithSuit:(NSString *)suit rank:(NSString *)rank {
    self = [super init];
    
    if (self) {
        if ([[[self class] validSuits] containsObject:suit]) {
            _suit = suit;
        } else {
            _suit = @"!";
        }
        
        if ([[[self class] validRanks] containsObject:rank]) {
            _rank = rank;
            _cardValue = [[[self class] validRanks] indexOfObject:rank] + 1;
            if (_cardValue > 10) {
                _cardValue = 10;
            }
        } else {
            _rank = @"N";
            _cardValue = 0;
        }
        
        _cardLabel = [NSString stringWithFormat:@"%@%@", suit, rank];
    }
    
    return self;
}

- (NSString *) description {
    return self.cardLabel;
}

+ (NSArray *) validSuits {
    return @[@"♠", @"♥", @"♣", @"♦"];
}

+ (NSArray *) validRanks {
    return @[@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

@end
