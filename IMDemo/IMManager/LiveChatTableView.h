//
//  LiveChatTableView.h
//  LJSports
//
//  Created by CallMeDaKing on 2020/9/20.
//  Copyright © 2020 王海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveChatTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isVertical;
@end

NS_ASSUME_NONNULL_END
