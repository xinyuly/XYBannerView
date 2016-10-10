//
//  XYLoopViewCell.m
//  LoopView
//
//  Created by MyMacbookPro on 16/5/10.
//  Copyright © 2016年 MyMacbookPro. All rights reserved.
//

#import "XYBannerViewCell.h"
#import "UIImageView+WebCache.h"

@interface XYBannerViewCell ()

@property (nonatomic, weak) UIImageView *imgView;

@end

@implementation XYBannerViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.contentMode  = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        [self.contentView addSubview:imgView];
        self.imgView = imgView;
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imgView.frame = self.contentView.bounds;
}

@end
