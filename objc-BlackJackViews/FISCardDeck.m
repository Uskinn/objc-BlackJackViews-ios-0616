//
//  FISCardDeck.m
//  OOP-Cards-Model
//
//  Created by Sergey Nevzorov on 6/15/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCardDeck.h"

//@interface FISCardDeck ()
//
//- (void)deckOfCard;
//
//@end


@implementation FISCardDeck

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        _remainingCards = [[NSMutableArray alloc] init];
        _dealtCards = [[NSMutableArray alloc] init];
        
        [self deckOfCard];
    }
    return self;
}

- (void)deckOfCard {

    NSArray *suits = [FISCard validSuits];
    NSArray *ranks = [FISCard validRanks];
    
    for (NSUInteger i=0; i < [suits count]; i++) {
        for (NSUInteger j=0; j < [ranks count]; j++) {
            FISCard *newDeck = [[FISCard alloc] initWithSuit:suits[i] rank:ranks[j]];
            
            
            [self.remainingCards addObject:newDeck];
            //NSLog(@"%@", self.remainingCards);
        }
    }
}

- (FISCard *)drawNextCard {

    if ([self.remainingCards count] > 0){
        
    // 1. get a card from the remaining cards array
    FISCard *newCard = self.remainingCards[0];
        
    // 2. add the card to the dealt cards array
    [self.dealtCards addObject:newCard];
        
    // 3. remove the card from the remaining cards array
    [self.remainingCards removeObject:newCard];
    
        return newCard;
    }
    return nil;
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
    
    [self gatherDealtCards];

    NSUInteger cardCount = [self.remainingCards count];
    
    NSMutableArray *newDeck = [self.remainingCards mutableCopy];
    [self.remainingCards removeAllObjects];
    
    for (NSUInteger i = 0; i < cardCount; i++) {
        NSUInteger ranCard = arc4random_uniform((uint32_t) newDeck.count);
        [self.remainingCards addObject:newDeck[ranCard]];
        [newDeck removeObject:newDeck[ranCard]];
    }

}

- (NSString *)description{
    
    NSString *newCardValue = [NSString stringWithFormat:@"count: %lu\n cards:\n  ",self.remainingCards.count];
    
    for (FISCard *object in self.remainingCards) {
        newCardValue = [newCardValue stringByAppendingString:[NSString stringWithFormat:@"%@ ",object.description]];
    }
    
    return newCardValue;
}



@end
