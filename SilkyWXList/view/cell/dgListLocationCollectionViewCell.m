//
//  dgListLocationCollectionViewCell.m
//  SilkyWXList
//
//  Created by Runing on 2019/10/12.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import "dgListLocationCollectionViewCell.h"

@implementation dgListLocationCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)bindViewModel:(dgListCellModel *)viewModel {
    
    self.locationLabel.text = viewModel.llocation;
    
}
@end
