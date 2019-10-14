//
//  dgNavView.h
//  SilkyWXList
//
//  Created by Runing on 2019/10/12.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface dgNavView : UIView
@property (nonatomic,strong)UIView *navV;
@property (nonatomic,strong)UILabel *navLabel;
@property (nonatomic,assign)BOOL isScrollUp;
@property (nonatomic,strong)UIButton *camareBtn;
@property (nonatomic,strong)UIButton *backBtn;
@end

NS_ASSUME_NONNULL_END
