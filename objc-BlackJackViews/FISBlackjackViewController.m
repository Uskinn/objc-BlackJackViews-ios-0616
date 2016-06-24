//
//  FISBlackjackViewController.m
//  objc-BlackJackViews
//
//  Created by Sergey Nevzorov on 6/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackViewController.h"

@interface FISBlackjackViewController ()

//////////////HOUSE////////////////////

@property (weak, nonatomic) IBOutlet UILabel *winner;
@property (weak, nonatomic) IBOutlet UILabel *houseLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseStayed;
@property (weak, nonatomic) IBOutlet UILabel *houseCard1;
@property (weak, nonatomic) IBOutlet UILabel *houseCard2;
@property (weak, nonatomic) IBOutlet UILabel *houseCard3;
@property (weak, nonatomic) IBOutlet UILabel *houseCard4;
@property (weak, nonatomic) IBOutlet UILabel *houseCard5;
@property (weak, nonatomic) IBOutlet UILabel *houseScore;
@property (weak, nonatomic) IBOutlet UILabel *houseBust;
@property (weak, nonatomic) IBOutlet UILabel *houseBlackJack;
@property (weak, nonatomic) IBOutlet UILabel *houseWins;
@property (weak, nonatomic) IBOutlet UILabel *houseLosses;

////////////PLAYER/////////////////////

@property (weak, nonatomic) IBOutlet UILabel *playerLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerScore;
@property (weak, nonatomic) IBOutlet UILabel *playerStayed;
@property (weak, nonatomic) IBOutlet UILabel *playerCard1;
@property (weak, nonatomic) IBOutlet UILabel *playerCard2;
@property (weak, nonatomic) IBOutlet UILabel *playerCard3;
@property (weak, nonatomic) IBOutlet UILabel *playerCard4;
@property (weak, nonatomic) IBOutlet UILabel *playerCard5;
@property (weak, nonatomic) IBOutlet UILabel *playerBust;
@property (weak, nonatomic) IBOutlet UILabel *playerBlackJack;
@property (weak, nonatomic) IBOutlet UILabel *playerWins;
@property (weak, nonatomic) IBOutlet UILabel *playerLosses;
@property (weak, nonatomic) IBOutlet UIButton *hit;
@property (weak, nonatomic) IBOutlet UIButton *stay;

///////////BUTTONS/////////////////////

- (IBAction)deal:(id)sender;
- (IBAction)hit:(id)sender;
- (IBAction)stay:(id)sender;

@end

@implementation FISBlackjackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
// FISBlackjackGame 
self.game = [[FISBlackjackGame alloc]init];
    
    self.winner.hidden = YES;
    self.houseCard1.hidden = YES;
    self.houseCard2.hidden = YES;
    self.houseCard3.hidden = YES;
    self.houseCard4.hidden = YES;
    self.houseCard5.hidden = YES;
    self.houseBust.hidden = YES;
    self.houseBlackJack.hidden = YES;
    self.houseStayed.hidden = YES;
    self.houseScore.hidden = TRUE;
    
    self.playerCard1.hidden = YES;
    self.playerCard2.hidden = YES;
    self.playerCard3.hidden = YES;
    self.playerCard4.hidden = YES;
    self.playerCard5.hidden = YES;
    self.playerBust.hidden = YES;
    self.playerBlackJack.hidden = YES;
    self.playerStayed.hidden = YES;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)deal:(id)sender {
    
    [self.game.deck resetDeck];
    [self.game.player resetForNewGame];
    [self.game.house resetForNewGame];
    [self.game dealNewRound];
    
    self.playerCard3.hidden = YES;
    self.playerCard4.hidden = YES;
    self.playerCard5.hidden = YES;
    self.houseCard3.hidden = YES;
    self.houseCard4.hidden = YES;
    self.houseCard5.hidden = YES;
    self.houseBust.hidden = YES;
    self.houseBlackJack.hidden = YES;
    self.houseStayed.hidden = YES;
    self.playerBust.hidden = YES;
    self.playerBlackJack.hidden = YES;
    self.playerStayed.hidden = YES;
    self.winner.hidden = YES;

    

    
    ////setting two cards to the player
    self.playerCard1.hidden = NO;
    self.playerCard2.hidden = NO;
    self.playerCard1.text = ((FISCard *)self.game.player.cardsInHand[0]).cardLabel;
    self.playerCard2.text = ((FISCard *)self.game.player.cardsInHand[1]).cardLabel;
    self.playerScore.text = [NSString stringWithFormat:@"Score: %li", self.game.player.handscore];
    
    ////setting two cards to the house
    self.houseCard1.hidden = NO;
    self.houseCard2.hidden = NO;
    self.houseCard1.text = ((FISCard *)self.game.house.cardsInHand[0]).cardLabel;
    self.houseCard2.text = ((FISCard *)self.game.house.cardsInHand[1]).cardLabel;
    self.houseScore.text = [NSString stringWithFormat:@"Score: %li", self.game.house.handscore];

    ////Checking blackjack winners after first round
    if (self.game.player.blackjack == YES) {
        self.playerBlackJack.hidden = NO;
        self.winner.hidden = NO;
        self.winner.text = @"You win!";
        [self.game incrementWinsAndLossesForHouseWins:(![self houseWins])];
        self.playerWins.text = [NSString stringWithFormat:@"Wins: %li", self.game.player.wins];
        self.houseLosses.text = [NSString stringWithFormat:@"Losses: %li", self.game.house.losses];
           
    } else if (self.game.house.blackjack == YES) {
        self.houseBlackJack.hidden = NO;
        self.winner.hidden = NO;
        self.winner.text = @"You lost!";
        [self.game incrementWinsAndLossesForHouseWins:[self houseWins]];
        self.houseWins.text = [NSString stringWithFormat:@"Wins: %li", self.game.house.wins];
        self.playerLosses.text = [NSString stringWithFormat:@"Losses: %li", self.game.player.losses];
        
    } else {
        self.hit.enabled  = YES;
        self.stay.enabled = YES;
    }
}

