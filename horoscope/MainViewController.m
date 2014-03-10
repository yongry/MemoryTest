//
//  ViewController.m
//  MemoryTest
//
//  Created by JessieYong on 02/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "InfoClient.h"
#import "MainViewController.h"
#import "TodayViewController.h"
#import "WeekViewController.h"
#import "MonthViewController.h"

typedef enum {
    ChooseViewStateUp = 0,
    ChooseViewStateDown = 1
} ChooseViewState;

@interface MainViewController ()

- (void)configureInfoViewController;
- (void)configureScrollView;
- (void)configureGestureRecognizer;
- (void)moveChooseViewTo:(ChooseViewState) state;
- (void)setBallButtonImageFromHoroType:(HoroscopeType) type;

@end

@implementation MainViewController


-(void)viewWillAppear:(BOOL)animated
{
    [self.loadingIndicator setHidden:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureInfoViewController];
    [self configureScrollView];
    
    // add obser handle DidGetHoroData
    [[NSNotificationCenter defaultCenter] addObserverForName:GetHoroDataNotificationName object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        [self.ballButton setHidden:NO];
        [self.textLabel setText:@"快来选择你的星座吧"];
        [self.loadingIndicator stopAnimating];
        [self.loadingIndicator setHidesWhenStopped:YES];
        
        
        // reload table view data
        [[[self.childViewControllers objectAtIndex:0] tableView] reloadData];
        [[[self.childViewControllers objectAtIndex:1] tableView] reloadData];
        [[[self.childViewControllers objectAtIndex:2] tableView] reloadData];
        
        [self moveChooseViewTo:ChooseViewStateUp];
        
    }];
    
    // configure choose view
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"myHoro"]) {
        [self moveChooseViewTo:ChooseViewStateDown];
    } else {
        HoroscopeType myHoro = [[[NSUserDefaults standardUserDefaults] valueForKey:@"myHoro"] intValue];
        [self setBallButtonImageFromHoroType:myHoro];
        
        [[InfoClient shareClient] getHoroItemWithHoroType:myHoro];
        
    }
    
    [self configureGestureRecognizer];
    [[InfoClient shareClient] getLinkFromWeb];
    
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setChooseView:nil];
    [self setNavigationView:nil];
    [self setNavigationTitle:nil];
    [self setButtonArray:nil];
    [self setBallButton:nil];
    [self setLoadingIndicator:nil];
    [self setTextLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}


#pragma mark - main view methods

- (void)setBallButtonImageFromHoroType:(HoroscopeType)type
{
    NSString *fileName = [horoEnglishNameArray objectAtIndex:type];
    [self.ballButton setImage:[UIImage imageNamed:fileName] forState:UIControlStateNormal];
}


- (void)configureGestureRecognizer
{
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [recognizer setMaximumNumberOfTouches:1];
    [recognizer setMinimumNumberOfTouches:1];
    [self.navigationView addGestureRecognizer:recognizer];
}


- (void)handlePanFrom:(UIPanGestureRecognizer *)reconizer
{
    CGPoint translatedPoint = [reconizer translationInView:self.view];
    static CGPoint original;
    if ([reconizer state] == UIGestureRecognizerStateBegan) {
        original = self.chooseView.center;
    }
    
    NSLog(@"T: x = %f y = %f", translatedPoint.x, translatedPoint.y);
    NSLog(@"O: x = %f y = %f", original.x, original.y);

    [self.chooseView setCenter:CGPointMake(original.x, original.y + translatedPoint.y)];
    if ([reconizer state] == UIGestureRecognizerStateEnded) {
        if (translatedPoint.y > 20) {
            [self moveChooseViewTo:ChooseViewStateDown];
        }else {
            [self moveChooseViewTo:ChooseViewStateUp];
            
        }
    }
}

- (void)moveChooseViewTo:(ChooseViewState)state
{
    if (state == ChooseViewStateUp) {
        
        [UIView animateWithDuration:0.4
                              delay:0
                            options:UIViewAnimationCurveEaseInOut 
                         animations:^{
                             [self.chooseView setCenter:CGPointMake(160, -186)];
                         }
                         completion:^(BOOL finish){
                             
                         }];
        [self.navigationTitle setText:[InfoClient chineseFromHoroType:[[[NSUserDefaults standardUserDefaults] valueForKey:@"myHoro"] intValue]]];
        
        
    } else {
        [UIView animateWithDuration:0.4
                              delay:0
                            options:UIViewAnimationCurveEaseInOut 
                         animations:^{
                             [self.chooseView setCenter:CGPointMake(160, 230)];
                         }
                         completion:^(BOOL finish){
                             
                         }];
        [self.navigationTitle setText:@"来选择你的星座吧"];
        
    }
}

- (void)configureInfoViewController
{
    TodayViewController *todayVC = [self.storyboard instantiateViewControllerWithIdentifier:@"today"];
    WeekViewController *weekVC = [self.storyboard instantiateViewControllerWithIdentifier:@"week"];
    MonthViewController *monthVC = [self.storyboard instantiateViewControllerWithIdentifier:@"month"];
    
    [self addChildViewController:todayVC];
    [self addChildViewController:weekVC];
    [self addChildViewController:monthVC];
}

- (void)configureScrollView
{
    [self.scrollView setDirectionalLockEnabled:YES];
    self.scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * [self.childViewControllers count], _scrollView.frame.size.height);
    for (int i = 0; i < [self.childViewControllers count]; i++) {
        CGRect frame = _scrollView.frame;
        frame.origin.x = frame.size.width * i;
        frame.origin.y = 0;
        [[[self.childViewControllers objectAtIndex:i] view] setFrame:frame];
        [_scrollView addSubview:[[self.childViewControllers objectAtIndex:i] view]];
    }
}

- (IBAction)chooseHoro:(UIButton *)sender 
{

    for (UIButton* btn in _buttonArray) {
        if ([btn isSelected]) {
            [btn setSelected:NO];
        }
    }    
    [sender setSelected:YES];
    
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:sender.tag] forKey:@"myHoro"];
    [self setBallButtonImageFromHoroType:sender.tag];
    [_textLabel setText:@"载入中……"];
    [self.ballButton setHidden:YES];
        [self.loadingIndicator setHidden:NO];
    [self.loadingIndicator startAnimating];
    
    [[InfoClient shareClient] getHoroItemWithHoroType:sender.tag];
}

- (IBAction)pussBallButton:(id)sender {
    if (self.chooseView.center.y < 0) {
        [self moveChooseViewTo:ChooseViewStateDown];
    } else {
        [self moveChooseViewTo:ChooseViewStateUp];
    }
}
@end