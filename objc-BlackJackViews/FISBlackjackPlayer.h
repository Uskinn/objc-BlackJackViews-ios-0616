//
//  FISBlackjackPlayer.h
//  BlackJack
//
//  Created by Sergey Nevzorov on 6/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISCard.h"

@interface FISBlackjackPlayer : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *cardsInHand;
@property (assign, nonatomic) BOOL aceInHand;
@property (assign, nonatomic) BOOL blackjack;
@property (assign, nonatomic) BOOL busted;
@property (assign, nonatomic) BOOL stayed;
@property (assign, nonatomic) NSUInteger handscore;
@property (assign, nonatomic) NSUInteger wins;
@property (assign, nonatomic) NSUInteger losses;

- (instancetype)initWithName:(NSString *)name;
- (void)resetForNewGame;
- (void)acceptCard:(FISCard *)card;
- (BOOL)shouldHit;
- (NSString *)description;

@end
