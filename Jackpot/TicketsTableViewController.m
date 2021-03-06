//
//  TicketsTableViewController.m
//  Jackpot
//
//  Created by Nick Perkins on 4/20/16.
//  Copyright © 2016 Nick Perkins. All rights reserved.
//
// ALWAYS IMPORT .H FILES NOT .M
#import "TicketsTableViewController.h"
#import "WinningTicketViewController.h"
#import "Ticket.h"

@interface TicketsTableViewController () <WinningTicketViewControllerDelegate>{
    // need brackets for adding this.
    NSMutableArray *tickets;
    int totalSpent;
    int totalWinnings;
    BOOL lotteryOver;
}
-(IBAction)showTickets:(UIStoryboardSegue *)segue;
-(IBAction)createTicket:(id)sender;
@end

@implementation TicketsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tickets";
    totalSpent = 0;
    totalWinnings = 0;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //to create an array you need to alloc init the array.
    tickets = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tickets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lottoTicket" forIndexPath:indexPath];
    
    // Configure the cell...
    
    Ticket * aTicket = tickets[indexPath.row];
    //NSObject has this defined already.  It will return a ticket.
    cell.textLabel.text = [aTicket description];
    if ([aTicket.payout containsString:(@"ticket purchased!")]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"ticket purchased!"];
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }else{
        if (![aTicket.payout isEqualToString:@"0"]) {
            cell.detailTextLabel.textColor = [UIColor greenColor];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@", aTicket.payout];
        }else{
            cell.detailTextLabel.textColor = [UIColor redColor];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@", aTicket.payout];
        }
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"segueToPicker"]) {
        WinningTicketViewController * wtvc = (WinningTicketViewController *)segue.destinationViewController;
        
        wtvc.delegate = self;
    }
}

- (void)showTickets:(UIStoryboardSegue *)segue {
// brings the view back to the Table of Tickets.
}


//implement ticket button method of IBAction createTicket
-(IBAction)createTicket:(id)sender{
    
    if (lotteryOver == YES ) {
        
        [tickets removeAllObjects];
        lotteryOver = NO;
    }
    
    Ticket * aTicket = [Ticket ticketUsingQuickPick];
    [tickets addObject:aTicket];
    totalSpent += 1;
    //self.title = [NSString stringWithFormat: @"Spent: $%d", totalSpent];
    [self.tableView reloadData];
    
    
}

-(void)returnThePickedNumbers:(NSArray *) array{
    
    Ticket *winningTicket = [Ticket ticketUsingArray:array];
    for (Ticket * ticket in tickets){
        [ticket compareWithTicket:winningTicket];
        
        totalWinnings = totalWinnings + [ticket.payout intValue];
    }
    //self.title = [NSString stringWithFormat: @"Spent: $%d Won:$%d", totalSpent, totalWinnings];
    NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"payout" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
    NSArray *sortedArray = [tickets sortedArrayUsingDescriptors:sortDescriptors];
    tickets = [sortedArray mutableCopy];
    [self.tableView reloadData];
    lotteryOver = YES;
}

@end
