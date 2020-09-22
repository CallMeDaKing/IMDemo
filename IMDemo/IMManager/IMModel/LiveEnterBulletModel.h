//
//  LiveEnterBulletModel.h
//  LJSports
//
//  Created by CallMeDaKing on 2020/9/20.
//  Copyright © 2020 王海涛. All rights reserved.


/* 消息格式文档  参考 https://note.youdao.com/ynoteshare1/index.html?id=de7f94e293966ece969359b7b393c439&type=note
 **/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PrivageModel <NSObject>

@end
@interface PrivageModel : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *name;

@end


@interface LiveNobleModel : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *levelName;
@property (nonatomic, copy) NSString *expireTime;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *framePic;
@property (nonatomic, copy) NSString *mobileVerticalAnimUrl;
@property (nonatomic, copy) NSString *mobileLandAnimUrl;
@property (nonatomic, copy) NSString *webAnimUrl;
@property (nonatomic, copy) NSString *canResume;
@property (nonatomic, copy) NSArray<PrivageModel> *privilege;

@end


@interface LevelModel : NSObject

@property (nonatomic, copy) NSString *exp;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *nextLevelExp;
@property (nonatomic, copy) NSString *type;  // anchor
@property (nonatomic, copy) NSString *uid;

@end


@interface LiveLevelModel : NSObject

@property (nonatomic, strong) LevelModel *anchorLevel;
@property (nonatomic, strong) LevelModel *userLevel;

@end


//直播间入场消息:10003
@interface LiveEnterBulletModel : NSObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *figureUrl;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *rommAdmin;
@property (nonatomic, copy) NSString *superAdmin;
@property (nonatomic, strong) LiveLevelModel *level;
@property (nonatomic, strong) LiveNobleModel *noble;

@end

NS_ASSUME_NONNULL_END
