//
//  LiveTextBulletModel.h
//  LJSports
//
//  Created by CallMeDaKing on 2020/9/20.
//  Copyright © 2020 王海涛. All rights reserved.
//

/* 消息格式文档  参考 https://note.youdao.com/ynoteshare1/index.html?id=de7f94e293966ece969359b7b393c439&type=note
 **/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SendModel <NSObject>
@end

@interface SendModel : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *levelIcon;
@property (nonatomic, copy) NSString *firstRecharge;
@property (nonatomic, copy) NSString *firstRechargeMedal;
@property (nonatomic, copy) NSString *nobleMedal;
@property (nonatomic, copy) NSString *signMedal;
@property (nonatomic, copy) NSString *midAutumnMedal;
@property (nonatomic, copy) NSString *medalExt;
@property (nonatomic, copy) NSString *medalExt1;
@property (nonatomic, copy) NSString *medalExt2;
@property (nonatomic, copy) NSString *medalExt3;

@end

// "type" : 10001   普通聊天消息
@interface LiveTextBulletModel : NSObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *messageTxt;
@property (nonatomic, copy) NSString *messageColor;
@property (nonatomic, strong) SendModel *sender;

@end

NS_ASSUME_NONNULL_END
