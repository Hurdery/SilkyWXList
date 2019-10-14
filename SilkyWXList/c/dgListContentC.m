//
//  dgListContentC.m
//  SilkyWXList
//
//  Created by Runing on 2019/10/10.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import "dgListContentC.h"
#import "dgListContentCollectionViewCell.h"
@implementation dgListContentC
-(NSInteger)numberOfItems{
    
    if (_object.luserName.length < 1) {
        return 0;
    }
    return 1;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index{
    
    dgListCellModel *cm = [[dgListCellModel alloc]initWithModel:_object];
    return CGSizeMake(SCREEN_WIDTH, cm.cellHeight);

}

-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    
    dgListContentCollectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:[dgListContentCollectionViewCell class] forSectionController:self atIndex:index];
    [cell bindViewModel:[[dgListCellModel alloc]initWithModel:_object]];
    return cell;
    
}

-(void)didUpdateToObject:(id)object{
    _object = object;
}
@end
