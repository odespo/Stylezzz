//
//  CreateStyleViewController.m
//  Stylezzz
//
//  Created by Orion Despo on 8/20/14.
//  Copyright (c) 2014 Orion Despo. All rights reserved.
//

#import "CreateStyleViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface CreateStyleViewController ()
    @property (nonatomic) CGPoint lastPoint;
    @property (nonatomic) BOOL mouseSwiped;
    @property (nonatomic) CGFloat brush;
    @property (nonatomic) UIImageView *mainImage;
    @property (nonatomic) UIImageView *tempDrawImage;
@end

@implementation CreateStyleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// TODO: add cancel button, allow to blur parts of photo, handle Parse errors

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mainImage = [[UIImageView alloc]init];
    self.mainImage.frame = self.view.bounds;
    self.mainImage.image = self.image;
    [self.view addSubview:self.mainImage];
    self.brush = 4.0;
    self.tempDrawImage = [[UIImageView alloc]init];
    self.tempDrawImage.frame = self.mainImage.frame;
    [self.view addSubview:self.tempDrawImage];

    
    UIButton *send = [[UIButton alloc]init];
    send = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    send.frame = CGRectMake(50, 50, 40, 30);
    [send setTitle:@"Send" forState:UIControlStateNormal];
    [send addTarget:self action:@selector(sendStyle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:send];
}

-(void)sendStyle:(UIButton *)button
{
    NSData *imageData = UIImageJPEGRepresentation(self.mainImage.image, 0.05f);

    PFFile *imageFile = [PFFile fileWithName:@"style.jpg" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // TODO: HANDLE ERRORS
            PFObject *style = [PFObject objectWithClassName:@"Style"];
            style[@"StyleImage"] = imageFile;
            style[@"RatingsSum"] = [NSNumber numberWithInt:0];
            style[@"NumberOfRatings"] = [NSNumber numberWithInt:0];
            [style setObject:[PFUser currentUser] forKey:@"UserStyle"];
            [style saveInBackground];
        } else {
            NSLog(@"error");
            // error
        }
    }];
    
}

///////////////////////////////////// IMAGE EDITING
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

/////////////////////////////////////////////////

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
