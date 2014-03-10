//
//  TodayViewController.m
//  MemoryTest
//
//  Created by JessieYong on 02/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "TodayViewController.h"
#import <CoreFoundation/CoreFoundation.h>
#import "InfoClient.h"
#import "TitleCell.h"
#import "ContentCell.h"
#import "PieChart.h"
#import "PercentCell.h"
#import "DescriptionCell.h"

@interface TodayViewController ()
@property CGSize textSize;
@end

@implementation TodayViewController

@synthesize textSize;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //   [self reloadInputViews];
    
}

- (void)viewDidUnload
{
    
    //    [self setAllDescription:nil];
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
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    switch (indexPath.row) {
        case 0:
            height = TitleCellHeight;
            break;
            
        default:
        {
            UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
            height =  cell.frame.size.height;
            break;
        }
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    HoroscopeType myHoro = [[[NSUserDefaults standardUserDefaults] valueForKey:@"myHoro"] intValue];
    if(indexPath.row == 0){
        CellIdentifier = @"titleCell";
        TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[TitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        NSString *time =  [[[[[InfoClient shareClient] horoData] objectAtIndex:myHoro] valueForKey:@"today"] valueForKey:@"time"];
        [cell.title setText:@"今日运势"];
        [cell.time setText:time];
        return cell;
    }
    else
    {
        CellIdentifier = @"descriptionCell";
        DescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[DescriptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        UILabel *label = (UILabel *)[cell viewWithTag:1];
        if (label == nil) {
            label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.tag = 1;
            label.lineBreakMode = UILineBreakModeWordWrap;
            label.numberOfLines = 0;
            label.opaque = NO;
            label.backgroundColor = [UIColor clearColor];
        }
        
        
        NSString *content = [[[[[InfoClient shareClient] horoData] objectAtIndex:myHoro] valueForKey:@"today"] valueForKey:@"todayDescription"];
        
        CGRect cellFrame = CGRectMake(20, 230, 280, 640);
        [label setText:content];
        CGRect rect = CGRectInset(cellFrame, 2, 2);
        label.frame = rect;
        
        label.font = [UIFont fontWithName:@"Courier" size:16.0];
        [label sizeToFit];
        
        if(label.frame.size.height < 70)
            cellFrame.size.height = 160;
        else {
            cellFrame.size.height = label.frame.size.height + 280;
        }
        label.textColor = [UIColor grayColor];
        [cell setFrame:cellFrame];
        [cell.contentView addSubview:label];
        
        
        
        NSArray *itemArray = [[[[[InfoClient shareClient] horoData] objectAtIndex:myHoro]  valueForKey:@"today"] valueForKey:@"itemArray"];
        
        
        int allInt = [[[itemArray objectAtIndex:0] valueForKey:@"sum"] intValue];
        NSNumber *allNum = [[NSNumber alloc]initWithInt:allInt];
        
        int loveInt = [[[itemArray objectAtIndex:1] valueForKey:@"sum"] intValue];
        NSNumber *loveNum = [[NSNumber alloc]initWithInt:loveInt];
        
        int workInt = [[[itemArray objectAtIndex:2] valueForKey:@"sum"] intValue];
        NSNumber *workNum = [[NSNumber alloc]initWithInt:workInt];
        
        int moneyInt = [[[itemArray objectAtIndex:3] valueForKey:@"sum"] intValue];
        NSNumber *moneyNum = [[NSNumber alloc]initWithInt:moneyInt];
        
        //  cell.numberLabel.textColor = [UIColor colorWithRed:252 green:89 blue:92 alpha:0.5];
        NSMutableString *labelText = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%@ : %@",[[itemArray objectAtIndex:6]valueForKey:@"name"],[[itemArray objectAtIndex:6]valueForKey:@"sum"]]];
        [cell.numberLabel setText:labelText];
        NSLog(@"The labelText is %@", labelText);
        NSLog(@"label is %@", cell.numberLabel);
        
        NSMutableString *labelText2 = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%@ : %@",[[itemArray objectAtIndex:5]valueForKey:@"name"],[[itemArray objectAtIndex:5]valueForKey:@"sum" ]]];
        [cell.colorLabel setText:labelText2];
        
        NSMutableString *labelText3 = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%@ : %@",[[itemArray objectAtIndex:7]valueForKey:@"name"],[[itemArray objectAtIndex:7]valueForKey:@"sum"] ]];
        [cell.horoscopeLabel setText:labelText3];
        
        int height = 100;
        int width = 100;
        UIColor *color = [self.view backgroundColor];
        UIColor * textColor = [cell.numberLabel textColor];
        
        
        NSDictionary *allDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"all",@"name",allNum,@"value",nil];
        NSDictionary *loveDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"love",@"name",loveNum,@"value",nil];
        NSDictionary *moneyDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"money",@"name",moneyNum,@"value",nil];
        NSDictionary *workDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"work",@"name",workNum,@"value",nil];
        
        
        PieChart *pieChart = [[PieChart alloc] initWithFrame:CGRectMake(1,55,width,height)];
        [pieChart setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
        [pieChart setDiameter:width/2];
        PieComponent *component = [PieComponent pieComponentWithTitle:[allDic objectForKey:@"name"] value:[[allDic objectForKey:@"value"] floatValue] color:color textColor:textColor];
        [component setColor:PCColorOrange];
        [pieChart setComponent:component];
        [self.view addSubview:pieChart];
        
        
        
        
        PieChart *pieChart2 = [[PieChart alloc] initWithFrame:CGRectMake(75,55,width,height)];
        [pieChart2 setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
        [pieChart2 setDiameter:width/2];
        PieComponent *component2 = [PieComponent pieComponentWithTitle:[loveDic objectForKey:@"name"] value:[[loveDic objectForKey:@"value"] floatValue] color:color textColor:textColor];
        [component2 setColor:PCColorOrange];
        [pieChart2 setComponent:component2];
        [self.view addSubview:pieChart2];
        
        
        PieChart *pieChart3 = [[PieChart alloc] initWithFrame:CGRectMake(149,55,width,height)];
        [pieChart3 setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
        [pieChart3 setDiameter:width/2];
        PieComponent *component3 = [PieComponent pieComponentWithTitle:[workDic objectForKey:@"name"] value:[[workDic objectForKey:@"value"] floatValue] color:color textColor:textColor];
        [component3 setColor:PCColorOrange];
        [pieChart3 setComponent:component3];
        [self.view addSubview:pieChart3];
        
        
        
        PieChart *pieChart4 = [[PieChart alloc] initWithFrame:CGRectMake(223,55,width,height)];
        [pieChart4 setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
        [pieChart4 setDiameter:width/2];
        PieComponent *component4 = [PieComponent pieComponentWithTitle:[moneyDic objectForKey:@"name"] value:[[moneyDic objectForKey:@"value"] floatValue] color:color textColor:textColor];
        [component4 setColor:PCColorOrange];
        [pieChart4 setComponent:component4];
        [self.view addSubview:pieChart4];
        
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
