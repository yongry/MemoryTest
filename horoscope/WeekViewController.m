//
//  WeekViewController.m
//  MemoryTest
//
//  Created by JessieYong on 02/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "WeekViewController.h"
#import "InfoClient.h"
#import "TitleCell.h"
#import "ContentCell.h"

@interface WeekViewController ()
@property CGSize textSize;
@end

@implementation WeekViewController
@synthesize textSize;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    switch (indexPath.row) {
        case 0:
            height = 70;
            break;
        default:
        { 
            UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
            return cell.frame.size.height;             
            break;
        }

    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    HoroscopeType myHoro = [[[NSUserDefaults standardUserDefaults] valueForKey:@"myHoro"] intValue];

    if (indexPath.row == 0) {
        CellIdentifier = @"titleCell";
        TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
        NSString *time =  [[[[[InfoClient shareClient] horoData] objectAtIndex:myHoro] valueForKey:@"week"] valueForKey:@"time"];

        [cell.title setText:@"本周运势"];
        [cell.time setText:time];
        [cell.contentView setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:233/255.0 alpha:1]];        
        return cell;
    } else
    {
        CellIdentifier = @"contentCell";
        ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        UILabel *label = (UILabel *)[cell viewWithTag:1];
        if (label == nil) {
            label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.tag = 1;
            label.lineBreakMode = UILineBreakModeWordWrap;
            label.numberOfLines = 0;
            label.opaque = NO;
            label.backgroundColor = [UIColor clearColor];
        }
        if (indexPath.row % 2 == 1) {
            [cell.contentView setBackgroundColor:[UIColor colorWithRed:123.0/255.0 green:195.0/255.0 blue:220.0/255.0 alpha:1]];
            [label setTextColor:[UIColor whiteColor]];
        } else {
            [cell.contentView setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:237.0/255.0 alpha:1]];
            [label setTextColor:[UIColor colorWithRed:11.0/255.0 green:51.0/255.0 blue:61.0/255.0 alpha:1]];
        }
        
        NSString *content;
        if (indexPath.row == 1) {
            content = [[[[[InfoClient shareClient] horoData] objectAtIndex:myHoro] valueForKey:@"week"] valueForKey:@"love"];
            [cell.iconView setImage:[UIImage imageNamed:@"love"]];
        }
        else if (indexPath.row == 2) {
            content = [[[[[InfoClient shareClient] horoData] objectAtIndex:myHoro] valueForKey:@"week"] valueForKey:@"work"];
            [cell.iconView setImage:[UIImage imageNamed:@"work"]];
        } else if (indexPath.row == 3) {
            content = [[[[[InfoClient shareClient] horoData] objectAtIndex:myHoro] valueForKey:@"week"] valueForKey:@"job"];
            [cell.iconView setImage:[UIImage imageNamed:@"jobhunting"]];
        } else if (indexPath.row == 4) {        
            content = [[[[[InfoClient shareClient] horoData] objectAtIndex:myHoro] valueForKey:@"week"] valueForKey:@"money"];
            [cell.iconView setImage:[UIImage imageNamed:@"money"]];
        } else if (indexPath.row == 5) {
            content = [[[[[InfoClient shareClient] horoData] objectAtIndex:myHoro] valueForKey:@"week"] valueForKey:@"health"];
            [cell.iconView setImage:[UIImage imageNamed:@"health"]];
        }
        
        
        CGRect cellFrame = CGRectMake(94, 6, 220, 640);
        [label setText:content];
        CGRect rect = CGRectInset(cellFrame, 2, 2);
        label.frame = rect;
        label.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        [label sizeToFit];
        if(label.frame.size.height <= 80)
            cellFrame.size.height = 92;
        else {
            cellFrame.size.height = label.frame.size.height + 12;
        }
        [cell setFrame:cellFrame];
        [cell.contentView addSubview:label];
        return cell;    

        }
    // Configure the cell...
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
