//
//  WinningTicketViewController.m
//  Jackpot
//
//  Created by Nick Perkins on 4/21/16.
//  Copyright © 2016 Nick Perkins. All rights reserved.
//

#import "WinningTicketViewController.h"

@interface WinningTicketViewController () <UIPickerViewDelegate, UIPickerViewDataSource>{
    NSMutableArray  * pickedNumbers;
    int numberCheck;
    BOOL hasPickedAllNumbers;
}
@end

@implementation WinningTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    hasPickedAllNumbers = NO;
    // Do any additional setup after loading the view.
    pickedNumbers = [@[  [NSNumber numberWithInt:0],
                        [NSNumber numberWithInt:0],
                        [NSNumber numberWithInt:0],
                        [NSNumber numberWithInt:0],
                        [NSNumber numberWithInt:0],
                        [NSNumber numberWithInt:0]]mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)checkTicket:(UIButton *)sender{
    if (hasPickedAllNumbers == YES)
    {
        
        [self.delegate returnThePickedNumbers: pickedNumbers];//what are the numbers exactly?
        
    }
}

-(IBAction)randomWinner:(UIButton *)sender{
    Ticket * randomWinnerTicket = [Ticket ticketUsingQuickPick];
    int index = 0;
    
    do {
        NSInteger grabNumber = [randomWinnerTicket.picks[index] integerValue];
        [_pickerView selectRow:grabNumber inComponent:index animated:YES];
        index += 1;
    } while (index < 6);
    
    //NSLog(@"%@", randomWinnerTicket);
    pickedNumbers = [randomWinnerTicket.picks mutableCopy];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 6; // adding an @ before 6 would make it a literal 6 value. We don't need that here.
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 54;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%ld", (long)row+1];
}

- (void)pickerView:
(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    pickedNumbers[component] = [NSNumber numberWithLong:row+1];
    // Once we have the picks the BOOL hasPickedAllNumbers is set to YES!
    if ([pickerView selectedRowInComponent:1] == [pickerView selectedRowInComponent:0] ||
        [pickerView selectedRowInComponent:2] == [pickerView selectedRowInComponent:0] ||
        [pickerView selectedRowInComponent:3] == [pickerView selectedRowInComponent:0] ||
        [pickerView selectedRowInComponent:4] == [pickerView selectedRowInComponent:0] ||
        [pickerView selectedRowInComponent:5] == [pickerView selectedRowInComponent:0]) {
        [pickerView selectRow:row+1 inComponent:0 animated:YES];
        numberCheck = numberCheck + 1;
        NSLog(@" Total %d", numberCheck);
    }
    
    if ([pickerView selectedRowInComponent:0] == [pickerView selectedRowInComponent:1] ||
        [pickerView selectedRowInComponent:2] == [pickerView selectedRowInComponent:1] ||
        [pickerView selectedRowInComponent:3] == [pickerView selectedRowInComponent:1] ||
        [pickerView selectedRowInComponent:4] == [pickerView selectedRowInComponent:1] ||
        [pickerView selectedRowInComponent:5] == [pickerView selectedRowInComponent:1]) {
        [pickerView selectRow:row+1 inComponent:1 animated:YES];
        numberCheck = numberCheck + 1;
        NSLog(@"Total %d", numberCheck);
    }
    
    if ([pickerView selectedRowInComponent:0] == [pickerView selectedRowInComponent:2] ||
        [pickerView selectedRowInComponent:1] == [pickerView selectedRowInComponent:2] ||
        [pickerView selectedRowInComponent:3] == [pickerView selectedRowInComponent:2] ||
        [pickerView selectedRowInComponent:4] == [pickerView selectedRowInComponent:2] ||
        [pickerView selectedRowInComponent:5] == [pickerView selectedRowInComponent:2]) {
        [pickerView selectRow:row+1 inComponent:2 animated:YES];
        numberCheck = numberCheck + 1;
        NSLog(@" Total %d", numberCheck);
    }
    if ([pickerView selectedRowInComponent:0] == [pickerView selectedRowInComponent:3] ||
        [pickerView selectedRowInComponent:1] == [pickerView selectedRowInComponent:3] ||
        [pickerView selectedRowInComponent:2] == [pickerView selectedRowInComponent:3] ||
        [pickerView selectedRowInComponent:4] == [pickerView selectedRowInComponent:3] ||
        [pickerView selectedRowInComponent:5] == [pickerView selectedRowInComponent:3]) {
        [pickerView selectRow:row+1 inComponent:3 animated:YES];
        numberCheck = numberCheck + 1;
        NSLog(@"Total %d", numberCheck);
    }
    if ([pickerView selectedRowInComponent:0] == [pickerView selectedRowInComponent:4] ||
        [pickerView selectedRowInComponent:1] == [pickerView selectedRowInComponent:4] ||
        [pickerView selectedRowInComponent:2] == [pickerView selectedRowInComponent:4] ||
        [pickerView selectedRowInComponent:3] == [pickerView selectedRowInComponent:4] ||
        [pickerView selectedRowInComponent:5] == [pickerView selectedRowInComponent:4]) {
        [pickerView selectRow:row+1 inComponent:4 animated:YES];
        numberCheck = numberCheck + 1;
        NSLog(@"Total %d", numberCheck);
    }
    if ([pickerView selectedRowInComponent:0] == [pickerView selectedRowInComponent:5] ||
        [pickerView selectedRowInComponent:1] == [pickerView selectedRowInComponent:5] ||
        [pickerView selectedRowInComponent:2] == [pickerView selectedRowInComponent:5] ||
        [pickerView selectedRowInComponent:3] == [pickerView selectedRowInComponent:5] ||
        [pickerView selectedRowInComponent:4] == [pickerView selectedRowInComponent:5]) {
        [pickerView selectRow:row+1 inComponent:5 animated:YES];
        numberCheck = numberCheck + 1;
        NSLog(@" Total %d", numberCheck);
    }
    
    if(numberCheck >= 6){
        hasPickedAllNumbers = YES;
    }
    
    NSLog(@"%@", pickedNumbers);
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
