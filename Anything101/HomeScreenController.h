//
//  HomeScreenController.h
//  Anything101
//
//  Created by Jo Tu on 8/14/16.
//  Copyright © 2016 Tu Estates. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeScreenController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic)  UIImage *passedImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong,nonatomic) NSString *textViewString;
@end
