//
//  dgListCellModel.m
//  SilkyWXList
//
//  Created by Runing on 2019/10/10.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import "dgListCellModel.h"

@implementation dgListCellModel
- (instancetype)initWithModel:(dgListModel *)model {
    
    if (self = [super init]) {
        
        _headImage = model.headImage;
        _headAvatar= model.headAvatar;
        _headUserName = model.headUserName;
        
        _lavatar = model.lavatar;
        _luserName = model.luserName;
        
        _limage = model.limage;
        _lcontent = model.lcontent;
        _llocation = model.llocation;
        _publicTime = model.lpublicTime;
        
        [self caculateHeight:model];
    }
    
    return self;
}

- (void)caculateHeight:(dgListModel *)model {
    
//    CGFloat avatorHeight = 50;
    CGFloat userNameHeight = 20;
    CGFloat verticalSpace = 10;
    _cellHeight += userNameHeight;
    _cellHeight += verticalSpace;
    _cellHeight += kStringIsEmpty(model.lcontent) ? 0:[self heightWithText:model.lcontent];
    if (kStringIsEmpty(model.limage)) return;
    _cellHeight += [self collectionPicViewHeight:[model.limage componentsSeparatedByString:@","].count];
    
//    NSLog(@"heightWithText==%f",[self heightWithText:model.lcontent]);
    
    
}
- (CGFloat)collectionPicViewHeight:(NSInteger)picCount {
    
    CGFloat verticalSpace = 5;
    if (picCount == 1) {
        return 180 + 2*verticalSpace;
    } else if (picCount <= 3) {
        return PHOTO_WIDTH + 2*verticalSpace;
    } else if (picCount <= 6) {
        return 2*PHOTO_WIDTH + 3 * verticalSpace;
    } else  {
        return 3*PHOTO_WIDTH + 4 * verticalSpace;
    }
    
}
-(id<NSObject>)diffIdentifier{
    return self.modelid;
}

-(BOOL)isEqualToDiffableObject:(NSObject<IGListDiffable> *)object{
    if (object == self) {
        return YES;
    } else if (![object isKindOfClass:[dgListCellModel class]]) {
        return NO;
    } else {
        return [self.modelid isEqualToString:((dgListCellModel *)object).modelid];
    }
}
-(CGFloat)heightWithText:(NSString *)text {
    
    UIFont *font = [UIFont systemFontOfSize:15];
    CGSize size = CGSizeMake(SCREEN_WIDTH - 76 - 20, CGFLOAT_MAX);
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return ceil(rect.size.height) + font.ascender + font.descender;
    
}
@end
