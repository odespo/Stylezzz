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
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (nonatomic) UIButton *matchingButton;
@property (nonatomic) CGPoint lastPoint;
@property (nonatomic) BOOL mouseSwiped;
@property (nonatomic) CGFloat brush;
@property (nonatomic) UIImageView *mainImage;
@property (nonatomic) UIImageView *tempDrawImage;

@end

@implementation ViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    self.brush = 5.0;
    self.mainImage = [[UIImageView alloc]init];
    self.mainImage.frame = self.view.bounds;
    self.tempDrawImage = [[UIImageView alloc]init];
    self.tempDrawImage.frame = self.mainImage.frame;

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


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"dhdhdhd");
    self.mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"ddd");
    self.mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), .3f, .3f, .3f, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImage setAlpha:1.0];
    UIGraphicsEndImageContext();
    
    self.lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"yo");
    if(!self.mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), .3f, .3f, .3f, 1.0);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImage.image = nil;
    UIGraphicsEndImageContext();
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
    self.mainImage.image = image;
    [self.view addSubview:self.mainImage];
    [self.view addSubview:self.tempDrawImage];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
