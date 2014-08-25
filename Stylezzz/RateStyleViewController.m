//
//  RateStyleViewController.m
//  Stylezzz
//
//  Created by Orion Despo on 8/29/14.
//  Copyright (c) 2014 Orion Despo. All rights reserved.
//

#import "RateStyleViewController.h"

@interface RateStyleViewController ()

@property (nonatomic) BOOL didRate;
@property (nonatomic) UIView *ratingArea;
@property (nonatomic) UILabel *numberRatings;
@property (nonatomic) UIProgressView *avgRatingProgress;
@end

@implementation RateStyleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImageView *iView = [[UIImageView alloc]init];
        iView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/8*6);
        iView.image = [UIImage imageNamed:@"samplePic.jpg"];
        [self.view addSubview:iView];
        
        self.ratingArea = [[UIView alloc]init];
        self.ratingArea.backgroundColor = [UIColor whiteColor];
        self.ratingArea.frame=CGRectMake(0, iView.frame.origin.y+iView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-iView.frame.size.height);
        
        UIButton *bad = [[UIButton alloc]init];
        bad = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        bad.frame = CGRectMake(0, 50, 50, 50);
        [bad setTitle:@"BAD" forState:UIControlStateNormal];
        [bad addTarget:self action:@selector(badChosen:) forControlEvents:UIControlEventTouchUpInside];
        [self.ratingArea addSubview:bad];
        
        UIButton *ehh = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        ehh.frame = CGRectMake(70, 50, 50, 50);
        [ehh setTitle:@"ehh" forState:UIControlStateNormal];
        [ehh addTarget:self action:@selector(ehhChosen:) forControlEvents:UIControlEventTouchUpInside];
        [self.ratingArea addSubview:ehh];
        
        UIButton *ok = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        ok.frame = CGRectMake(120, 50, 50, 50);
        [ok setTitle:@"ok" forState:UIControlStateNormal];
        [ok addTarget:self action:@selector(okChosen:) forControlEvents:UIControlEventTouchUpInside];
        [self.ratingArea addSubview:ok];
        
        UIButton *good = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        good.frame = CGRectMake(170, 50, 50, 50);
        [good setTitle:@"good" forState:UIControlStateNormal];
        [good addTarget:self action:@selector(goodChosen:) forControlEvents:UIControlEventTouchUpInside];
        [self.ratingArea addSubview:good];
        
        
        UIButton *great = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        great.frame = CGRectMake(220, 50, 50, 50);
        [great setTitle:@"great" forState:UIControlStateNormal];
        [great addTarget:self action:@selector(greatChosen:) forControlEvents:UIControlEventTouchUpInside];
        [self.ratingArea addSubview:great];
        
        self.avgRatingProgress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        self.avgRatingProgress.frame = CGRectMake(15, 75, 270, 30);
        self.avgRatingProgress.progressTintColor = [UIColor blueColor];
        self.avgRatingProgress.progress = 0.5;
        self.avgRatingProgress.hidden = YES;
        self.avgRatingProgress.backgroundColor = [UIColor blackColor];
        [self.ratingArea addSubview:self.avgRatingProgress];
        
        
        UIButton *showOverall =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        showOverall.frame = CGRectMake(0, 10, 60, 20);
        [showOverall setTitle:@"Overall" forState:UIControlStateNormal];
        [showOverall addTarget:self action:@selector(showOverall:) forControlEvents:UIControlEventTouchUpInside];
        [self.ratingArea addSubview:showOverall];
        
        self.numberRatings = [[UILabel alloc]init];
        self.numberRatings.frame = CGRectMake(70, 10, 200, 30);
        self.numberRatings.text = @"55 Ratings";
        self.numberRatings.hidden = YES;
        [self.ratingArea addSubview:self.numberRatings];
        
        [self.view addSubview:self.ratingArea];
        // Custom initialization
    }
    return self;
}

-(void)showOverall:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString:@"Overall"]) {
        [button setTitle:@"Yours" forState:UIControlStateNormal];
        self.numberRatings.hidden = NO;
        self.avgRatingProgress.hidden = NO;
        
    } else {
        [button setTitle:@"Overall" forState:UIControlStateNormal];
        self.numberRatings.hidden = YES;
        self.avgRatingProgress.hidden = YES;
    }
}

-(void)badChosen:(UIButton *)button {
    if (!self.didRate) {
        NSLog(@"bad choosen");
        self.didRate = YES;
    }
}
-(void)ehhChosen:(UIButton *)button {
    if (!self.didRate) {
        self.didRate = YES;
        NSLog(@"ehh chosen");
    }
}
-(void)okChosen:(UIButton *)button {
    if (!self.didRate) {
        self.didRate = YES;
        NSLog(@"ok choosen");
    }
}
-(void)goodChosen:(UIButton *)button {
    if (!self.didRate) {
        self.didRate = YES;
        NSLog(@"good choosen");
    }
}
-(void)greatChosen:(UIButton *)button {
    if (!self.didRate) {
        self.didRate = YES;
        NSLog(@"great choosen");
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.didRate = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
