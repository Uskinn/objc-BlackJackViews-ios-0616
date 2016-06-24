//
//  FISBlackjackPlayer.m
//  BlackJack
//
//  Created by Sergey Nevzorov on 6/20/16.
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
        _cardsInHand = [[NSMutableArray alloc]init];
        _blackjack = NO;
        _busted = NO;
        _stayed = NO;
        _aceInHand = NO;
        _handscore = 0;
        _wins = 0;
        _losses = 0;
    
    }
    return self;
}

- (void)resetForNewGame {
    
    [self.cardsInHand removeAllObjects];
    self.handscore = 0;
    self.blackjack = NO;
    self.busted = NO;
    self.stayed = NO;
    self.aceInHand = NO;
}

- (void)acceptCard:(FISCard *)card {
    
    [self.cardsInHand addObject:card];
    
    self.handscore += card.cardValue;
    
    if ([card.cardLabel containsString:@"A"]) {
       
        self.aceInHand = YES;
        
   }
    if (self.aceInHand == YES && self.handscore < 12) {
        
        self.handscore += 10;
            
    }
    
    if ([self.cardsInHand count] == 2 && self.handscore == 21) {
        
        self.blackjack = YES;
    }
    
    if ([self.cardsInHand count] > 2 && self.handscore > 21) {
        
        self.busted = YES;
    }
    
}


- (BOOL)shouldHit {
    
    if (self.handscore > 17) {
        self.stayed = YES;
        return NO;
    }
    
    return YES;
}

- (NSString *)description {
    
    NSString *result = [NSString stringWithFormat:@"\nname: %@ \n cards: %@ \n handscore %li \n ace in hand: %d \n stayed: %d \n blackjack: %d \n busted: %d \n wins: %li \n losses: %li", self.name, self.cardsInHand, self.handscore, self.aceInHand, self.stayed, self.blackjack, self.busted, self.wins, self.losses];
    
  //  NSLog(@"\n\n\n\n\n\n\n\n%@\n\n\n\n\n\n\n\n\n", result);
    
    return result;

}

@end
