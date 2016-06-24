//
//  FISCard.m
//  OOP-Cards-Model
//
//  Created by Sergey Nevzorov on 6/15/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCard.h"

@interface FISCard ()

@property (strong, nonatomic, readwrite) NSString *suit;
@property (strong, nonatomic, readwrite) NSString *rank;
@property (strong, nonatomic, readwrite) NSString *cardLabel;
@property (nonatomic, readwrite) NSUInteger cardValue;



@end

@implementation FISCard

+ (NSArray *)validSuits{
    
    NSArray *cardSuits = [NSArray new];
    cardSuits = @[@"♠", @"♥", @"♣", @"♦"];
    
    return cardSuits;
}
+ (NSArray *)validRanks{
    
    NSArray *validCards = [NSArray new];
    validCards = @[@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    
    return validCards;
}


- (instancetype)init{
    
     return [self initWithSuit:@"!" rank:@"N"];
}

- (instancetype)initWithSuit:(NSString *)suit rank:(NSString *)rank{
    
    self = [super init];
    
    if (self) {
        
        _suit = suit;
        _rank = rank;
        _cardLabel = [NSString stringWithFormat:@"%@%@", suit, rank];
        
        if ([rank isEqualToString:@"A"]){
            _cardValue = 1;
        } else if ([rank isEqualToString:@"J"] || [rank isEqualToString:@"Q"] || [rank isEqualToString:@"K"]) {
            _cardValue = 10;
        } else {
            _cardValue = [rank integerValue] ;
        }
        
    }
    
    return self;
}

- (NSString *)description{
    
    NSString *newCardValue = [NSString stringWithFormat:@"%@", self.cardLabel];
    
    return newCardValue;
}











@end
