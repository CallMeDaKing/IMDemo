//
//  IMBulletTableViewCell.m
//  LJSports
//
//  Created by CallMeDaKing on 2020/9/20.
//  Copyright © 2020 王海涛. All rights reserved.
//

#import "IMBulletTableViewCell.h"

@implementation IMBulletTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupContentView];
    }
    return self;
}


- (void)setModel:(LiveTextBulletModel *)model {
    _model = model;
}
@end
