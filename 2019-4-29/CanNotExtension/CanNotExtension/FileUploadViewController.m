//
//  FileUploadViewController.m
//  IDFord
//
//  Created by 吉腾蛟 on 2019/4/29.
//  Copyright © 2019 YWJ. All rights reserved.
//

#import "FileUploadViewController.h"
#import "AimsHistorySectionModel.h"
#import "FileUploadOutsiderHeaderView.h"
#import "FileUploadOutsiderTableViewCell.h"

static NSString *cell_container_reuse=@"cell_container_reuse";
static NSString *cell_container_header_reuse=@"cell_container_header_reuse";

@interface FileUploadViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIView *back_view;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray<AimsHistorySectionModel *> *aimsHistoryList_array;
@end

@implementation FileUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [SyStemStyleChoiceTool matchSystemColor:@"colorDeepBlueToWhite"];
    self.navigationItem.title = @"文件上传历史记录";
    //左边返回按钮
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:[SyStemStyleChoiceTool matchSystemLanguage:@"backIcon"]] highImage:[UIImage imageNamed:[SyStemStyleChoiceTool matchSystemLanguage:@"backIcon"]] target:self action:@selector(backToMainView) forControlEvents:UIControlEventTouchUpInside];
    
    [self addUI];
    [self requestData];
}
#pragma mark - 初始化UI
-(void)addUI{
    [self.view addSubview:self.back_view];
    
    [self.view updateConstraintsIfNeeded];
}
#pragma mark - 懒加载
-(UIView *)back_view{
    if (!_back_view) {
        _back_view=[[UIView alloc] init];
        _back_view.backgroundColor=[UIColor colorWithRed:0.941 green:0.957 blue:0.969 alpha:1.00];

        [_back_view addSubview:self.tableView];
    }
    return _back_view;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] init];
        _tableView.backgroundColor=[UIColor colorWithRed:0.941 green:0.957 blue:0.969 alpha:1.00];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight=300;
        _tableView.rowHeight=UITableViewAutomaticDimension;
        
        [_tableView registerClass:[FileUploadOutsiderTableViewCell class] forCellReuseIdentifier:cell_container_reuse];
        [_tableView registerClass:[FileUploadOutsiderHeaderView class] forHeaderFooterViewReuseIdentifier:cell_container_header_reuse];
    }
    return _tableView;
}
#pragma mark - 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.aimsHistoryList_array.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FileUploadOutsiderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cell_container_reuse];
    if (cell==nil) {
        cell=[[FileUploadOutsiderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_container_reuse];
    }
    
    [cell setCellContentWithAimsHistorySectionModel:self.aimsHistoryList_array[indexPath.section]];
    
    return cell;
}

//创建区头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FileUploadOutsiderHeaderView *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:cell_container_header_reuse];
    
    header.date_label.text=[self isEmptyOfString:[NSString stringWithFormat:@"%@",self.aimsHistoryList_array[section].syncDate]];
    header.aimsStatus_Label.text=[self isEmptyOfString:[NSString stringWithFormat:@"%@",self.aimsHistoryList_array[section].syncStatus]];
    header.uploadId=self.aimsHistoryList_array[section].uploadId;
    
    [[[header.retry_button rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:header.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self requestRetryWithUploadId:header.uploadId];
    }];
    
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 75;
}
#pragma mark - target action
-(void)backToMainView{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Maonry
-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    [self.back_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(SafeAreaTopHeight);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back_view.mas_left).offset(10);
        make.right.equalTo(self.back_view.mas_right).offset(-10);
        make.top.equalTo(self.back_view.mas_top);
        make.bottom.equalTo(self.back_view.mas_bottom);
    }];
}
#pragma mark - other 只有本页面会使用的工具方法
-(void)requestData{
    NetWorkRequest *netTask = [[NetWorkRequest alloc] init];
    NSDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:self.idsNumber forKey:@"idsNbr"];
    
    [netTask postNetWorkRequestNoConstruct:[NSString stringWithFormat:@"%@/stage/aims/detail",IDFordDomainName] needTookenFlag:YES para:param success:^(id successDic) {
        NSLog(@"%@",successDic);
        self.aimsHistoryList_array=[AimsHistorySectionModel mj_objectArrayWithKeyValuesArray:[successDic objectForKey:@"returnData"]];
        
        [self.tableView reloadData];
        
    } failure:^(id failureDic) {
        NSString *message = [failureDic objectForKey:@"message"];
        [SVProgressHUD showInfoWithStatus:message];
        DISSMISS
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

//重新发送
-(void)requestRetryWithUploadId:(NSString *)uploadId{
    NetWorkRequest *netTask = [[NetWorkRequest alloc] init];
    NSDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:[uploadId utf8Encode] forKey:@"uploadId"];
    [SVProgressHUD show];
    [netTask postNetWorkRequestNoConstruct:[NSString stringWithFormat:@"%@/stage/aims/retry",IDFordDomainName] needTookenFlag:YES para:param success:^(id successDic) {
        NSLog(@"%@",successDic);
        [SVProgressHUD showInfoWithStatus:@"发送成功"];
        DISSMISS
        
        [self requestData];
    } failure:^(id failureDic) {
        NSString *message = [failureDic objectForKey:@"message"];
        [SVProgressHUD showInfoWithStatus:message];
        DISSMISS
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
