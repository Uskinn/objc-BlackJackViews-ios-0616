//
//  FISCard.h
//  OOP-Cards-Model
//
//  Created by Sergey Nevzorov on 6/15/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISCard : NSObject

+ (NSArray *)validSuits;
+ (NSArray *)validRanks;


- (instancetype)init;
- (instancetype)initWithSuit:(NSString *)suit rank:(NSString *)rank;
- (NSString *)description;

@property (strong, nonatomic, readonly) NSString *suit;
@property (strong, nonatomic, readonly) NSString *rank;
@property (strong, nonatomic, readonly) NSString *cardLabel;
@property (nonatomic, readonly) NSUInteger cardValue;



@end
