//
//  ViewController.m
//  XYBannerView
//
//  Created by smok on 16/10/10.
//  Copyright © 2016年 xy.com. All rights reserved.
//

#import "ViewController.h"
#import "XYBannerView.h"

@interface ViewController ()<XYBannerViewDelegate>

@property (nonatomic, strong) XYBannerView *bannerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arrURL = @[@"http://img5.duitang.com/uploads/item/201411/16/20141116152242_XTsZZ.jpeg"
        ,@"http://img4.duitang.com/uploads/item/201312/03/20131203154121_rPHaH.jpeg",@"http://h.hiphotos.baidu.com/baike/c0%3Dbaike60%2C5%2C5%2C60%2C20/sign=dea9e7f2564e9258b2398ebcfdebba3d/dbb44aed2e738bd46496bda7a18b87d6267ff9f5.jpg"];
    self.bannerView = [[XYBannerView alloc] init];
    [self.view addSubview:self.bannerView];
    self.bannerView.frame = CGRectMake(0, 20, self.view.bounds.size.width, 200);
    self.bannerView.imageList = arrURL;
//    self.bannerView.pageControlHidden = YES;
//    self.bannerView.delegate = self;
    //点击回调
    self.bannerView.imageSelectedCallBack = ^(NSInteger index){
        NSLog(@"%d",index);
    };
}
//点击回调
- (void)bannerView:(XYBannerView *)bannerView didSelectedCellAtIndex:(NSInteger)index {
    NSLog(@"%d",index);
}
@end
