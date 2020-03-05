//
//  dgListContentCollectionViewCell.m
//  SilkyWXList
//
//  Created by Runing on 2019/10/10.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import "dgListContentCollectionViewCell.h"

@implementation dgListContentCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        [self buidUI];
        
    }
    return self;
}


- (void)buidUI {
    
    CGFloat avatorW = 50;
    CGFloat leftSpace = 16;
    
    UIImageView *avatorImage = [[UIImageView alloc]initWithFrame:CGRectMake(leftSpace, 0, avatorW, avatorW)];
    avatorImage.layer.cornerRadius = 10;
    avatorImage.layer.masksToBounds = YES;
    [self addSubview:avatorImage];
    
    UILabel *userName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(avatorImage.frame) + 10, 0, SCREEN_WIDTH, 20)];
    userName.textColor = RGBCOLOR(104, 114, 140);
    userName.font = [UIFont boldSystemFontOfSize:17];
    [self addSubview:userName];
    
    UILabel *lContent = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(avatorImage.frame) + 10, CGRectGetMaxY(userName.frame) + 10, SCREEN_WIDTH - 76 - 20, 0)];
    lContent.font = [UIFont systemFontOfSize:15];
    lContent.numberOfLines = 0;
    [self addSubview:lContent];
    
    dgNinePhotoView *npv = [[dgNinePhotoView alloc]initWithFrame:CGRectZero];
    [self addSubview:npv];
    
    self.npv = npv;
    self.lContent = lContent;
    self.avatorImage = avatorImage;
    self.userName = userName;
    
}

-(void)bindViewModel:(dgListCellModel *)vm {
    
    [self.avatorImage sd_setImageWithURL:[NSURL URLWithString:vm.lavatar]];
    self.userName.text = vm.luserName;
    self.lContent.text = vm.lcontent;
    self.lContent.height = kStringIsEmpty(vm.lcontent) ? 0:[self heightWithText:vm.lcontent];
    
    NSArray *picAry = [vm.limage componentsSeparatedByString:@","];
    self.npv.picAry = picAry;
    
    CGFloat MAX_CONTENTY = CGRectGetMaxY(self.lContent.frame);
    CGFloat MAX_USERNAMEY = CGRectGetMaxY(self.userName.frame);
    CGFloat MIN_LEFTSPACETOAVATOR = CGRectGetMinX(self.userName.frame);
    
    if (!kStringIsEmpty(vm.limage) && !kStringIsEmpty(vm.lcontent)) {
        
        self.npv.frame = CGRectMake(MIN_LEFTSPACETOAVATOR, MAX_CONTENTY + 10, SCREEN_WIDTH - MIN_LEFTSPACETOAVATOR - 70, [self collectionPicViewHeight:picAry.count]);
        
    } else if (!kStringIsEmpty(vm.limage) && kStringIsEmpty(vm.lcontent)) {
        
        self.npv.frame = CGRectMake(MIN_LEFTSPACETOAVATOR, MAX_USERNAMEY + 10, SCREEN_WIDTH - MIN_LEFTSPACETOAVATOR - 70, [self collectionPicViewHeight:picAry.count]);
        
    } else {
        
          self.npv.frame = CGRectZero;
        
    }
}

- (CGFloat)collectionPicViewHeight:(NSInteger)picCount {
    
    CGFloat verticalSpace = 5;
    if (picCount == 1) {
        return 180;
    } else if (picCount <= 3) {
        return PHOTO_WIDTH + 2*verticalSpace;
    } else if (picCount <= 6) {
        return 2*PHOTO_WIDTH + 3 * verticalSpace;
    } else  {
        return 3*PHOTO_WIDTH + 4 * verticalSpace;
    }
    
}

-(CGFloat)heightWithText:(NSString *)text {
    
    UIFont *font = [UIFont systemFontOfSize:15];
    CGSize size = CGSizeMake(SCREEN_WIDTH - 76 - 20, CGFLOAT_MAX);
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return ceil(rect.size.height) + font.ascender + font.descender;
    
}
@end
