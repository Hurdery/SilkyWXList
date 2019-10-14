
//
//  dgListModel.m
//  SilkyWXList
//
//  Created by Runing on 2019/10/10.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import "dgListModel.h"

@implementation dgListModel

-(id<NSObject>)diffIdentifier{
    return self;
}
-(BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object{
    return [self isEqual:object];
}

@end
