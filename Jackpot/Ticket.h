//
//  Ticket.h
//  Jackpot
//
//  Created by Nick Perkins on 4/20/16.
//  Copyright © 2016 Nick Perkins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject
//Bool is a VALUE TYPE, not an OBJECT TYPE. We are going to ASSIGN a value.
@property (assign) BOOL winner;
// This is an object. When using NSStrings use copy. nonatomic means no need to worry about multi-threading. Always use nonatomic for this classroom.
@property (copy, nonatomic)NSString * payout;

// the type of instance we are going to work with. It is a return type.  Here working with a random ticket. INSTANCE OBJECTS has +
+(instancetype)ticketUsingQuickPick;
// if we don't want a random number and we want to pick our number. Picks is the name of argument we passed.  Argument is NSArray
+(instancetype)ticketUsingArray:(NSArray*)picks;

- (void)compareWithTicket:(Ticket*)anotherTicket;

//declare a method that returns an NSArray called picks
-(NSArray*) picks;

@end
