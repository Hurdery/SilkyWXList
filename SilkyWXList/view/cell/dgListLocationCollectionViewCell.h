//
//  dgListLocationCollectionViewCell.h
//  SilkyWXList
//
//  Created by Runing on 2019/10/12.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface dgListLocationCollectionViewCell : UICollectionViewCell<IGListBindable>
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

-(void)bindViewModel:(dgListCellModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
