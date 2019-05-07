//
//  FileUploadOutsiderTableViewCell.m
//  IDFord
//
//  Created by 吉腾蛟 on 2019/4/29.
//  Copyright © 2019 YWJ. All rights reserved.
//

#import "FileUploadOutsiderTableViewCell.h"
#import "AimHistoryContentCollectionReusableView.h"
#import "AimImageCollectionViewCell.h"
#import "AimsHistoryCellModel.h"

static NSString *cell_content_reuse=@"cell_content_reuse";
static NSString *cell_content_header_reuse=@"cell_content_header_reuse";

@interface FileUploadOutsiderTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *subCollectionView;


@property(nonatomic,strong)AimsHistorySectionModel *aimsHistorySection_model;

@property(nonatomic,strong)NSMutableArray<NSArray *> *result_array;
@property(nonatomic,strong)NSMutableArray *title_array;

//总共有多少行，需要空多少的距离
@property(nonatomic,assign)NSInteger rowHeightCount;
@property(nonatomic,assign)NSInteger noHeaderCount;

@end

@implementation FileUploadOutsiderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}
#pragma mark - 初始化UI
-(void)addUI{
    [self.contentView addSubview:self.subCollectionView];
    
    [self updateConstraintsIfNeeded];
}
#pragma mark - 懒加载
-(NSMutableArray *)result_array{
    if (!_result_array) {
        _result_array=[NSMutableArray array];
    }
    return _result_array;
}
-(NSMutableArray *)title_array{
    if (!_title_array) {
        _title_array=[NSMutableArray array];
    }
    return _title_array;
}
-(UICollectionView *)subCollectionView{
    if (!_subCollectionView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        _subCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        _subCollectionView.delegate=self;
        _subCollectionView.dataSource=self;
        _subCollectionView.backgroundColor=[UIColor whiteColor];
        
        [_subCollectionView registerClass:[AimImageCollectionViewCell class] forCellWithReuseIdentifier:cell_content_reuse];
        [_subCollectionView registerClass:[AimHistoryContentCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cell_content_header_reuse];
    }
    return _subCollectionView;
}

#pragma mark - 代理
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.result_array.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *array=self.result_array[section];
    return array.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AimImageCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cell_content_reuse forIndexPath:indexPath];
    
    NSArray<AimsHistoryCellModel *> *array=[AimsHistoryCellModel mj_objectArrayWithKeyValuesArray:self.result_array[indexPath.section]];
    
    [cell.image_View sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IDFordImageURL,array[indexPath.row].url]]];
    
    return cell;
}

//点击放大
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   NSArray<AimsHistoryCellModel *> *array=[AimsHistoryCellModel mj_objectArrayWithKeyValuesArray:self.result_array[indexPath.section]];
    
    NSMutableArray *nsurlArray=[NSMutableArray array];
    for (AimsHistoryCellModel *model in array) {
        [nsurlArray addObject:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IDFordImageURL,model.url]]];
    }

}

//设置layout
//每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(60, 60);
}
//创建区头视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    AimHistoryContentCollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:cell_content_header_reuse forIndexPath:indexPath];
    
    header.title_label.text=[self translateKeyToChinese:[NSString stringWithFormat:@"%@",self.title_array[indexPath.section]]];
    
    return header;
}
//区头大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 50);
}
//分区内cell之间的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10.0;
}
//分区内cell之间的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10.0;
}
#pragma mark - target action

