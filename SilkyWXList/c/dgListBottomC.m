//
//  dgListBottomC.m
//  SilkyWXList
//
//  Created by Runing on 2019/10/10.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import "dgListBottomC.h"
#import "dgListBottomCollectionViewCell.h"

@implementation dgListBottomC
-(NSInteger)numberOfItems{
    if (kStringIsEmpty(_object.publicTime)) {
        return 0;
    }
    return 1;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index{
    
    return CGSizeMake(SCREEN_WIDTH,60);
    
}

-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    
    dgListBottomCollectionViewCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"dgListBottomCollectionViewCell" bundle:nil forSectionController:self atIndex:index];
    [cell bindViewModel:[[dgListCellModel alloc]initWithModel:_object]];
    return cell;
    
}

-(void)didUpdateToObject:(id)object{
    _object = object;
}
@end
