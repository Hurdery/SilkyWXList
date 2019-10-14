//
//  dgHeadImageCollectionViewCell.h
//  SilkyWXList
//
//  Created by Runing on 2019/10/10.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface dgHeadImageCollectionViewCell : UICollectionViewCell<IGListBindable>

@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UIImageView *headAvatar;
@property(nonatomic,strong)UILabel *headUserName;

-(void)bindViewModel:(dgListCellModel *)viewModel;
@end

NS_ASSUME_NONNULL_END
