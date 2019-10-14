//
//  dgListCellModel.h
//  SilkyWXList
//
//  Created by Runing on 2019/10/10.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface dgListCellModel : NSObject<IGListDiffable>

@property (nonatomic,copy) NSString *modelid;

@property (nonatomic,copy) NSString *headImage;
@property (nonatomic,copy) NSString *headAvatar;
@property (nonatomic,copy) NSString *headUserName;

@property (nonatomic,copy) NSString *limage;
@property (nonatomic,copy) NSString *lavatar;
@property (nonatomic,copy) NSString *luserName;
@property (nonatomic,copy) NSString *lcontent;
@property (nonatomic,copy) NSString *llocation;
@property (nonatomic,copy) NSString *publicTime;
@property(nonatomic,assign) CGFloat cellHeight;

- (instancetype)initWithModel:(dgListModel *)model;

@end

NS_ASSUME_NONNULL_END
