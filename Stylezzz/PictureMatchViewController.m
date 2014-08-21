//
//  PictureMatchViewController.m
//  Stylezzz
//
//  Created by Orion Despo on 8/20/14.
//  Copyright (c) 2014 Orion Despo. All rights reserved.
//

#import "PictureMatchViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface PictureMatchViewController ()
    @property (nonatomic) CGPoint lastPoint;
    @property (nonatomic) BOOL mouseSwiped;
    @property (nonatomic) CGFloat brush;
    @property (nonatomic) UIImageView *mainImage;
    @property (nonatomic) UIImageView *tempDrawImage;
    @property (nonatomic) BOOL shouldDraw;
    @property (nonatomic) CGMutablePathRef drawPath;
@end

@implementation PictureMatchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // set up drawing
    self.drawPath = CGPathCreateMutable();
    CGPathMoveToPoint(self.drawPath,NULL,0.0,0.0);
    
    self.shouldDraw = false;
    self.brush = 2.0;
    self.mainImage = [[UIImageView alloc]init];
    self.mainImage.frame = self.view.bounds;
    self.mainImage.image = self.image;
    self.tempDrawImage = [[UIImageView alloc]init];
    self.tempDrawImage.frame = self.mainImage.frame;
    [self.view addSubview:self.mainImage];
    [self.view addSubview:self.tempDrawImage];
    // set up buttons to control drawing
    UIView *buttonView = [[UIView alloc]init];
    buttonView.frame = CGRectMake(0, 20, 150, 30);
    buttonView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonView];
    UIButton *edit = [[UIButton alloc]init];
    edit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    edit.frame = CGRectMake(0, 0, 40, 30);
    [edit setTitle:@"Edit" forState:UIControlStateNormal];
    [edit addTarget:self action:@selector(startEdit:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:edit];
    UIButton *reset = [[UIButton alloc]init];
    reset = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    reset.frame = CGRectMake(50, 0, 40, 30);
    [reset setTitle:@"Reset" forState:UIControlStateNormal];
    [reset addTarget:self action:@selector(resetDraw:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:reset];
    UIButton *done = [[UIButton alloc]init];
    done = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    done.frame=CGRectMake(100, 0, 40, 30);
    [done setTitle:@"Done" forState:UIControlStateNormal];
    [done addTarget:self action:@selector(doneOutlining:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:done];
    
}

-(void)doneOutlining:(UIButton *)button {
    if (self.shouldDraw) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setPath:self.drawPath];
        
        CALayer *imgLayer = [CALayer layer];
        [imgLayer setContents:self.image];
        [imgLayer setMask:shapeLayer];
        NSLog(@"%@", imgLayer);
        
        UIView *v = [[UIView alloc]init];
        v.frame = self.view.frame;
        v.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:v];
        [v.layer addSublayer:imgLayer];
        
        CGPathRelease(self.drawPath);
        self.shouldDraw = false;
    }
}

-(void)resetDraw:(UIButton *)button {
    self.mainImage.image = self.image;
    self.tempDrawImage.image = self.image;
}

-(void)startEdit:(UIButton *)button {
    self.shouldDraw = true;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"dhdhdhd");
    if (self.shouldDraw) {
        self.mouseSwiped = NO;
        UITouch *touch = [touches anyObject];
        self.lastPoint = [touch locationInView:self.view];
        CGPathAddLineToPoint(self.drawPath,NULL,self.lastPoint.x,self.lastPoint.y);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"ddd");
    if (self.shouldDraw) {
        self.mouseSwiped = YES;
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:self.view];
        CGPathAddLineToPoint(self.drawPath,NULL,currentPoint.x,currentPoint.y);
    
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
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"yo");
    if (self.shouldDraw) {
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
