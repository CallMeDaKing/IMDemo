//
//  IMManager.h
//  LJSports
//
//  Created by CallMeDaKing on 2020/9/20.
//  Copyright © 2020 王海涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveChatTableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface IMManager : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, strong) LiveChatTableView *bulletTableView;

//- (void)addIMDelegateController:(UIViewController *)chatViewController;
// 登录
- (void)loginIMWithAccountID:(NSString *)accid tooken:(NSString *)token;

@end

NS_ASSUME_NONNULL_END
