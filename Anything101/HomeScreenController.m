//
//  HomeScreenController.m
//  Anything101
//
//  Created by Jo Tu on 8/14/16.
//  Copyright © 2016 Tu Estates. All rights reserved.
//

#import "HomeScreenController.h"
#import "ASFSharedViewTransition.h"
@class ASFSharedViewTransition;



@interface HomeScreenController ()
- (IBAction)hideAndShowStuff:(id)sender;

@end

@implementation HomeScreenController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.backgroundImageView.image = self.passedImage;
    self.backgroundImageView.contentMode =  UIViewContentModeScaleAspectFill;
    self.backgroundImageView.clipsToBounds = YES;
//    [self.backgroundImageView setContentSize:CGSizeMake(self.backgroundImageView.frame.size.width,self.backgroundImageView.frame.size.height)];

//    self.backgroundImageView.autoresizingMask =
//    ( UIViewAutoresizingFlexibleBottomMargin
//     | UIViewAutoresizingFlexibleHeight
//     | UIViewAutoresizingFlexibleLeftMargin
//     | UIViewAutoresizingFlexibleRightMargin
//     | UIViewAutoresizingFlexibleTopMargin
//     | UIViewAutoresizingFlexibleWidth );
    
    self.textView.text = self.textViewString;
    self.textView.editable = NO;
    
        [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(refreshTimerEveryTwoSecs)
                                       userInfo:nil
                                        repeats:YES];
    
}

-(void)refreshTimerEveryTwoSecs{
    NSLocale *en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    assert(en_US_POSIX != nil);
    
    // The Date
    
    //set the date label correctly
    //format the date to July 9 2013 - MMMM d yyyy
    self.timeLabel.text = @"";
    self.dateLabel.text = @"";


    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:en_US_POSIX];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    //    dateFromString = [dateFormatter dateFromString:curDate];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE, MMMM d"];
    NSString *theDate = [dateFormat stringFromDate:dateFromString];
    self.dateLabel.text = theDate;
    
    // The Time
    
    NSDate *currentTime = [NSDate date];
    [dateFormatter setDateFormat:@"hh:mm"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    self.timeLabel.text = resultString;
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

#pragma mark - ASFSharedViewTransitionDataSource

- (UIView *)sharedView
{
    return _backgroundImageView;
}

- (IBAction)hideAndShowStuff:(id)sender {
    if(self.textView.hidden == YES){
        self.textView.hidden = NO;
    }
    else{
        self.textView.hidden = YES;
    }
    
}
@end
