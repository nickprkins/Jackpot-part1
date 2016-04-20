//
//  Ticket.m
//  Jackpot
//
//  Created by Nick Perkins on 4/20/16.
//  Copyright © 2016 Nick Perkins. All rights reserved.
//

#import "Ticket.h"
// hide things, copy interface in .h to .m file. add () to say, hey i'm creating something here. This is an extension of interface already declared in header file.
@interface Ticket(){

//instance variable, means add {} to the interface.
    NSMutableArray * picks;

}
@end

@implementation Ticket
//minus sign is an instance method
- (instancetype)init
{
    // if it fails to create return NIL, if it exists then we need to do something.
    self = [super init];
    if (self) {
        picks = [NSMutableArray array];
        self.winner = NO;
        self.payout = @"ticket purchased!";
    }
    return self;
}

//class methods need + sign
+(instancetype)ticketUsingQuickPick{
    
    Ticket* aTicket = [[Ticket alloc] init];
    
    do {
        [aTicket createPick];
    } while (aTicket.picks.count < 6);
    
    return aTicket;
}

//class methods need + sign

+(instancetype)ticketUsingArray:(NSArray *)picks{
    //class is uppercase and lowercase is local variable. Good to do with other developers
    Ticket * ticket = [[Ticket alloc]init];
    
    return ticket;
}

-(void)storeTheArrayIntoPicks:(NSArray*)array{
    // a copy we can edit. mutable! Woohoo!
    picks = [array mutableCopy];
    
}

// this is called AN INSTANCE METHOD
-(void)createPick{
    
    int pickInt = arc4random() % 54 +1;
    NSNumber *pickNumber = [NSNumber numberWithInt:pickInt];
    BOOL dontAdd = NO;
    for(NSNumber * numberInArray in picks){
        if(numberInArray.intValue == pickInt){
            //don't add to array.
            dontAdd = YES;
        }
    }
    
    if(!dontAdd){
        [picks addObject:pickNumber];
        //NICK NOTE: Sort lottery numbers in ascending order
        [picks sortUsingSelector:@selector(compare:)];
        
        
    }
    
    

    
}
-(NSArray*)picks{
    // when picks is called it is NSArray, copy forces it. It can not be changed from NSArray.
    return [picks copy];
}

-(void)compareWithTicket:(Ticket *)anotherTicket{
    
    
    NSArray* possibleWinningNumbers = anotherTicket.picks;
    int matchCount = 0;
    
    for (NSNumber *ourNumber in picks) {
        for (NSNumber *theirNumber in possibleWinningNumbers){
            if (ourNumber.integerValue == theirNumber.integerValue) {
                matchCount += 1;
            }
        }
    }
    switch (matchCount){
        case 1:
            self.winner = YES;
            self.payout = @"1";
            break;
        case 2:
            self.winner = YES;
            self.payout = @"1";
            break;
        case 3:
            self.winner = YES;
            self.payout = @"5";
            break;
        case 4:
            self.winner = YES;
            self.payout = @"10";
            break;
        case 5:
            self.winner = YES;
            self.payout = @"100";
            break;
        case 6:
            self.winner = YES;
            self.payout = @"1000";
            break;
            
        default:
            self.payout = @"sorry please play again";
            break;
    }
    
}

-(NSString*)description{
    return [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", picks[0],picks[1],picks[2],picks[3],picks[4],picks[5] ];
}

@end
