//
//  IMManager.m
//  LJSports
//
//  Created by CallMeDaKing on 2020/9/20.
//  Copyright © 2020 王海涛. All rights reserved.
//

#import "IMManager.h"
#import "LiveEnterBulletModel.h"
#import "LiveTextBulletModel.h"
#import "LiveGiftModel.h"
#import "NSObject+YYModel.h"

#import <NIMSDK/NIMSDK.h>
#define NIMMyAccount   @"helloworld03"
#define NIMMyToken     @"27040c3be33e40c2bd4a9677fc5353c9"

#define NIMMyAccount1  @"helloworld02"
#define NIMMyToken1    @"dc467e7596e8441a99b001fc42ce64e0"

#define LiveRoomId     @"229856665"

@interface IMManager () <NIMLoginManagerDelegate,NIMChatManagerDelegate,NIMChatroomManagerDelegate>

@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) UIViewController *liveChatViewController;
@property (nonatomic, strong) NSMutableArray *bulletDataArray;

@property (strong, nonatomic) dispatch_semaphore_t messageSemaphore;
@end

@implementation IMManager

+ (IMManager *)shareInstance {
    
    static IMManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[IMManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NIMSDK sharedSDK].loginManager addDelegate:self];
        [[NIMSDK sharedSDK].chatroomManager addDelegate:self];
        [[NIMSDK sharedSDK].chatManager addDelegate:self];
        self.messageSemaphore = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)loginIMWithAccountID:(NSString *)accid tooken:(NSString *)token {
    
    //测试账号
    [[NIMSDK sharedSDK].loginManager login:NIMMyAccount token:NIMMyToken  completion:^(NSError *error) {
        if (!error) {
            self.isLogin = YES;
            [self joinRoomWithLogin:YES];
        }else{
            self.isLogin = NO;
            [self joinRoomWithLogin:NO];
        }
    }];
}

- (void)joinRoomWithLogin:(BOOL)isLogin {
    if (isLogin) {
        // 登录状态进入聊天 （测试使用 ，个人信息暂时写死）
        NIMChatroomEnterRequest *joinRequest = [[NIMChatroomEnterRequest alloc] init];
        joinRequest.roomId = LiveRoomId;
        joinRequest.roomNickname = @"DaKing";
        joinRequest.roomExt = @"Mr_Li";
        joinRequest.roomNotifyExt = @"Mr_Li先生";
        joinRequest.retryCount = 5;
        
        [[NIMSDK sharedSDK].chatroomManager enterChatroom:joinRequest completion:^(NSError * _Nullable error, NIMChatroom * _Nullable chatroom, NIMChatroomMember * _Nullable me) {
            if (!error) {
                NSLog(@"加入聊天室成功");
                
                [[NIMSDK sharedSDK].chatroomManager fetchChatroomInfo:LiveRoomId completion:^(NSError * _Nullable error, NIMChatroom * _Nullable chatroom) {
                    NSLog(@"聊天室信息-- %@",chatroom);
                }];
            } else {
                NSLog(@"进入房间失败--%@",error);
            }
        }];
    } else {
        // 游客模式进入聊天
        
    }
}

#pragma mark -- NIMChatManagerDelegate
- (void)onRecvMessages:(NSArray<NIMMessage *> *)messages {
    
    dispatch_semaphore_wait(self.messageSemaphore, DISPATCH_TIME_FOREVER);
    if (messages) {
        NSLog(@"接受消息%@",messages);
        for (int i = 0; i < messages.count; i ++) {
            NIMMessage *message = messages[i];
            NSString *jsonStr = message.text;
            if (!jsonStr) {
                return;
            }
            NSError *err;
            NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *messageDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
            if (err) {
                NSLog(@"解析失败%@",err);
            }
            [self updateBulletTableViewWithMessage:messageDic];
            dispatch_semaphore_signal(self.messageSemaphore);
        }
    }
}

- (void)updateBulletTableViewWithMessage:(NSDictionary *)message {
    NSString *messageType = [NSString stringWithFormat:@"%@",[message objectForKey:@"type"]];
    //  10001 : 普通消息    10003: 进入房间    10004 : 免费礼物 10005 普通礼物
    if ([messageType isEqualToString:@"100003"]) {
        LiveEnterBulletModel *Model = [LiveEnterBulletModel modelWithDictionary:message];
        [self.bulletDataArray addObject:Model];
    } else if ([messageType isEqualToString:@"10004"] || [messageType isEqualToString:@"10005"]) {
        LiveGiftModel *model = [LiveGiftModel modelWithDictionary:message];
        [self.bulletDataArray addObject:model];
    } else if ([messageType isEqualToString:@"10001"]) {
        LiveTextBulletModel *model = [LiveTextBulletModel modelWithDictionary:message];
        [self.bulletDataArray addObject:model];
    }
    
    self.bulletTableView.dataArray = self.bulletDataArray;
    // 更新视图
    [self.bulletTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.bulletDataArray.count-1 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

/**
*  发送消息完成回调
*
*  @param message 当前发送的消息
*  @param error   失败原因,如果发送成功则error为nil
*/
- (void)sendMessage:(NIMMessage *)message didCompleteWithError:(nullable NSError *)error {
    NSLog(@"发送完消息回调%@ -- error %@",message, error);
}

#pragma mark -- NIMChatroomManagerDelegate

/**
 *  聊天室连接状态变化
 *
 *  @param roomId 聊天室Id
 *  @param state  当前状态
 */
- (void)chatroom:(NSString *)roomId connectionStateChanged:(NIMChatroomConnectionState)state{
    NSLog(@"房间链接状态%ld",(long)state);
}
- (void)dealloc {
    [[NIMSDK sharedSDK].chatManager removeDelegate:self];
    [[NIMSDK sharedSDK].loginManager removeDelegate:self];
    [[NIMSDK sharedSDK].chatroomManager removeDelegate:self];
}


- (NSMutableArray *)bulletDataArray {
    if (_bulletDataArray == nil) {
        _bulletDataArray = [NSMutableArray array];
    }
    return _bulletDataArray;
}
@end
