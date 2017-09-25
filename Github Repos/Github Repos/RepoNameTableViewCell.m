//
//  RepoNameTableViewCell.m
//  Github Repos
//
//  Created by Paul on 2017-09-25.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "RepoNameTableViewCell.h"

@interface RepoNameTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *repoNameLabel;


@end

@implementation RepoNameTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureWithRepoName:(NSString *)name{

    self.repoNameLabel.text = name;
}




@end
