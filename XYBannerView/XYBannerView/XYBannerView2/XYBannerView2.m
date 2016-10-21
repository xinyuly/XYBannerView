//
//  XYBannerView2.m
//  XYBannerView
//
//  Created by lixinyu on 16/10/21.
//  Copyright © 2016年 xy.com. All rights reserved.
//

#import "XYBannerView2.h"
#import "UIImageView+WebCache.h"

@interface XYBannerView2 ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, weak)   NSTimer       *timer;
@property (nonatomic, assign) int           index;

@end

@implementation XYBannerView2
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.scrollView = [[UIScrollView alloc] init];
    [self addSubview:self.scrollView];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    // 创建pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.hidesForSinglePage = YES;
    self.pageControl = pageControl;
    [self addSubview:pageControl];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    
    CGFloat pageW = self.imageList.count * 15;
    CGFloat pageH = 20;
    CGFloat pageX = (self.bounds.size.width - pageW)*0.5;
    CGFloat pageY = self.bounds.size.height -20;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    if (self.imageList.count > 1) {
        self.pageControl.hidden = self.pageControlHidden;
    } else {
        self.pageControl.hidden = YES;
    }

}
#pragma mark - method
- (void)setImageList:(NSArray<NSString *> *)imageList {
    _imageList = imageList;
    NSUInteger count = self.imageList.count;
    CGFloat KW = self.bounds.size.width;
    CGFloat KH = self.bounds.size.height;
    for (int i = 0; i<self.imageList.count; i++) {
        CGFloat x  = count < 2 ? 0: KW*(i+1);
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, KW, KH)];
        imgView.contentMode  = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.tag = i;
        [imgView sd_setImageWithURL:[NSURL URLWithString:imageList[i]]];
        [self.scrollView addSubview:imgView];
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewDidClick:)];
        [imgView addGestureRecognizer:recognizer];
        [imgView setUserInteractionEnabled:YES];
    }
    if (count < 2) {
        self.scrollView.contentSize = CGSizeMake(KW, 0);
        return;
    }
    self.scrollView.contentSize = CGSizeMake((self.imageList.count+2)*KW, 0);
    self.scrollView.contentOffset = CGPointMake(KW, 0);
    //first
    UIImageView *firstImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KW, KH)];
    firstImg.contentMode  = UIViewContentModeScaleAspectFill;
    firstImg.clipsToBounds = YES;
    firstImg.tag = 0;
    [self.scrollView addSubview:firstImg];
    [firstImg sd_setImageWithURL:[NSURL URLWithString:imageList[count-1]]];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewDidClick:)];
    [firstImg addGestureRecognizer:recognizer];
    [firstImg setUserInteractionEnabled:YES];
    //last
    UIImageView *lastImg = [[UIImageView alloc]initWithFrame:CGRectMake((self.imageList.count+1)*KW, 0, KW, KH)];
    lastImg.contentMode  = UIViewContentModeScaleAspectFill;
    lastImg.clipsToBounds = YES;
    lastImg.tag = count - 1;
    [self.scrollView addSubview:lastImg];
    [lastImg sd_setImageWithURL:[NSURL URLWithString:imageList[0]]];
    UITapGestureRecognizer *recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewDidClick:)];
    [lastImg addGestureRecognizer:recognizer1];
    [lastImg setUserInteractionEnabled:YES];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = count;
    [self bringSubviewToFront:self.pageControl];
    self.index = 0;
    [self startTimer];
}

- (void)imgViewDidClick:(UITapGestureRecognizer *)recognizer {
    UIImageView *imgView = (UIImageView *)recognizer.view;
    NSInteger tag = imgView.tag;
    NSInteger index = tag;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(bannerView:didSelectedCellAtIndex:)]) {
        [self.delegate bannerView:self didSelectedCellAtIndex:index];
    }
}

- (UITapGestureRecognizer *)addTapGestureWithTarget:(id)target selector:(SEL)selector {
    UITapGestureRecognizer *tapGesure = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tapGesure];
    [self setUserInteractionEnabled:YES];
    return tapGesure;
}

-(void)startTimer{
    NSTimeInterval time = self.timeInterval ? self.timeInterval : 3.0;
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(nextImg) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)nextImg{
    CGFloat moveL = self.scrollView.contentOffset.x;
    CGFloat SW = self.scrollView.bounds.size.width;
    int num = (moveL+SW*0.5)/SW;
    if (num == self.imageList.count+1) {
        num = 1;
    } else{
        num++;
        [self.scrollView setContentOffset:CGPointMake(num*SW, 0) animated:YES];
    }
}
#pragma mark -scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat moveL = self.scrollView.contentOffset.x;
    CGFloat SW = self.scrollView.bounds.size.width;
    int num = (moveL+SW*0.5)/SW;
    self.pageControl.currentPage = num-1;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGFloat moveL = self.scrollView.contentOffset.x;
    CGFloat SW = self.scrollView.bounds.size.width;
    int num = (moveL+SW*0.5)/SW;
    if (num == self.imageList.count+1) {
        [self.scrollView setContentOffset:CGPointMake(SW, 0) animated:NO];
    } else if (num == 0){
        [self.scrollView setContentOffset:CGPointMake((self.imageList.count)*SW, 0) animated:NO];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self startTimer];
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
@end

