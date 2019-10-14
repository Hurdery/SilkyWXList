//
//  dgListHeadImageC.m
//  SilkyWXList
//
//  Created by Runing on 2019/10/10.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import "dgListHeadImageC.h"
#import "dgHeadImageCollectionViewCell.h"

@implementation dgListHeadImageC

-(NSInteger)numberOfItems{
    
    if (_object.headImage.length > 0) {
        return 1;
    }
    return 0;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index{
    return CGSizeMake(SCREEN_WIDTH, 400);
}

-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    
    dgHeadImageCollectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:[dgHeadImageCollectionViewCell class] forSectionController:self atIndex:index];
    [cell bindViewModel:[[dgListCellModel alloc]initWithModel:_object]];
    return cell;
    
}

-(void)didUpdateToObject:(id)object{
    _object = object;
}
@end
