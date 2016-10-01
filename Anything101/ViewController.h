//
//  ViewController.h
//  Anything101
//
//  Created by Jo Tu on 8/14/16.
//  Copyright © 2016 Tu Estates. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

@property (weak, nonatomic)  UIImage *passedImage;
@property (weak, nonatomic) IBOutlet UITextView *passedTextView;

@end

