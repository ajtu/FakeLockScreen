//
//  ViewController.m
//  Anything101
//
//  Created by Jo Tu on 8/14/16.
//  Copyright © 2016 Tu Estates. All rights reserved.
//

#import "ViewController.h"
#import "HomeScreenController.h"
@class ASFSharedViewTransition;


@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;


@end

@implementation ViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{

    
}

-(void)submit{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.passedTextView.text forKey:@"savedTextView"];

    
    if(self.passedImage){
    HomeScreenController *homeScreenController = [[HomeScreenController alloc]init];
//    homeScreenController.backgroundImageView = self.previewImageView;
    homeScreenController.passedImage = self.passedImage;
    homeScreenController.textViewString = self.passedTextView.text;


    [self.navigationController pushViewController:homeScreenController animated:YES];
    }
}


- (IBAction)takePhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        NSLog(@"picked library bc camera aint avail");
        
    }
    else{
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [self presentViewController:picker animated:YES completion:NULL];
}



- (IBAction)selectPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    NSData *imageData = UIImageJPEGRepresentation(chosenImage, 1); //got help on this method ~THEKAUSH
    self.passedImage = chosenImage;
    self.previewImageView.image = chosenImage;
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:[self placeholderTextViewString]]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = [self placeholderTextViewString];
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}



//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    
//    if([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder]; //dimisses keyboard when hit return(i dont want this right now)
//        return NO;
//    }
//    
//    return YES;
//}


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textViewShouldEndEditing:(UITextField *)textView {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.passedTextView endEditing:YES];
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    
    
//    NSLog(@"%@",notification);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
//    [UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];

    [self.view setFrame:CGRectMake(0,-200,self.view.frame.size.width,self.view.frame.size.height)]; //here taken -110 for example i.e. your view will be scrolled to -110. change its value according to your requirement.

    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
////    [UIView setAnimationDelay:1.0];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//
//    
//    [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
//    [self.passedTextView setFrame:CGRectMake(0,0,320,460)];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Setup";
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(submit)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
//    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    

    
    self.passedTextView.delegate = self;
    
    if(![defaults objectForKey:@"savedTextView"]){
    self.passedTextView.text = [self placeholderTextViewString];
    self.passedTextView.textColor = [UIColor lightGrayColor]; //optional
    }
    else{
        self.passedTextView.text = [defaults objectForKey:@"savedTextView"];

    }

    // Do any additional setup after loading the view, typically from a nib.
}


-(NSString*)placeholderTextViewString{
    return @"Add any notes you'd like from descriptive jokes to a brief cheat sheet! Hit Save when you've properly selected an image and input your notes :)\nAFTER YOU HIT SAVE, HIDE YOUR NOTES BY TAPPING ON THE TIME!\n\nHere are a few examples:\nChemistry\n Metal + nonmetal = ionic bond\nNonmetal + nonmetal = covalent bond\nMetal + metal = metallic bond\nElectron filling pattern: 1s, 2s, 2p, 3s, 3p, 4s, 3d, 4p, 5s, 4d, 5p, 6s, 4f, 5d, 6p, 7s, 5f\n\nManagerial Accounting\nRevenues – Expenses = Net income\nCost of beginning inventory + Cost of purchases – Cost of ending inventory = Costs of goods sold\ncontribution margion ration = total contribution margin/total sales \n contribution margin ratio = contribution margin per unit/sales price per unit\nPrice variance = (Standard price – Actual price) x Actual quantity\nQuantity variance = Standard price x (Standard quantity – Actual quantity)";
}




#pragma mark - ASFSharedViewTransitionDataSource

- (UIView *)sharedView
{
    return _previewImageView;
}

@end
