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
#import "PictureMatchViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (nonatomic) UIButton *matchingButton;

@end

@implementation ViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    self.matchingButton = [[UIButton alloc]init];
    self.matchingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.matchingButton.frame = CGRectMake(20, 20, 200, 200);
    [self.matchingButton setTitle:@"Match Please" forState:UIControlStateNormal];
    [self.matchingButton setTitle:@"Match Please" forState:UIControlStateNormal];
    [self.matchingButton addTarget:self action:@selector(outlineArea:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.matchingButton];
	// Do any additional setup after loading the view, typically from a nib.
}

// User Picked to Match Clothes
-(void)matchPlease:(UIButton *)d
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:NULL];
    } else {
        NSLog(@"camera not supported.");
    }
}

// User Saved Picture.
// Show Saved Picture
// Allow User to Draw on Picture
// Determine if drawn area matches
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"hey");
}


-(void)outlineArea:(UIButton*)b
{
    UIImage *image = [UIImage imageNamed:@"samplePic.jpg"];
    PictureMatchViewController *matchViewCon = [[PictureMatchViewController alloc]init];
    matchViewCon.image = image;
    [self presentViewController:matchViewCon animated:YES completion:NULL];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
