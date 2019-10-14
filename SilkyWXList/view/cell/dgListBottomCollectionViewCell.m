//
//  dgListBottomCollectionViewCell.m
//  SilkyWXList
//
//  Created by Runing on 2019/10/10.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import "dgListBottomCollectionViewCell.h"

@implementation dgListBottomCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor = [UIColor whiteColor];

}
- (IBAction)moreClick:(id)sender {

}
-(void)bindViewModel:(dgListCellModel *)viewModel {
    
    self.publicTime.text = viewModel.publicTime;
    
}
@end
