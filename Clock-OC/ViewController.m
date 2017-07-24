//
//  ViewController.m
//  Clock
//
//  Created by 呆仔～林枫 on 2017/7/21.
//  Copyright © 2017年 Lin_Crazy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak,nonatomic) CALayer *layer;
@property (weak,nonatomic) UIImageView *imageView;

//时分秒
@property (weak,nonatomic) UIView *secView;
@property (weak,nonatomic) UIView *minuteView;
@property (weak,nonatomic) UIView *hourView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //表盘
    CALayer *dialLayer = [[CALayer alloc]init];
    dialLayer.position = self.view.center;
    dialLayer.bounds = CGRectMake(0, 0, 150, 150);
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"clock" ofType:@"png"];
    dialLayer.contents  = (__bridge id _Nullable)([UIImage imageWithContentsOfFile:imagePath].CGImage);
    [self.view.layer addSublayer:dialLayer];
    
    //时分秒指针
    UIView *secView = [[UIView alloc]init];//秒
    secView.backgroundColor = [UIColor redColor];
    secView.center = self.view.center;
    secView.bounds = CGRectMake(0, 0, 60, 1);
    [self.view addSubview:secView];
    secView.layer.anchorPoint = CGPointMake(0, 0.5);
    
    UIView *minuteView = [[UIView alloc]init];//分
    minuteView.backgroundColor = [UIColor blackColor];
    minuteView.center = self.view.center;
    minuteView.bounds = CGRectMake(0, 0, 45, 2);
    [self.view addSubview:minuteView];
    minuteView.layer.anchorPoint = CGPointMake(0, 0.5);
    
    UIView *hourView = [[UIView alloc]init];//时
    hourView.backgroundColor = [UIColor blackColor];
    hourView.center = self.view.center;
    hourView.bounds = CGRectMake(0, 0, 35, 3);
    [self.view addSubview:hourView];
    hourView.layer.anchorPoint = CGPointMake(0, 0.5);
    
    self.hourView = hourView;
    self.minuteView = minuteView;
    self.secView = secView;
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)updateTime {
    //获取时区
    NSTimeZone *timeZ = [NSTimeZone localTimeZone];
    //获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获取时间
    NSDate *currentDate = [NSDate date];
    //设置日历的时区
    [calendar setTimeZone:timeZ];
    //取出当前时分秒
    NSDateComponents *currentTime = [calendar components:NSCalendarUnitSecond|NSCalendarUnitMinute|NSCalendarUnitHour|NSCalendarUnitTimeZone fromDate:currentDate];
    
    CGFloat secAngle = (M_PI * 2) / 60 * currentTime.second;
    CGFloat minuteAngle = (M_PI * 2) / 60 * currentTime.minute;
    CGFloat hourAngle = (M_PI * 2) / 12 * currentTime.hour;
    
    [UIView animateWithDuration:1.0f animations:^{//只是看着更平顺一点
        self.secView.transform = CGAffineTransformMakeRotation(secAngle - M_PI_2);
    }];
    //    self.minuteView.transform = CGAffineTransformMakeRotation(minuteAngle - M_PI_2);
    //    self.hourView.transform = CGAffineTransformMakeRotation(hourAngle - M_PI_2);
    //这样加上一个偏移量更正常一点
    self.minuteView.transform = CGAffineTransformMakeRotation(minuteAngle - M_PI_2 + ((M_PI * 2) / 60 / ((M_PI * 2) / secAngle)));
    self.hourView.transform = CGAffineTransformMakeRotation(hourAngle - M_PI_2 + ((M_PI * 2) / 12 / (M_PI * 2 / minuteAngle)));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

