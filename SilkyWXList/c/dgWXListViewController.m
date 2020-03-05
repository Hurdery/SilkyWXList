//
//  dgWXListViewController.m
//  SilkyWXList
//
//  Created by 孟德出品 on 2019/10/9.
//  Copyright © 2019 Doogore. All rights reserved.
//
#warning 如有任何问题，欢迎积极联系交流
#warning 官方指定唯一联系方式 QQ:1589353390
#import "dgWXListViewController.h"
#import "YYFPSLabel.h"
#import "dgListHeadImageC.h"
#import "dgListContentC.h"
#import "dgListLocationC.h"
#import "dgListBottomC.h"
#import "dgHeaderRefreshView.h"
#import "dgNavView.h"

@interface dgWXListViewController ()<IGListAdapterDataSource,UIScrollViewDelegate,dgNavViewDelegate>

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
    
    //     准备数据
    [self prepareListData];

    //     主列表
    self.adapter.dataSource = self;
    self.adapter.collectionView = self.collectionView;
    self.adapter.scrollViewDelegate = self;
    
    //     加载数据
    [self addHeadRefresh];
    [self addLoadMoreRefresh];
    
    //     导航栏
    [self.view addSubview:self.navView];
    
    //     FPS监控
    [self addFPSLabel];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.frame;
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

/**
 添加头尾刷新控件
 
 */
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


/// 加载更多数据
- (void)loadMoreData {
    
    NSMutableArray *tempA = [NSMutableArray array];

    // 一次来十条
    for (int i=0; i < 10; i++) {
        
    // 随机装载数据模型
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
        lm.llocation= self.dicM[@"llocation"][arc4random_uniform(10)];
        lm.lpublicTime = self.dicM[@"lpublicTime"][arc4random_uniform(10)];
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
        _navView.delegate = self;
    }
    return _navView;
    
}

- (void)addFPSLabel {
    
    YYFPSLabel *fpsLabel = [YYFPSLabel new];
    fpsLabel.frame = CGRectMake(SCREEN_WIDTH-100, SCREEN_HEIGHT-110, 60, 30);
    [self.view addSubview:fpsLabel];
    
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

/// 滑动改变导航栏状态
/// @param scrollView <#scrollView description#>
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

#pragma mark click
- (void)navBackClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
