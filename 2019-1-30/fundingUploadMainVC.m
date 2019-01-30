//
//  fundingUploadMainVC.m
//  IDFord
//
//  Created by fan on 2018/2/28.
//  Copyright © 2018年 YWJ. All rights reserved.
//

#import "fundingUploadMainVC.h"
#import "uploadMainBottomView.h"
#import "collectionHeadCell.h"
#import "collectionShortHead.h"
#import "collectionContentCell.h"
#import "UIBarButtonItem+IDFBarItem.h"
#import "differentSizePhotoVC.h"
#import "IDFPhotoPopView.h"
#import "draftListModel.h"
#import "uploadResultVC.h"
#import "XLPhotoBrowser.h"

@interface fundingUploadMainVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DifferentSizePhotoProtocol>
@property (nonatomic, strong)NSArray *headTitltArray;
@property (nonatomic, strong)NSArray *headNumberArray;
@property (nonatomic, strong)NSArray *headNoConTitArray;
@property (nonatomic, strong)NSArray *headNoConNumArray;

@property (nonatomic, strong)NSArray *headLongTitleArray;
@property (nonatomic, strong)NSArray *headContentArray;
@property (nonatomic, strong)NSArray *headLongNumArray;

@property (nonatomic, strong)NSMutableArray *picArr1;
@property (nonatomic, strong)NSMutableArray *picArr2;

@property(nonatomic, copy)NSString *choostText;
@end

@implementation fundingUploadMainVC

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(1, 1, 1, 1) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[collectionContentCell class] forCellWithReuseIdentifier:@"collectionContentCell"];
    }
    return _collectionView;
}
- (uploadMainBottomView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[uploadMainBottomView alloc] init];
    }
    return _bottomView;
}
//底部选择按钮
- (bottomView *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [[bottomView alloc] init];
    }
    return _bottomBtn;
}
- (void)viewWillAppear:(BOOL)animated{
    if (_needRefresh) {
        [self refreshData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ///绑定短的
    _headTitltArray = [[NSArray alloc] initWithObjects:
                       @"申请人签约照片（不可修改）",
                       @"共同借款人签约照片（不可修改）",
                       @"申请人手持合同照片（不可修改）",
                       @"共同借款人手持合同照片（不可修改）",nil];
    _headNumberArray = [[NSArray alloc] initWithObjects:
                        @"1/1",
                        @"1/1",
                        @"1/1",
                        @"1/1",nil];
    _headNoConTitArray = [[NSArray alloc] initWithObjects:
                       @"申请人签约照片（不可修改）",
                       @"申请人手持合同照片（不可修改）",nil];
    _headNoConNumArray = [[NSArray alloc] initWithObjects:
                        @"1/1",
                        @"1/1",nil];
    
    //绑定长的
    _headLongTitleArray = [[NSArray alloc] initWithObjects:
                       @"放款信息确认表",
                       @"其他放款材料",nil];
    _headContentArray = [[NSArray alloc] initWithObjects:
                         @"请上传拍摄资料或相册选取",
                         @"贷款合同，购车发票等",nil];
    
    NSString *numOne = [NSString stringWithFormat:@"%lu/2",(unsigned long)_picArr1.count];
    NSString *numTwo = [NSString stringWithFormat:@"%lu/100",(unsigned long)_picArr2.count];
    _headLongNumArray = [[NSMutableArray alloc] initWithObjects:
                        numOne,
                        numTwo,nil];
    
    [self configUI];
    [self configAction];
}

- (void) configUI {
    IDFWeakSelf;
    _choostText = IDF_EDITING;
    weakSelf.automaticallyAdjustsScrollViewInsets = NO;
    //左边返回按钮
    weakSelf.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:[SyStemStyleChoiceTool matchSystemLanguage:@"backIcon"]] highImage:[UIImage imageNamed:[SyStemStyleChoiceTool matchSystemLanguage:@"backIcon"]] target:weakSelf action:@selector(backToMainView) forControlEvents:UIControlEventTouchUpInside];
    //右边保存按钮
    weakSelf.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"编辑" color:[SyStemStyleChoiceTool matchSystemColor:@"systemFontGW"] target:self action:@selector(saveEditText) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.title = @"放款资料";
    self.view.backgroundColor = [SyStemStyleChoiceTool matchSystemColor:@"colorDeepBlueToWhite"];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.bottomBtn];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(SafeAreaTopHeight);
        make.left.equalTo(weakSelf.view.mas_left);
        make.bottom.equalTo(_bottomView.mas_top);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.left.equalTo(weakSelf.view.mas_left);
        make.height.mas_equalTo(SCREEN_HEIGHT/9);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.left.equalTo(weakSelf.view.mas_left);
        make.height.mas_equalTo(SCREEN_HEIGHT/9);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    [_bottomBtn setHidden:YES];

}

