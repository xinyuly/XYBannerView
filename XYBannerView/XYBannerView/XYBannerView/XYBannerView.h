//
//  XYLoopView.h
//
//  Created by MyMacbookPro on 16/5/10.
//  Copyright © 2016年 MyMacbookPro. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYBannerView;

@protocol XYBannerViewDelegate <NSObject>
- (void)bannerView:(XYBannerView *)bannerView didSelectedCellAtIndex:(NSInteger)index ;
@end

@interface XYBannerView : UIView
@property (nonatomic, assign) NSTimeInterval timeInterval;//默认为3.0秒
@property (nonatomic, assign) BOOL pageControlHidden;
@property (nonatomic, strong) NSArray<NSString *> *imageList;
@property (nonatomic, copy)   void (^imageSelectedCallBack)(NSInteger index);
@property (nonatomic, weak)   id<XYBannerViewDelegate>delegate;
@end
