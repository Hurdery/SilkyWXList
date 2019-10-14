//
//  dgListBottomCollectionViewCell.h
//  SilkyWXList
//
//  Created by Runing on 2019/10/10.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface dgListBottomCollectionViewCell : UICollectionViewCell<IGListBindable>
@property (weak, nonatomic) IBOutlet UILabel *publicTime;


-(void)bindViewModel:(dgListCellModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
