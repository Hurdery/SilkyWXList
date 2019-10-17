//
//  dgHeaderRefreshView.m
//  SilkyWXList
//
//  Created by Runing on 2019/10/12.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import "dgHeaderRefreshView.h"

#define headHeight  60

@interface  dgHeaderRefreshView ()

@property (weak, nonatomic) UIImageView* rotateImage;

@end

@implementation dgHeaderRefreshView

#warning 动画有点生硬，不过目前，老夫的法力只能到此了，有好的实现方法一定要call我
#warning 官方指定唯一联系方式 QQ:1589353390
#warning 动画有点生硬，不过目前，老夫的法力只能到此了，有好的实现方法一定要call我
#warning 官方指定唯一联系方式 QQ:1589353390
#warning 动画有点生硬，不过目前，老夫的法力只能到此了，有好的实现方法一定要call我
#warning 官方指定唯一联系方式 QQ:1589353390
- (void)prepare
{
    [super prepare];
    
    self.ignoredScrollViewContentInsetTop = - 60;

    self.mj_h = headHeight;
    
    UIImageView* rotateImage = [[UIImageView alloc]
                                 initWithImage:[UIImage imageNamed:@"refresh"]];
    [self addSubview:rotateImage];

    self.rotateImage = rotateImage;
    
    self.mj_y = -self.mj_h - self.ignoredScrollViewContentInsetTop;
}

- (void)placeSubviews
{
    [super placeSubviews];
     
    self.rotateImage.frame = CGRectMake(30, 30, 30, 30);

}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary*)change
{
    [super scrollViewContentOffsetDidChange:change];

    self.mj_y = -self.mj_h - self.ignoredScrollViewContentInsetTop;
    
    CGFloat pullingY = fabs(self.scrollView.mj_offsetY + 64 +
                            self.ignoredScrollViewContentInsetTop);
    if (pullingY >= headHeight) {

        CGFloat marginY = -headHeight - (pullingY - headHeight) -
        self.ignoredScrollViewContentInsetTop;
        self.mj_y = marginY ;
    }
 
    [UIView animateWithDuration:2 animations:^{
        self.rotateImage.transform = CGAffineTransformRotate(self.rotateImage.transform,M_PI/2);
    }];
    
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
            self.rotateImage.hidden = YES;
            break;
        case MJRefreshStatePulling:
            self.rotateImage.hidden = NO;
            break;
        case MJRefreshStateRefreshing:
            self.rotateImage.hidden = NO;
            break;
        default:
            break;
    }
}

@end
