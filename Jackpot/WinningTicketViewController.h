//
//  WinningTicketViewController.h
//  Jackpot
//
//  Created by Nick Perkins on 4/21/16.
//  Copyright © 2016 Nick Perkins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ticket.h"

@protocol WinningTicketViewControllerDelegate <NSObject>
@required // they must do it.
-(void)returnThePickedNumbers:(NSArray *) array;

@end

@interface WinningTicketViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIPickerView * pickerView;

@property (weak, nonatomic) id <WinningTicketViewControllerDelegate> delegate;

-(IBAction)checkTicket:(UIButton*)sender;
-(IBAction)randomWinner:(UIButton*)sender;

@end
