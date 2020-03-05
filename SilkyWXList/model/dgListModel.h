//
//  dgListModel.h
//  SilkyWXList
//
//  Created by Runing on 2019/10/10.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface dgListModel : NSObject<IGListDiffable>

/// 模型id
@property (nonatomic,copy) NSString *modelid;

/// 背景图
@property (nonatomic,copy) NSString *headImage;

/// 用户头像
@property (nonatomic,copy) NSString *headAvatar;

/// 用户名称
@property (nonatomic,copy) NSString *headUserName;

/// 列表图片
@property (nonatomic,copy) NSString *limage;

/// 列表用户头像
@property (nonatomic,copy) NSString *lavatar;

/// 列表用户名
@property (nonatomic,copy) NSString *luserName;

/// 列表内容
@property (nonatomic,copy) NSString *lcontent;

/// 列表位置
@property (nonatomic,copy) NSString *llocation;

/// 列表时间
@property (nonatomic,copy) NSString *lpublicTime;


@end

NS_ASSUME_NONNULL_END
