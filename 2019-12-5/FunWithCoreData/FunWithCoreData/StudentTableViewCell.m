//
//  StudentTableViewCell.m
//  FunWithCoreData
//
//  Created by 吉腾蛟 on 2019/12/5.
//  Copyright © 2019 JY. All rights reserved.
//

#import "StudentTableViewCell.h"

@interface StudentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation StudentTableViewCell

-(void)setContentWithStudentModel:(Student *)model{
    if ([model.sex isEqualToString:@"男"]) {
        self.iconImageView.image=[UIImage imageNamed:@"男"];
    }else if ([model.sex isEqualToString:@"女"]){
        self.iconImageView.image=[UIImage imageNamed:@"女"];
    }
    
    self.nameLabel.text=model.name;
    self.sexLabel.text=model.sex;
    self.ageLabel.text=[NSString stringWithFormat:@"%hd",model.age];
    self.heightLabel.text=[NSString stringWithFormat:@"%hd",model.height];
    self.numberLabel.text=[NSString stringWithFormat:@"%hd",model.number];
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