- (void)configAction {
    IDFWeakSelf;
    _bottomView.leftBtnBlock = ^{
        NSLog(@"左边");
        ////////
        [weakSelf saveDraft];
    };
    _bottomView.rightBtnBlock = ^{
        NSLog(@"右边");
        //提交
        uploadResultVC *vc = [[uploadResultVC alloc] init];
        vc.idsNumber = weakSelf.mainModel.application.idsNumber;
        vc.STYLE = 0;
        vc.STATE = 1;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    //为了预防网络错误
    _bottomView.rightBtn.enabled=NO;
    //全选
    _bottomBtn.chooseAllBlock = ^{
        if ([weakSelf.bottomBtn.chooseBtn isSelected]) {
            weakSelf.picArr1 = [weakSelf chooseAllArray:weakSelf.picArr1];
            weakSelf.picArr2 = [weakSelf chooseAllArray:weakSelf.picArr2];
        }else{
            weakSelf.picArr1 = [weakSelf configAllArray:weakSelf.picArr1];
            weakSelf.picArr2 = [weakSelf configAllArray:weakSelf.picArr2];
        }
        [weakSelf.collectionView reloadData];
    };
    //删除
    _bottomBtn.delBlock = ^{
        [weakSelf bottomBtnClick];
    };
}

- (void)saveDraft{
    IDFWeakSelf;
    if (IDFStringIsEmpty(weakSelf.mainModel.application.ID)) {
        [SVProgressHUD showImage:[UIImage imageNamed:@"check_icon"] status:@"已经保存至未完成操作页面"];
        [SVProgressHUD dismissWithDelay:1.5f];
        [weakSelf backToDraft];
    }else{
        //        NSLog(weakSelf.recordId);
        [SVProgressHUD show];
        NSData *idsNum = [weakSelf.mainModel.application.ID dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *param = [[NSMutableDictionary alloc] init];
        [param setValue:idsNum forKey:@"idsRecordId"];
        NetWorkRequest *netTask = [[NetWorkRequest alloc] init];
        [netTask postNetWorkRequest:[NSString stringWithFormat:@"%@/stage/saveDraft",IDFordDomainName] hideAfterGetData:YES para:param success:^(id successDic) {
            [SVProgressHUD showImage:[UIImage imageNamed:@"check_icon"] status:@"已经保存至未完成操作页面"];
            [SVProgressHUD dismissWithDelay:1.5f];
            [weakSelf backToDraft];
            
        } failure:^(id failureDic) {
            
            NSString *message = [failureDic objectForKey:@"message"];
            [SVProgressHUD showInfoWithStatus:message];
            [SVProgressHUD dismissWithDelay:1.5f];
        }];
    }
}

////右边编辑完成逻辑
- (void)saveEditText {
    [self setShowState];
    [_collectionView reloadData];
    
}
- (void)setShowState {
    IDFWeakSelf;
    if ([_choostText  isEqualToString:IDF_EDITING]) {
        _choostText = IDF_FINISH;
        [_bottomBtn.chooseBtn setSelected:NO];
        [_bottomBtn setHidden:NO];
        //无共借人有共借人
        weakSelf.picArr1 = [weakSelf configAllArray:weakSelf.picArr1];
        weakSelf.picArr2 = [weakSelf configAllArray:weakSelf.picArr2];
    }else{
        _choostText = IDF_EDITING;
        [_bottomBtn setHidden:YES];
        weakSelf.picArr1 = [weakSelf unchooseAllArray:weakSelf.picArr1];
        weakSelf.picArr2 = [weakSelf unchooseAllArray:weakSelf.picArr2];
    }
    weakSelf.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:_choostText color:[SyStemStyleChoiceTool matchSystemColor:@"systemFontGW"] target:self action:@selector(saveEditText) forControlEvents:UIControlEventTouchUpInside];
}
- (NSMutableArray *)configAllArray: (NSMutableArray *)arr{
    NSMutableArray *replaceArr = [[NSMutableArray alloc] init];
    if (arr.count != 0) {
        for (int i = 0; i < arr.count; i++) {
            draftListModel *model = arr[i];
            model.showFlag = YES;
            model.chooseFlag = NO;
            [replaceArr addObject:model];
        }
        return replaceArr;
    }else{
        return arr;
    }
}
- (NSMutableArray *)unchooseAllArray: (NSMutableArray *)arr{
    NSMutableArray *replaceArr = [[NSMutableArray alloc] init];
    if (arr.count != 0) {
        for (int i = 0; i < arr.count; i++) {
            draftListModel *model = arr[i];
            model.showFlag = NO;
            [replaceArr addObject:model];
        }
        return replaceArr;
    }else{
        return arr;
    }
}
//chooseAll
- (NSMutableArray *)chooseAllArray: (NSMutableArray *)arr{
    NSMutableArray *replaceArr = [[NSMutableArray alloc] init];
    if (IDFArrayIsEmpty(arr)) {
        return arr;
    }else{
        for (int i = 0; i < arr.count; i++) {
            draftListModel *model = arr[i];
            model.showFlag = YES;
            model.chooseFlag = YES;
            [replaceArr addObject:model];
        }
        return replaceArr;
    }
}

- (void)bottomBtnClick{
    IDFWeakSelf;
    [SVProgressHUD showWithStatus:@"正在删除"];
    NSData *idsNum = [weakSelf.mainModel.application.idsNumber dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *confirmList = [[weakSelf jointStr:weakSelf.picArr1] dataUsingEncoding:NSUTF8StringEncoding];
    NSData *othersList = [[weakSelf jointStr:weakSelf.picArr2] dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *contractList = [@"" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:idsNum forKey:@"idsNumber"];
    [param setValue:confirmList forKey:@"confirmList"];
    [param setValue:othersList forKey:@"othersList"];
//    [param setValue:contractList forKey:@"contractList"];
    
    NetWorkRequest *netTask = [[NetWorkRequest alloc] init];

    NSString *url = [NSString stringWithFormat:@"%@/funding/edit",IDFordDomainName];
    [netTask postNetWorkRequest:url hideAfterGetData:YES para:param success:^(id successDic) {
        NSLog(@"删除之后%@",[successDic objectForKey:@"returnData"]);
        weakSelf.choostText = IDF_EDITING;
        [weakSelf.bottomBtn setHidden:YES];
        weakSelf.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:IDF_EDITING color:[SyStemStyleChoiceTool matchSystemColor:@"systemFontGW"] target:self action:@selector(saveEditText) forControlEvents:UIControlEventTouchUpInside];
        [weakSelf refreshData];
        
    } failure:^(id failureDic) {
        NSString *message = [failureDic objectForKey:@"message"];
        [SVProgressHUD showInfoWithStatus:message];
        [SVProgressHUD dismissWithDelay:1.5f];
    }];
}

//拼接要删除的所有的pic
- (NSString *)jointStr: (NSMutableArray *)myArr{
    NSMutableArray *strarr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i++) {
        draftListModel *model = myArr[i];
        if (!model.chooseFlag) {
            [strarr addObject:model.itemID];
        }
    }
    if (strarr.count != 0) {
        NSString *finalString = [strarr componentsJoinedByString:@","];
        return finalString;
    }else{
        return @"";
    }
}

- (void)refreshData{
    IDFWeakSelf;
    NSInteger arrNum = weakSelf.picArr1.count + weakSelf.picArr2.count;
    NSData *idsNum = [weakSelf.mainModel.application.idsNumber dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:idsNum forKey:@"idsNumber"];
    NetWorkRequest *netTask = [[NetWorkRequest alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@/stage/scanIdsNumber",IDFordDomainName];
    [netTask postNetWorkRequest:url hideAfterGetData:YES para:param success:^(id successDic) {
        NSLog(@"LOG--输出draft字典%@",[successDic objectForKey:@"returnData"]);
        draftMainModel *draftModel = [draftMainModel mj_objectWithKeyValues:[successDic objectForKey:@"returnData"]];
        weakSelf.mainModel = draftModel;
        weakSelf.picArr1 = draftModel.application.fundingConfirmList;
        weakSelf.picArr2 = draftModel.application.fundingOthersList;
        weakSelf.needRefresh = YES;
        if (!weakSelf.mainModel.application.coborrowOpen) {
            weakSelf.TYPE = 1;
        }else{
            weakSelf.TYPE = 0;
        }
        NSString *numOne = [NSString stringWithFormat:@"%lu/2",(unsigned long)weakSelf.picArr1.count];
        NSString *numTwo = [NSString stringWithFormat:@"%lu/100",(unsigned long)weakSelf.picArr2.count];
        weakSelf.headLongNumArray = [[NSMutableArray alloc] initWithObjects:
                             numOne,
                             numTwo,nil];
//        if(weakSelf.picArr1.count + weakSelf.picArr2.count + arrNum > 0){
//            [self.collectionView reloadData];
//        }
        [self.collectionView reloadData];
        [SVProgressHUD dismiss];
        
        //为了预防网络错误
        _bottomView.rightBtn.enabled=YES;
        
        NSLog(@"LOG--模型类的值%@", draftModel.application.ID);
    } failure:^(id failureDic) {
        NSString *message = [failureDic objectForKey:@"message"];
        [SVProgressHUD showInfoWithStatus:message];
        [SVProgressHUD dismissWithDelay:1.5f];
    }];
}
///delegate 拍摄完图片进行上传
- (void)setPicArr:(NSInteger)flag idCardResultArr:(NSMutableArray *)idCardResultArr{
    _needRefresh = NO;
    if (_TYPE == 0) {
        [self upLoadURLChoose:flag idCardResultArr:idCardResultArr];
    }else{
        [self upLoadURLChoose:flag - 2 idCardResultArr:idCardResultArr];
    }
}
- (void)upLoadURLChoose:(NSInteger)flag idCardResultArr:(NSMutableArray *)idCardResultArr{
    if (flag == 2) {
        //确认表
        if (_picArr1.count == 0) {
            _picArr1 = idCardResultArr;
        }else{
            [_picArr1 addObjectsFromArray:idCardResultArr];
        }
        
        [self uploadImgArr:[NSString stringWithFormat:@"%@/funding/uploadConfirmationForm",IDFordDomainName] picArr:idCardResultArr keyStr:@"materialList"];
        
    } else if (flag == 3){
        //其他
        if (_picArr2.count == 0) {
            _picArr2 = idCardResultArr;
        }else{
            [_picArr2 addObjectsFromArray:idCardResultArr];
        }
        
        [self uploadImgArr:[NSString stringWithFormat:@"%@/funding/uploadOthersMaterial",IDFordDomainName] picArr:idCardResultArr keyStr:@"materialList"];
    }
}

- (void)uploadImgArr: (NSString *)url picArr : (NSMutableArray *) picArr keyStr : (NSString *) keyStr{
    IDFWeakSelf;
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    NSData *finalData = [self returnImgArrayData:picArr];
    NSData *idsNum = [weakSelf.mainModel.application.idsNumber dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:finalData forKey:keyStr];
    [param setValue:idsNum forKey:@"idsNumber"];
    NetWorkRequest *netTask = [[NetWorkRequest alloc] init];
    [netTask postNetWorkRequest:url hideAfterGetData:YES para:param success:^(id successDic) {
        NSLog(@"%@",successDic);
        
        [self refreshData];
    } failure:^(id failureDic) {
        NSString *message = [failureDic objectForKey:@"message"];
        [SVProgressHUD showInfoWithStatus:message];
        [SVProgressHUD dismissWithDelay:1.5f];
    }];
}

- (NSData *)returnImgArrayData: (NSMutableArray *)picArr{
    NSMutableArray *base64ImageArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < picArr.count; i++) {
        NSData *image = UIImageJPEGRepresentation(picArr[i], 0.3);
        NSString * encodedImageStr = [image base64EncodedStringWithOptions:0];
        [base64ImageArr addObject:encodedImageStr];
    }
    NSString *finalString = [base64ImageArr componentsJoinedByString:@","];
    
    NSData *finalData = [finalString dataUsingEncoding:NSUTF8StringEncoding];
    return finalData;
}

//collection cell定义
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSString *identifier=[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    //[collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    //UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    //for(id subView in cell.contentView.subviews){
    //    if(subView){
    //        [subView removeFromSuperview];
    //    }
    //}
    
//    NSString *CellIdentifier = [NSString stringWithFormat:@"collectionHead%ld", (long)[indexPath section]];
    
    IDFWeakSelf;
    collectionContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionContentCell" forIndexPath:indexPath];
    if (_TYPE == 0) {
        //无共借人
//        if (indexPath.section < 2) {
//            cell.addPicBlock = ^{
//                NSLog(@"不能点击");
//            };
//            [cell setFundingNormalCell:weakSelf.mainModel TYPE:weakSelf.TYPE index:indexPath];
//        }else{
//            cell.addPicBlock = ^{
//                if ([weakSelf.choostText isEqualToString:@"完成"]) {
//                    if (indexPath.row == 0) {
//                        NSLog(@"点击的是第0个cell");
//                    }else{
//                        if (indexPath.section == 2) {
//                            weakSelf.picArr1 = [weakSelf setItemState:weakSelf.picArr1 index:indexPath.row -1];
//                        }else{
//                            weakSelf.picArr2 = [weakSelf setItemState:weakSelf.picArr2 index:indexPath.row -1];
//                        }
//                        [weakSelf.collectionView reloadData];
//                    }
//                }else{
//                    if (indexPath.row == 0) {
//                        //点击添加图片
//                        if (indexPath.section == 2) {
//
//                            [weakSelf jumpTakePhoto:weakSelf.picArr1 mySection:indexPath.section maxCount:2];
//                        }else{
//
//                            [weakSelf jumpTakePhoto:weakSelf.picArr2 mySection:indexPath.section maxCount:100];
//                        }
//
//
//                    }else{
//                        //点击预览大图
//                        if (indexPath.section == 2) {
//                            [weakSelf showBigPhoto:weakSelf.picArr1 arrayIndex:indexPath.row];
//                        }else{
//                            [weakSelf showBigPhoto:weakSelf.picArr2 arrayIndex:indexPath.row];
//                        }
//                    }
//                }
//            };
//            // 赋值
//            if (indexPath.section == 2) {
//                [cell setContentPic:_picArr1 index:indexPath];
//            }else if (indexPath.section == 3) {
//                [cell setContentPic:_picArr2 index:indexPath];
//            }
//        }
        cell.addPicBlock = ^{
            if ([weakSelf.choostText isEqualToString:@"完成"]) {
                if (indexPath.row == 0) {
                    NSLog(@"点击的是第0个cell");
                }else{
                    if (indexPath.section == 0) {
                        weakSelf.picArr1 = [weakSelf setItemState:weakSelf.picArr1 index:indexPath.row -1];
                    }else{
                        weakSelf.picArr2 = [weakSelf setItemState:weakSelf.picArr2 index:indexPath.row -1];
                    }
                    [weakSelf.collectionView reloadData];
                }
            }else{
                if (indexPath.row == 0) {
                    //点击添加图片
                    if (indexPath.section == 0) {
                        
                        [weakSelf jumpTakePhoto:weakSelf.picArr1 mySection:indexPath.section maxCount:2];
                    }else{
                        
                        [weakSelf jumpTakePhoto:weakSelf.picArr2 mySection:indexPath.section maxCount:100];
                    }
                    
                    
                }else{
                    //点击预览大图
                    if (indexPath.section == 0) {
                        [weakSelf showBigPhoto:weakSelf.picArr1 arrayIndex:indexPath.row];
                    }else{
                        [weakSelf showBigPhoto:weakSelf.picArr2 arrayIndex:indexPath.row];
                    }
                }
            }
        };
        // 赋值
        if (indexPath.section == 2) {
            [cell setContentPic:_picArr1 index:indexPath];
        }else if (indexPath.section == 3) {
            [cell setContentPic:_picArr2 index:indexPath];
        }
    }else{
        //有共借人
//        if (indexPath.section < 4) {
//            cell.addPicBlock = ^{
//                NSLog(@"不能点击");
//            };
//            [cell setFundingNormalCell:weakSelf.mainModel TYPE:weakSelf.TYPE index:indexPath];
//        }else{
//            cell.addPicBlock = ^{
//                if ([weakSelf.choostText isEqualToString:@"完成"]) {
//                    if (indexPath.row == 0) {
//                        NSLog(@"点击的是第0个cell");
//                    }else{
//                        if (indexPath.section == 4) {
//                            weakSelf.picArr1 = [weakSelf setItemState:weakSelf.picArr1 index:indexPath.row -1];
//                        }else{
//                            weakSelf.picArr2 = [weakSelf setItemState:weakSelf.picArr2 index:indexPath.row -1];
//                        }
//                        [weakSelf.collectionView reloadData];
//                    }
//                }else{
//                    if (indexPath.row == 0) {
//                        //点击添加图片
//                        if (indexPath.section == 4) {
//                            [weakSelf jumpTakePhoto:weakSelf.picArr1 mySection:indexPath.section maxCount:2];
//                        }else{
//                            [weakSelf jumpTakePhoto:weakSelf.picArr2 mySection:indexPath.section maxCount:100];
//                        }
//
//                    }else{
//                        //点击预览大图
//                        if (indexPath.section == 4) {
//                            [weakSelf showBigPhoto:weakSelf.picArr1 arrayIndex:indexPath.row];
//                        }else{
//                            [weakSelf showBigPhoto:weakSelf.picArr2 arrayIndex:indexPath.row];
//                        }
//                    }
//                }
//            };
//            // 赋值
//            if (indexPath.section == 4) {
//                [cell setContentPic:_picArr1 index:indexPath];
//            }else if (indexPath.section == 5){
//                [cell setContentPic:_picArr2 index:indexPath];
//            }
//        }
        cell.addPicBlock = ^{
            if ([weakSelf.choostText isEqualToString:@"完成"]) {
                if (indexPath.row == 0) {
                    NSLog(@"点击的是第0个cell");
                }else{
                    if (indexPath.section == 0) {
                        weakSelf.picArr1 = [weakSelf setItemState:weakSelf.picArr1 index:indexPath.row -1];
                    }else{
                        weakSelf.picArr2 = [weakSelf setItemState:weakSelf.picArr2 index:indexPath.row -1];
                    }
                    [weakSelf.collectionView reloadData];
                }
            }else{
                if (indexPath.row == 0) {
                    //点击添加图片
                    if (indexPath.section == 0) {
                        [weakSelf jumpTakePhoto:weakSelf.picArr1 mySection:indexPath.section maxCount:2];
                    }else{
                        [weakSelf jumpTakePhoto:weakSelf.picArr2 mySection:indexPath.section maxCount:100];
                    }
                    
                }else{
                    //点击预览大图
                    if (indexPath.section == 0) {
                        [weakSelf showBigPhoto:weakSelf.picArr1 arrayIndex:indexPath.row];
                    }else{
                        [weakSelf showBigPhoto:weakSelf.picArr2 arrayIndex:indexPath.row];
                    }
                }
            }
        };
        // 赋值
        if (indexPath.section == 0) {
            [cell setContentPic:_picArr1 index:indexPath];
        }else if (indexPath.section == 1){
            [cell setContentPic:_picArr2 index:indexPath];
        }
    }
    return cell;
}
/////大图
- (void)showBigPhoto: (NSMutableArray *)array arrayIndex : (NSInteger)arrayIndex{
    NSMutableArray *myArr = [NSMutableArray new];
    for (int i = 0; i < array.count; i++) {
        draftListModel *model = array[i];
        NSString *url = [NSString stringWithFormat:@"%@%@",IDFordImageURL,model.url];
        [myArr addObject:[NSURL URLWithString:url]];
    }
    [XLPhotoBrowser showPhotoBrowserWithImages:myArr currentImageIndex:arrayIndex - 1];
}

///跳转到拍照页面
- (void)jumpTakePhoto:(NSMutableArray *) arr mySection : (NSInteger) mySection maxCount : (NSInteger) maxCount{
    IDFWeakSelf;
    if (arr.count == maxCount) {
        [SVProgressHUD showInfoWithStatus:@"照片上传数量已达上限\n若重新上传请删除部分图片"];
        [SVProgressHUD dismissWithDelay:1.5f];
    }else{
        differentSizePhotoVC *vc = [[differentSizePhotoVC alloc] init];
        vc.FLAG = mySection;
        vc.delegate = weakSelf;
        [vc setMaxImageCount:maxCount - arr.count];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }
}
////选中的图片更新model状态
- (NSMutableArray *)setItemState: (NSMutableArray *)arr index : (NSInteger)index{
    draftListModel *model = arr[index];
    if (model.chooseFlag) {
        model.chooseFlag = NO;
    }else{
        model.chooseFlag = YES;
    }
    [arr replaceObjectAtIndex:index withObject:model];
    return arr;
}

//collection head定义
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"collectionHead%ld%ld",(long)indexPath.section,(long)indexPath.row];
        
//        if (_TYPE == 0) {
//            if (indexPath.section < 2) {
//                [_collectionView registerClass:[collectionShortHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier];
//                collectionShortHead *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//                [head setHeadContent:_headNoConTitArray headNumber:_headNoConNumArray index:indexPath];
//                return head;
//            }else{
//                return [self setLongHead:1 identify:CellIdentifier index:indexPath collectionView:collectionView];
//            }
//        }else{
//            if (indexPath.section < 4) {
//                [_collectionView registerClass:[collectionShortHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier];
//                collectionShortHead *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//                [head setHeadContent:_headTitltArray headNumber:_headNumberArray index:indexPath];
//                return head;
//            }else{
//                return [self setLongHead:3 identify:CellIdentifier index:indexPath collectionView:collectionView];
//            }
//        }
                if (_TYPE == 0) {
                    return [self setLongHead:0 identify:CellIdentifier index:indexPath collectionView:collectionView];
                }else{
                    return [self setLongHead:0 identify:CellIdentifier index:indexPath collectionView:collectionView];
                }
    }else{
        return nil;
    }
}
- (collectionHeadCell *)setLongHead: (NSInteger)num identify :(NSString *)identify index :(NSIndexPath *)index collectionView :(UICollectionView *)collectionView {
    [_collectionView registerClass:[collectionHeadCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identify];
    collectionHeadCell *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identify forIndexPath:index];
    [head setHeadContent:_headLongTitleArray headContent:_headContentArray headNumber:_headLongNumArray index:index.section - num];
    return head;
}
- (void)backToMainView {
    IDFWeakSelf;
    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
}

