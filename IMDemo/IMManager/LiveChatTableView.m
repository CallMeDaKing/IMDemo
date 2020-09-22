//
//  LiveChatTableView.m
//  LJSports
//
//  Created by CallMeDaKing on 2020/9/20.
//  Copyright © 2020 王海涛. All rights reserved.
//

#import "LiveChatTableView.h"
#import "LiveEnterBulletModel.h"
#import "LiveTextBulletModel.h"
#import "LiveGiftModel.h"
#import "IMBulletTableViewCell.h"

@implementation LiveChatTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self. dataArray = [NSMutableArray array];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return  self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.dataArray==nil||self.dataArray.count==0) {
        return 1;  // 系统默认系统提示
    }
    
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LiveEnterBulletModel *aModel = nil;
    LiveTextBulletModel *messageModel = nil;
    if (self.dataArray==nil || self.dataArray.count==0 || self.dataArray.count-1 < indexPath.row) {
        //2.1、横屏发弹幕，无弹幕默认提示语
//        LiveEnterBulletModel = [[ZFBulletModel alloc] init];
//        aModel.msgColor = UIColorFromRGB(0x9090A2);
//        aModel.nickName = @"平台公告";
//        aModel.msgText = [ZFTVDataCenter shareDataCenter].liveAnnouncement.length ? [ZFTVDataCenter shareDataCenter].liveAnnouncement : @"抓鱼直播倡导绿色健康的直播环境，平台将对直播内容进行巡查，不得出现违法、侵权、低俗、非法广告、赌博等不良内容，不得推广联系方式（QQ群、微信、公众号等），不得出现横幅以及暗示性词语（红单、首存等），经发现均会被处理并追责。直播间主播以及用户仅代表个人观点，不代表官方意见，如有问题请与客服联系";
//        aModel.modelType = @"bullet";
//        [self.dataArray insertObject:aModel atIndex:0];
//
//        aModel2 = [[ZFBulletModel alloc] init];
//        aModel2.msgColor = UIColorFromRGB(0x9090A2);
//        aModel2.nickName = @"管理员";
//        aModel2.msgText = @"欢迎进入直播间";
//        aModel2.modelType = @"bullet";
//        ZFBulletAdditionModel *add = [[ZFBulletAdditionModel alloc] init];
//        add.firstRechargeFrame = -1;
//        add.firstRechargeMedal = -1;
//        aModel2.additionModel = add;
        
//        [self.dataArray insertObject:aModel2 atIndex:1];
    } else {
        if (indexPath.row < self.dataArray.count) {
            messageModel = [self.dataArray objectAtIndex:indexPath.row];
        }
    }
    //3、竖屏发表弹幕 (主播竖屏开播接收弹幕)
    if (self.isVertical) {
//        static  NSString *str1 = @"bulletVerticalShowTableViewCell";
//        ZFBulletVerticalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str1];
//        if (cell==nil) {
//            cell = [[ZFBulletVerticalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        [cell setBulletWithModel:aModel withTime:self.playerTimeIntervale];
//        return cell;
        
    }else{
        static  NSString *str = @"bulletShowTableViewCell";
        IMBulletTableViewCell *cell = [tableView  cellForRowAtIndexPath:indexPath];
        if (cell==nil) {
            cell = [[IMBulletTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }
    return nil;
} 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isVertical) {//1、竖屏
        if (self.dataArray==nil||self.dataArray.count==0) {
            return 46;
        }else if (indexPath.row > self.dataArray.count-1){
            return 0;
        }
        
        LiveTextBulletModel *aModel = [self.dataArray objectAtIndex:indexPath.row];
        float contentWidth = self.frame.size.width-14-14;
        CGSize contentSize = [aModel.messageTxt sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
        int lines = contentSize.width / contentWidth + 2;
        
        return 18*lines + 10;
    }
    
    if (self.dataArray==nil||self.dataArray.count==0) {
        return 26;
    }else if (indexPath.row > self.dataArray.count-1){
        return 0;
    }
    LiveTextBulletModel *aModel = [self.dataArray objectAtIndex:indexPath.row];
    
    NSString *showString = @"";
    if ([LiveTextBulletModel.modelType isEqualToString:@"bullet"]) {
        showString = [NSString stringWithFormat:@"%@ : %@",aModel.nickName,aModel.msgText];
    }
    
    if ([aModel.modelType isEqualToString:@"enterroom"]) {
        showString = [NSString stringWithFormat:@"%@  %@",aModel.nickName,aModel.msgText];
    }
    
    if ([aModel.modelType isEqualToString:@"Gift"]) {
        showString = aModel.msgText;
    }
    
    if ([aModel.modelType isEqualToString:@"Red"]) {
        showString = [NSString stringWithFormat:@"%@: 收到主播答谢的 %@元红包",aModel.nickName,aModel.redMoney];
    }
    
    if([aModel.modelType isEqualToString:@"Lucky"])
    {
        showString = [NSString stringWithFormat:@"恭喜 %@ 送出 %@x%ld，赢得 %ld鱼币",aModel.nickName,aModel.giftName,(long)aModel.giftNum,(long)aModel.giftMoney];
    }
    
    if ([aModel.modelType isEqualToString:@"barrage"]) {
        showString = aModel.msgText;
    }
    
    if ([aModel.modelType isEqualToString:@"eggbarrage"]) {
        showString = aModel.msgText;
    }
    if ([aModel.modelType isEqualToString:@"eggcompetitionwin"]) {
        showString = [aModel.subMsgTextAttributedStr string];
    }
    
    float maxLabelWidth = SCREEN_WIDTH - 20;
    if (aModel.additionModel) {
        // 显示贵族徽章
        if (aModel.additionModel.viplevel > 0) {
            if (aModel.additionModel.firstRechargeFrame == 1) {
                maxLabelWidth = SCREEN_WIDTH - 129;
            } else {
                maxLabelWidth = SCREEN_WIDTH - 94;
            }
        } else {
            if (aModel.additionModel.firstRechargeFrame == 1) {
                maxLabelWidth = SCREEN_WIDTH - 94;
            } else {
                if ([aModel.nickName isEqualToString:@"平台公告"]) {
                    maxLabelWidth = SCREEN_WIDTH - 20;
                } else {
                    maxLabelWidth = SCREEN_WIDTH - 59;
                }
            }
        }
    }
    CGSize contentSize = [self getSizeWithLableWithString:showString nickName:aModel.nickName font:12 maxLabelWidth:maxLabelWidth];

    if ([aModel.nickName isEqualToString:@"平台公告"]) {
        contentSize.height += 14;
    } else {
        if (contentSize.height > 21 && contentSize.height < 140){
            contentSize.height = 40;
        } else {
            contentSize.height = 30;
        }
    }
    return contentSize.height;
}

// 计算label  高度暂时不使用这个方法
- (CGSize)getSizeWithLableWithString:(NSString *)string nickName:(NSString *)nickName font:(CGFloat)font maxLabelWidth:(CGFloat)maxLabelWidth
{
    if (!self.sizeLabel) {
        self.sizeLabel = [[UILabel alloc] init];
        self.sizeLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    self.sizeLabel.frame = CGRectMake(0, 0, maxLabelWidth, 0);
    self.sizeLabel.font = PFTRFontWithSize(12);
    self.sizeLabel.numberOfLines = 0;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    // 基础字体
    [attributedString addAttribute:NSFontAttributeName value:PFTRFontWithSize(12) range:NSMakeRange(0, string.length)];
    // 昵称字体加粗
    if ([string containsString:nickName]) {
        [attributedString addAttribute:NSFontAttributeName value:PFTRFontWithSize(12) range:NSMakeRange(0, nickName.length+2)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, nickName.length+2)];
    }
    // 字体颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, string.length)];
    
    self.sizeLabel.text = string;
    [self.sizeLabel sizeToFit];
    return CGSizeMake(self.sizeLabel.bounds.size.width, self.sizeLabel.bounds.size.height);
}

- (NSUInteger)characterCountForString:(NSString *)text {
    NSUInteger  character = 0;
    for(int i=0; i< [text length];i++){
        int a = [text characterAtIndex:i];
        if( a >= 0x4e00 && a <= 0x9fa5) {
            character +=2;
        }else{
            character +=1;
        }
    }
    return character;
}

- (CGFloat)getContentMaxHeightWithMessage:(NSString *)message
                                 MaxWidth:(CGFloat)maxWidth {
    CGSize contentSize = [message boundingRectWithSize:CGSizeMake(maxWidth,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return contentSize.height + 18;
}


@end