#pragma mark - Maonry
-(void)updateConstraints{
    [super updateConstraints];
    [self.subCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(110*self.rowHeightCount-40*self.noHeaderCount);
    }];
}
#pragma mark - other 只有本页面会使用的工具方法
-(void)setCellContentWithAimsHistorySectionModel:(AimsHistorySectionModel *)model{
    //清空值
    [self.title_array removeAllObjects];
    [self.result_array removeAllObjects];
    self.rowHeightCount=0;
    self.noHeaderCount=0;
    
    NSMutableDictionary<NSString *,NSArray *> *dic=[model mj_keyValues];
    //如果值是array
    NSMutableArray *idProof_1=[NSMutableArray array];
    NSMutableArray *idProof_2=[NSMutableArray array];
    //申请阶段=======================================================================
    //1.申请人身份证明
    //申请人人像面
    if (dic[@"idproofA"].count>0) {
        [idProof_1 addObjectsFromArray:dic[@"idproofA"]];
    }
    //申请人国徽面
    if (dic[@"idproofB"].count>0) {
        [idProof_1 addObjectsFromArray:dic[@"idproofB"]];
    }
    //申请人真人照
    if (dic[@"living"].count>0) {
        [idProof_1 addObjectsFromArray:dic[@"living"]];
    }
    //2.共借人身份证明
    //共借人人像面
    if (dic[@"coidproofA"].count>0) {
        [idProof_2 addObjectsFromArray:dic[@"coidproofA"]];
    }
    //共借人国徽面
    if (dic[@"coidproofB"].count>0) {
        [idProof_2 addObjectsFromArray:dic[@"coidproofB"]];
    }
    //共借人真人照
    if (dic[@"coliving"].count>0) {
        [idProof_2 addObjectsFromArray:dic[@"coliving"]];
    }
    
    if (idProof_1.count>0) {
        [self.title_array addObject:@"idproofA"];
        [self.result_array addObject:idProof_1];
    }
    if (idProof_2.count>0) {
        [self.title_array addObject:@"coidproofA"];
        [self.result_array addObject:idProof_2];
    }
    //关系证明材料
    if (dic[@"coborrowrelation"].count>0) {
        [self.title_array addObject:@"coborrowrelation"];
        [self.result_array addObject:dic[@"coborrowrelation"]];
    }
    //个人汽车消费贷款申请表
    if (dic[@"applicationform"].count>0) {
        [self.title_array addObject:@"applicationform"];
        [self.result_array addObject:dic[@"applicationform"]];
    }
    //贷款申请资料确认表
    if (dic[@"applicationinfoform"].count>0) {
        [self.title_array addObject:@"applicationinfoform"];
        [self.result_array addObject:dic[@"applicationinfoform"]];
    }
    //驾驶证或相关证明
    if (dic[@"driverlicense"].count>0) {
        [self.title_array addObject:@"driverlicense"];
        [self.result_array addObject:dic[@"driverlicense"]];
    }
    //收入类证明
    if (dic[@"incomeproof"].count>0) {
        [self.title_array addObject:@"incomeproof"];
        [self.result_array addObject:dic[@"incomeproof"]];
    }
    //其他申请资料
    if (dic[@"applicationothers"].count>0) {
        [self.title_array addObject:@"applicationothers"];
        [self.result_array addObject:dic[@"applicationothers"]];
    }
    //二手车贷款申请资料
    if (dic[@"usedcar"].count>0) {
        [self.title_array addObject:@"usedcar"];
        [self.result_array addObject:dic[@"usedcar"]];
    }
    
    //放款阶段======================================================
    //申请人动态检测及签约照
    NSMutableArray *detection_1=[NSMutableArray array];
    NSMutableArray *detection_2=[NSMutableArray array];
    
    //1.
    //申请人动态检测及签约照
    if (dic[@"livingdetection"].count>0) {
        [detection_1 addObjectsFromArray:dic[@"livingdetection"]];
    }
    //申请人签约照
    if (dic[@"signing"].count>0) {
        [detection_1 addObjectsFromArray:dic[@"signing"]];
    }
    //申请人手持合同照
    if (dic[@"contract"].count>0) {
        [detection_1 addObjectsFromArray:dic[@"contract"]];
    }
    //2.
    //共借人动态检测及签约照
    if (dic[@"colivingdetection"].count>0) {
        [detection_2 addObjectsFromArray:dic[@"colivingdetection"]];
    }
    //共接人签约照
    if (dic[@"cosigning"].count>0) {
        [detection_2 addObjectsFromArray:dic[@"cosigning"]];
    }
    //共接人手持合同照
    if (dic[@"cocontract"].count>0) {
        [detection_2 addObjectsFromArray:dic[@"cocontract"]];
    }
    
    if (detection_1.count>0) {
        [self.title_array addObject:@"livingdetection"];
        [self.result_array addObject:detection_1];
    }
    if (detection_2.count>0) {
        [self.title_array addObject:@"colivingdetection"];
        [self.result_array addObject:detection_2];
    }
    //放款信息确认表
    if (dic[@"fundinginfoform"].count>0) {
        [self.title_array addObject:@"fundinginfoform"];
        [self.result_array addObject:dic[@"fundinginfoform"]];
    }
    //其他放款材料
    if (dic[@"fundingothers"].count>0) {
        [self.title_array addObject:@"fundingothers"];
        [self.result_array addObject:dic[@"fundingothers"]];
    }
    //设置多少行，需要空的距离
    for (int i=0; i<self.result_array.count; i++) {
        self.rowHeightCount++;
        NSArray *array=self.result_array[i];
        if (SCREEN_WIDTH>375) {
            //如果是大屏幕
            if (array.count>6) {
                if (array.count%6==0) {
                    
                }else{
                    self.rowHeightCount+=(NSInteger)(array.count/6.0);
                    self.noHeaderCount+=(NSInteger)(array.count/6.0);
                }
            }
        }else{
            //如果是iPhone 7 的小屏幕
            if (array.count>5) {
                if (array.count%5==0) {
                    
                }else{
                    self.rowHeightCount+=(NSInteger)(array.count/5.0);
                    self.noHeaderCount+=(NSInteger)(array.count/5.0);
                }
            }
        }
    }
    
    [self.subCollectionView reloadData];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(NSString *)translateKeyToChinese:(NSString *)originKey{
    if ([originKey isEqualToString:@"idproofA"] | [originKey isEqualToString:@"idproofB"] | [originKey isEqualToString:@"living"]) {
        return @"申请人身份证明";
    }else if ([originKey isEqualToString:@"coidproofA"] | [originKey isEqualToString:@"coidproofB"] | [originKey isEqualToString:@"coliving"]){
        return @"共借人身份证明";
    }else if ([originKey isEqualToString:@"coborrowrelation"]){
        return @"关系证明";
    }else if ([originKey isEqualToString:@"applicationform"]){
        return @"个人汽车消费贷款申请表";
    }else if ([originKey isEqualToString:@"applicationinfoform"]){
        return @"贷款申请资料确认表";
    }else if ([originKey isEqualToString:@"driverlicense"]){
        return @"驾驶证或相关证明";
    }else if ([originKey isEqualToString:@"incomeproof"]){
        return @"收入类证明";
    }else if ([originKey isEqualToString:@"applicationothers"]){
        return @"其他申请资料";
    }else if ([originKey isEqualToString:@"usedcar"]){
        return @"二手车贷款申请资料";
    }else if ([originKey isEqualToString:@"livingdetection"] | [originKey isEqualToString:@"contract"] | [originKey isEqualToString:@"signing"]){
        return @"申请人动态检测及签约照";
    }else if ([originKey isEqualToString:@"colivingdetection"] | [originKey isEqualToString:@"cocontract"] | [originKey isEqualToString:@"cosigning"]){
        return @"共借人动态检测及签约照";
    }else if ([originKey isEqualToString:@"fundinginfoform"]){
        return @"放款信息确认表";
    }else if ([originKey isEqualToString:@"fundingothers"]){
        return @"其他放款材料";
    }
    return @"";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
