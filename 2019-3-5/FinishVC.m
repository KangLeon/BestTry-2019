//
//  FinishVC.m
//  IDFord
//
//  Created by fan on 2018/2/2.
//  Copyright © 2018年 YWJ. All rights reserved.
//

#import "FinishVC.h"
#import "topSearchView.h"
#import "CardListFinishCell.h"
#import "unfinishListModel.h"
#import "IDFSearchPageVC.h"
#import "IDFRefreshHeader.h"
#import "IDFRefreshFooter.h"

@interface FinishVC () <UITableViewDelegate,UITableViewDataSource>
{
    NSString *searchString;
}
@property(nonatomic, strong)UITableView *mainTableView;
@property(nonatomic, strong)topSearchView *searchView;
@property(nonatomic, strong)NSMutableArray *finishListArr;
@property(nonatomic, strong)NSMutableArray *tempArray;
@property(nonatomic, assign)NSInteger i;
@end

@implementation FinishVC
- (void)viewDidLoad {
    [super viewDidLoad];
    _i = 1;
    [self configUI];
    [self configAction];
}
-(UITableView *)mainTableView{
    if (_mainTableView == nil){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(1, 1, 1, 1) style:UITableViewStylePlain];
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.rowHeight=UITableViewAutomaticDimension;
        _mainTableView.estimatedRowHeight=147;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
//        _mainTableView.backgroundColor = [SyStemStyleChoiceTool matchSystemColor];
        _mainTableView.backgroundColor = [UIColor colorWithRed:0.941 green:0.957 blue:0.969 alpha:1.00];
        [_mainTableView registerClass:[CardListFinishCell class] forCellReuseIdentifier:@"CardListFinishCell"];
    }
    return _mainTableView;
}

//搜索
- (topSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[topSearchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36)];
    }
    return _searchView;
}
//覆盖搜索下面
- (UIView *)clearnView{
    if (!_clearnView) {
        _clearnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 270)];
        _clearnView.backgroundColor = [UIColor clearColor];
        _clearnView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
        [_clearnView addGestureRecognizer:tapGesture];
    }
    return _clearnView;
}

- (void)configUI {
    IDFWeakSelf;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userNameChangeRefresh:) name:@"userNameChangeNotification" object:nil];
    
    self.view.backgroundColor = [SyStemStyleChoiceTool matchSystemColor];
    //搜索
    weakSelf.navigationItem.titleView = self.searchView;
    weakSelf.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.clearnView];
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (KIsiPhoneX) {
            make.top.equalTo(weakSelf.view.mas_top).offset(74+20);
            make.height.mas_equalTo(SCREEN_HEIGHT - 74 - 20);
        }else{
            make.top.equalTo(weakSelf.view.mas_top).offset(74);
            make.height.mas_equalTo(SCREEN_HEIGHT - 74);
        }
        make.left.equalTo(weakSelf.view.mas_left);
        
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    self.mainTableView.mj_header = [IDFRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
    }];
    self.mainTableView.mj_footer = [IDFRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    [self.mainTableView.mj_header beginRefreshing];
    [_clearnView setHidden:YES];
}

- (void)configAction {
    IDFWeakSelf;
    _searchView.topSearchBlock = ^(NSString *searchStr) {
        [weakSelf.clearnView setHidden:NO];
        [weakSelf reloadSearchArr:searchStr];
        
    };
    _searchView.finishSearchBlock = ^(NSString *searchStr) {
        [weakSelf.clearnView setHidden:YES];
        
//        if (weakSelf.finishListArr.count == 0) {
//            weakSelf.finishListArr = weakSelf.tempArray;
//            [weakSelf.mainTableView reloadData];
//        }
    };
    _searchView.clearnBlock = ^{
        [weakSelf.clearnView setHidden:YES];
        
        searchString = @"";
        [weakSelf.mainTableView reloadData];
        [weakSelf refreshData];
    };
}

