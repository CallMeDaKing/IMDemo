//
//  LiveGiftModel.h
//  LJSports
//
//  Created by CallMeDaKing on 2020/9/20.
//  Copyright © 2020 王海涛. All rights reserved.
//

/* 消息格式文档  参考 https://note.youdao.com/ynoteshare1/index.html?id=de7f94e293966ece969359b7b393c439&type=note
 **/


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 普通礼物消息: 10004    免费礼物消息: 10005
@interface LiveGiftModel : NSObject

@property (nonatomic, copy) NSString *ext;
@property (nonatomic, copy) NSString *roomId;
@property (nonatomic, copy) NSString *giftIcon;
@property (nonatomic, copy) NSString *giftId;
@property (nonatomic, copy) NSString *giftName;
@property (nonatomic, copy) NSString *giftNum;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *figureUrl;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *nobleLevel;
@property (nonatomic, copy) NSString *roomAdmin;
@property (nonatomic, copy) NSString *superAdmin;
@property (nonatomic, copy) NSString *firstRecharge;
@property (nonatomic, copy) NSString *webBgUrl;
@property (nonatomic, copy) NSString *isDoubleHit;
@property (nonatomic, copy) NSString *doubleHitCurrentGiftNum;
@property (nonatomic, copy) NSString *doubleHitGroupGiftNum;
@property (nonatomic, copy) NSString *isAnimation;
@property (nonatomic, copy) NSString *mobileAnimType;
@property (nonatomic, copy) NSString *mobileVerticalAnimUrl;
@property (nonatomic, copy) NSString *mobileLandAnimUrl;
@property (nonatomic, copy) NSString *webAnimType;
@property (nonatomic, copy) NSString *webAnimUrl;
@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *barrageListShow;

@end

NS_ASSUME_NONNULL_END
