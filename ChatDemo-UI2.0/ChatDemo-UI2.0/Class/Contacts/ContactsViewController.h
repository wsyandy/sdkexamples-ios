//
//  ContactsViewController.h
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-23.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ContactsViewController : BaseViewController

@property (strong, nonatomic) NSMutableArray *applysArray;

- (void)reloadApplyView;

- (void)addFriendAction;

@end