- (void)backToDraft{
    IDFWeakSelf;
    
    //创建和发送通知
    NSNotification *notification =[NSNotification notificationWithName:@"InfoNotification" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//collection cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    if (_TYPE == 0) {
//        //无共借人
//        if (section < 2) {
//            return 1;
//        }else if (section == 2){
//            return _picArr1.count + 1;
//        }else{
//            return _picArr2.count + 1;
//        }
//    }else{
//        //有共借人
//        if (section < 4) {
//            return 1;
//        }else if (section == 4){
//            return _picArr1.count + 1;
//        }else{
//            return _picArr2.count + 1;
//        }
//    }
    if (section==0) {
        return _picArr1.count + 1;
    }else{
        return _picArr2.count + 1;
    }
}
//collection head个数   ....正式版改成（2，4）  (4, 6)
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    if (_TYPE == 0) {
//        //无共借人
//        return 4;
//    }else{
//        return 6;
//    }
    return 2;
}
#pragma mark - UICollectionViewDelegateFlowLayout
//每个cell的大小，因为有indexPath，所以可以判断哪一组，或者哪一个item，可一个给特定的大小，等同于layout的itemSize属性
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(90,90);
}

// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

// 设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (_TYPE == 0) {
        if (section == 0 || section == 1) {
            return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT/14);
        }else {
            return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT/12+20);
        }
    }else{
        if (section == 0 || section == 1 || section == 2 || section == 3) {
            return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT/14);
        }else {
            return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT/12+20);
        }
    }
}

@end
