//
//  dgListLocationC.m
//  SilkyWXList
//
//  Created by Runing on 2019/10/11.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import "dgListLocationC.h"
#import "dgListLocationCollectionViewCell.h"

@implementation dgListLocationC
-(NSInteger)numberOfItems{
    
    if (kStringIsEmpty( _object.llocation)) {
        return 0;
    }
    return 1;
}

-(CGSize)sizeForItemAtIndex:(NSInteger)index {
    
    return CGSizeMake(SCREEN_WIDTH, 30);
    
}

-(UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    
    dgListLocationCollectionViewCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"dgListLocationCollectionViewCell" bundle:nil forSectionController:self atIndex:index];
    [cell bindViewModel:[[dgListCellModel alloc]initWithModel:_object]];
    return cell;
    
}

-(void)didUpdateToObject:(id)object{
    _object = object;
}
@end
