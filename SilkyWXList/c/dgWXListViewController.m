//
//  dgWXListViewController.m
//  SilkyWXList
//
//  Created by 孟德出品 on 2019/10/9.
//  Copyright © 2019 Doogore. All rights reserved.
//

#import "dgWXListViewController.h"
#import "YYFPSLabel.h"
#import "dgListHeadImageC.h"
#import "dgListContentC.h"
#import "dgListLocationC.h"
#import "dgListBottomC.h"
#import "dgHeaderRefreshView.h"
#import "dgNavView.h"

@interface dgWXListViewController ()<IGListAdapterDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) IGListAdapter *adapter;
@property (nonatomic,strong) IGListCollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray<dgListModel *>* objects;
@property(nonatomic,strong) NSDictionary *dicM;
@property(nonatomic,strong) dgNavView *navView;
@property(nonatomic,assign) CGFloat contentOffsetY;

@end

@implementation dgWXListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self prepareListData];

    self.adapter.dataSource = self;
    self.adapter.collectionView = self.collectionView;
    self.adapter.scrollViewDelegate = self;

    [self addHeadRefresh];
    [self addLoadMoreRefresh];
    
    [self.view addSubview:self.navView];
    [self addFPSLabel];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.frame;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.contentOffsetY = scrollView.contentOffset.y;

    self.navView.navV.alpha = self.contentOffsetY / 150;
    self.navView.navLabel.alpha = self.contentOffsetY / 150;

    if (self.contentOffsetY / 150 > 0.6) {
        
        self.navView.isScrollUp = YES;
        
    } else {
        
        self.navView.isScrollUp = NO;

    }
    
}

#pragma mark 数据
- (void)prepareListData {
    //初始化数据
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"list" withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    [self.objects addObjectsFromArray:[dgListModel mj_objectArrayWithKeyValuesArray:array]];
    //加载更多
    NSURL *urlM = [[NSBundle mainBundle] URLForResource:@"list1" withExtension:@"json"];
    NSData *dataM = [NSData dataWithContentsOfURL:urlM];
    self.dicM = [NSJSONSerialization JSONObjectWithData:dataM options:NSJSONReadingAllowFragments error:nil];
    
}
- (void)addHeadRefresh {
    
    self.collectionView.mj_header = [dgHeaderRefreshView headerWithRefreshingBlock:^{
        [self.collectionView.mj_header endRefreshing];
    }];
    
}
- (void)addLoadMoreRefresh {
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(
                       dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(),
                       ^{
                           [self loadMoreData];
                           [self.collectionView.mj_footer endRefreshing];
                       });
    }];
    
}

- (void)loadMoreData {
    
    NSMutableArray *tempA = [NSMutableArray array];

    for (int i=0; i < 10; i++) {
        
        dgListModel *lm = [[dgListModel alloc]init];
        lm.modelid = self.dicM[@"modelid"][arc4random_uniform(10)];
        lm.luserName = self.dicM[@"luserName"][arc4random_uniform(10)];
        NSMutableString * imageStr = [[NSMutableString alloc]init];

        for (int j = 0; j < arc4random_uniform(10); j++) {

            [imageStr appendFormat:@",%@", self.dicM[@"limage"][arc4random_uniform(10)]];
        }
        if ([imageStr hasPrefix:@","]) {
            [imageStr deleteCharactersInRange:NSMakeRange(0, 1)];
        }
        lm.limage = imageStr;
        lm.lavatar = self.dicM[@"limage"][arc4random_uniform(10)];
        lm.lcontent = self.dicM[@"lcontent"][arc4random_uniform(10)];
        lm.publicTime = self.dicM[@"publicTime"][arc4random_uniform(10)];
        [tempA addObject:lm];
    }
    
    [self.objects addObjectsFromArray:tempA];
   //更新数据
    [self.adapter performUpdatesAnimated:YES completion:nil];

}


#pragma mark UI
- (dgNavView*)navView {
    
    if (!_navView) {
        _navView = [[dgNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAV_HEIGHT)];
    }
    return _navView;
    
}

- (void)addFPSLabel {
    
    YYFPSLabel *fpsLabel = [YYFPSLabel new];
    fpsLabel.frame = CGRectMake(SCREEN_WIDTH-100, SCREEN_HEIGHT-120, 60, 30);
    [[UIApplication sharedApplication].keyWindow addSubview:fpsLabel];
    
}

#pragma mark IG

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[IGListCollectionView alloc] initWithFrame:CGRectZero];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
- (IGListAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[[IGListAdapterUpdater alloc] init] viewController:self];
    }
    return _adapter;
    
}

-(NSMutableArray<dgListModel*>*)objects{
    if (!_objects) {
        _objects = [NSMutableArray array];
    }
    return _objects;
}

-(UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
        
        UIView *emptyV = [UIView new];
        emptyV.backgroundColor = [UIColor blueColor];
        return nil;
}
    
-(NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
        return self.objects;
}
    
-(IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
        IGListStackedSectionController *stack = [[IGListStackedSectionController alloc] initWithSectionControllers:@[[dgListHeadImageC new],[dgListContentC new],[dgListLocationC new],[dgListBottomC new]]];
        stack.inset = UIEdgeInsetsMake(-60, 0, 0, 0);
        return stack;
    }

@end