- (IBAction)hit:(id)sender {
    
   [self.game dealCardToPlayer];
    
    if (self.game.player.cardsInHand.count == 3)
    
    {
        self.playerCard3.text = ((FISCard *)self.game.player.cardsInHand[2]).cardLabel;
        self.playerCard3.hidden = NO;
        self.playerScore.text = [NSString stringWithFormat:@"Score: %li", self.game.player.handscore];

    }
    
    if (self.game.player.cardsInHand.count == 4)
    
    {
        self.playerCard4.text = ((FISCard *)self.game.player.cardsInHand[3]).cardLabel;
        self.playerCard4.hidden = NO;
        self.playerScore.text = [NSString stringWithFormat:@"Score: %li", self.game.player.handscore];
    
    }

    if (self.game.player.cardsInHand.count == 5)
    
    {
        
        self.playerCard5.text = ((FISCard *)self.game.player.cardsInHand[4]).cardLabel;
        self.playerCard5.hidden = NO;
        self.playerScore.text = [NSString stringWithFormat:@"Score: %li", self.game.player.handscore];
        
    }

    if (self.game.player.busted == YES) {
        self.playerBust.hidden = NO;
        self.winner.hidden = NO;
        self.winner.text = @"You lost!";
        [self.game incrementWinsAndLossesForHouseWins:[self houseWins]];
        self.houseWins.text = [NSString stringWithFormat:@"Wins: %li", self.game.house.wins];
        self.playerLosses.text = [NSString stringWithFormat:@"Losses: %li", self.game.player.losses];
        self.hit.enabled  = NO;
        self.stay.enabled = NO;
        
    }

 }
    - (IBAction)stay:(id)sender {
        
        self.playerStayed.hidden = NO;
        self.hit.enabled  = NO;
        self.stay.enabled = NO;
        self.houseScore.hidden = FALSE;
         
        if ([self.game.house shouldHit] && self.game.house.cardsInHand.count == 2) {
            
            [self.game dealCardToHouse];
            
            self.houseCard3.text = ((FISCard *)self.game.house.cardsInHand[2]).cardLabel;
            self.houseCard3.hidden = NO;
            self.houseScore.text = [NSString stringWithFormat:@"Score: %li", self.game.house.handscore];
            self.houseStayed.hidden = NO;
            self.playerStayed.hidden = NO;

        }
        
        if ([self.game.house shouldHit] && self.game.house.cardsInHand.count == 3) {
            
            [self.game dealCardToHouse];

            self.houseCard4.text = ((FISCard *)self.game.house.cardsInHand[3]).cardLabel;
            self.houseCard4.hidden = NO;
            self.houseScore.text = [NSString stringWithFormat:@"Score: %li", self.game.house.handscore];
            self.houseStayed.hidden = NO;
            self.playerStayed.hidden = NO;
            
        }

        if ([self.game.house shouldHit] && self.game.house.cardsInHand.count == 4)
            
        {
            [self.game dealCardToHouse];

            self.houseCard5.text = ((FISCard *)self.game.house.cardsInHand[4]).cardLabel;
            self.houseCard5.hidden = NO;
            self.houseScore.text = [NSString stringWithFormat:@"Score: %li", self.game.house.handscore];
            self.houseStayed.hidden = NO;
            self.playerStayed.hidden = NO;
            
        }
        
        if (![self.game.house shouldHit]) {
            
            self.houseStayed.hidden = NO;

        }
        
        if (self.game.house.handscore > self.game.player.handscore && !self.game.house.busted) {
            
            self.winner.hidden = NO;
            self.winner.text = @"You lost!";
            [self.game incrementWinsAndLossesForHouseWins:[self houseWins]];
            self.houseWins.text = [NSString stringWithFormat:@"Wins: %li", self.game.house.wins];
            self.playerLosses.text = [NSString stringWithFormat:@"Losses: %li", self.game.player.losses];

            
        } else {
            
            self.winner.hidden = NO;
            self.winner.text = @"You win!";
            [self.game incrementWinsAndLossesForHouseWins:(![self houseWins])];
            self.playerWins.text = [NSString stringWithFormat:@"Wins: %li", self.game.player.wins];
            self.houseLosses.text = [NSString stringWithFormat:@"Losses: %li", self.game.house.losses];
            

        }
        
}

@end
