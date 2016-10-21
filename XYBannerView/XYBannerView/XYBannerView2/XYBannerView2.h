//
//  XYBannerView2.h
//  XYBannerView
//
//  Created by lixinyu on 15/10/21.
//  Copyright © 2015年 xy.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYBannerView2;

@protocol XYBannerView2Delegate <NSObject>
- (void)bannerView:(XYBannerView2 *)bannerView didSelectedCellAtIndex:(NSInteger)index ;
@end

@interface XYBannerView2 : UIView
@property (nonatomic, assign) NSTimeInterval timeInterval;//默认为3.0秒
@property (nonatomic, assign) BOOL pageControlHidden;
@property (nonatomic, strong) NSArray<NSString *> *imageList;
@property (nonatomic, weak)   id<XYBannerView2Delegate>delegate;
@end