- (void)reloadSearchArr: (NSString *)searchStr{
    IDFWeakSelf;
    searchString = searchStr;
    [weakSelf refreshData];
//    NSMutableArray *matchArray = [[NSMutableArray alloc] init];
//    if (searchStr != nil && searchStr.length > 0) {
//        for (unfinishModel *model in weakSelf.tempArray){
//            if ([model.applicantName containsString:searchStr] || [model.idsNumber containsString:searchStr]) {
//                [matchArray addObject:model];
//            }
//        }
//        weakSelf.finishListArr = matchArray;
//        [weakSelf.mainTableView reloadData];
//    }else{
//        weakSelf.finishListArr = weakSelf.tempArray;
//        [weakSelf.mainTableView reloadData];
//    }
}

- (void)refreshData{
    
    NSData *search = [searchString dataUsingEncoding:NSUTF8StringEncoding];
    NSData *page = [@"1" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *size = [@"15" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:page forKey:@"page"];
    [param setValue:size forKey:@"size"];
    [param setValue:search forKey:@"search"];
    
    NetWorkRequest *netTask = [[NetWorkRequest alloc] init];
    
    [netTask postNetWorkRequest:[NSString stringWithFormat:@"%@/stage/finshed",IDFordDomainName] hideAfterGetData:YES para:param success:^(id successDic) {
        unfinishListModel *finishList = [unfinishListModel mj_objectWithKeyValues:[successDic objectForKey:@"returnData"]];
        _finishListArr = finishList.list;
        _tempArray = _finishListArr;
        [self.mainTableView reloadData];
        
        [self.mainTableView.mj_header endRefreshing];
    } failure:^(id failureDic) {
        NSString *message = [failureDic objectForKey:@"message"];
        [SVProgressHUD showInfoWithStatus:message];
        [SVProgressHUD dismissWithDelay:1.5f];
        [self.mainTableView.mj_header endRefreshing];
    }];
}
- (void)loadMoreData{
    _i = _i + 1;
    NSData *search = [searchString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *nowPage = [NSString stringWithFormat:@"%ld",(long)_i];
    NSData *page = [nowPage dataUsingEncoding:NSUTF8StringEncoding];
    NSData *size = [@"15" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:page forKey:@"page"];
    [param setValue:size forKey:@"size"];
    [param setValue:search forKey:@"search"];
    
    NetWorkRequest *netTask = [[NetWorkRequest alloc] init];
    
    [netTask postNetWorkRequest:[NSString stringWithFormat:@"%@/stage/finshed",IDFordDomainName] hideAfterGetData:YES para:param success:^(id successDic) {
        unfinishListModel *finishList = [unfinishListModel mj_objectWithKeyValues:[successDic objectForKey:@"returnData"]];
        [_finishListArr addObjectsFromArray:finishList.list];
        _tempArray = _finishListArr;
        [self.mainTableView reloadData];
        [self.mainTableView.mj_footer endRefreshing];
    } failure:^(id failureDic) {
        NSString *message = [failureDic objectForKey:@"message"];
        [SVProgressHUD showInfoWithStatus:message];
        [SVProgressHUD dismissWithDelay:1.5f];
        [self.mainTableView.mj_footer endRefreshing];
    }];
}

//隐藏键盘
- (void)dismissKeyboard{
    [_clearnView setHidden:YES];
    [_searchView setText];
//    if (_finishListArr.count == 0) {
//        _finishListArr = _tempArray;
//        [_mainTableView reloadData];
//    }
}
//用户名改变通知
- (void)userNameChangeRefresh:(NSNotification *)notification{
    IDFWeakSelf;
    [weakSelf.finishListArr removeAllObjects];
    [weakSelf.mainTableView reloadData];
    [weakSelf.mainTableView.mj_header beginRefreshing];
}

#pragma make - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _finishListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CardListFinishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CardListFinishCell"];
    if (cell == nil) {
        cell = [[CardListFinishCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CardListFinishCell"];
    }
    
    [cell setCellContent:nil contentArr:_finishListArr index:indexPath.row];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return SCREEN_HEIGHT/5;
//}
@end
