//
//  SunAsyncNotification.h
//  AsyncNotifacationDemo
//
//  Created by sunbohong on 16/9/12.
//  Copyright © 2016年 sunbohong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SunAsyncNotificationBlock)(NSString *note);

@interface SunAsyncNotification : NSObject

@property (class, readonly, strong) SunAsyncNotification *defaultCenter;

- (void)postNotification:(NSString *)note usingBlock:(SunAsyncNotificationBlock)block;;

- (NSString*)addObserverForNote:(NSString *)note usingBlock:(SunAsyncNotificationBlock)block;

- (void)removeObserverWithIdentifier:(NSString*)iden;

- (void)removeAllObserver;

@end

NS_ASSUME_NONNULL_END
