//
//  ViewController.m
//  Stylezzz
//
//  Created by Orion Despo on 8/17/14.
//  Copyright (c) 2014 Orion Despo. All rights reserved.
//

// TODO: make new view controller for picture editing
// Make picture drawing better, more consistent with touching
// create draw, save, reset buttons
// Get drawn on area
// Get pixel color of area


#import "ViewController.h"
#import "CreateStyleViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "RateStyleViewController.h"


@interface ViewController ()
@property (nonatomic) UIButton *matchingButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    self.navigationController.navigationBar.hidden=YES;
    
    [super viewDidLoad];
    self.matchingButton = [[UIButton alloc]init];
    self.matchingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.matchingButton.frame = CGRectMake(20, 20, 200, 200);
    [self.matchingButton setTitle:@"Upload Photo" forState:UIControlStateNormal];
    [self.matchingButton setTitle:@"Upload Photo" forState:UIControlStateNormal];
    [self.matchingButton addTarget:self action:@selector(uploadPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.matchingButton];
    
    UIButton *rateButton = [[UIButton alloc]init];
    rateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rateButton.frame = CGRectMake(20, 300, 200, 200);
    [rateButton setTitle:@"Rate Photo" forState:UIControlStateNormal];
    [rateButton setTitle:@"Rate Photo" forState:UIControlStateNormal];
    [rateButton addTarget:self action:@selector(ratePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rateButton];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)ratePhoto:(UIButton *)button {
    RateStyleViewController *rate = [[RateStyleViewController alloc]init];
    [self presentViewController:rate animated:NO completion:NULL];
}

// UpLoad Photo
-(void)createStyle:(UIImage *)image
{
    // compress image or some shit like that
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CreateStyleViewController *createStyleView = [[CreateStyleViewController alloc]init];
    createStyleView.image = smallImage;
    
   // [self dismissViewControllerAnimated:YES completion:NULL];
    [self presentViewController:createStyleView animated:YES completion:NULL];
    
}

// User Picked to Match Clothes
-(void)uploadPhoto:(UIButton *)d
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:NULL];
    } else {
        UIImage *image = [UIImage imageNamed:@"samplePic.jpg"];
        [self createStyle:image];
        // TODO: come up with way to handle this case
        NSLog(@"camera not supported.");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self createStyle:image];
    NSLog(@"hey");
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
