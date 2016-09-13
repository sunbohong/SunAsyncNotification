//
//  SunAsyncNotification.m
//  AsyncNotifacationDemo
//
//  Created by sunbohong on 16/9/12.
//  Copyright © 2016年 sunbohong. All rights reserved.
//

#import "SunAsyncNotification.h"

@implementation SunAsyncNotification{
    NSMutableDictionary<NSString*,NSMutableDictionary<NSString*,SunAsyncNotificationBlock>*> *_dic;
}

+(SunAsyncNotification *)defaultCenter{
    static SunAsyncNotification *defaultCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCenter = [SunAsyncNotification new];
    });
    return defaultCenter;
}

-(instancetype)init{
    if (self=[super init]) {
        _dic=[NSMutableDictionary dictionary];
    }
    return self;
}

-(void)postNotification:(NSString *)note usingBlock:(SunAsyncNotificationBlock)block{
    SunAsyncNotificationBlock copyBlock = block;
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t targetQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    NSMutableDictionary<NSString*,SunAsyncNotificationBlock> *dic= _dic[note];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, SunAsyncNotificationBlock  _Nonnull obj, BOOL * _Nonnull stop) {
        dispatch_group_async(group, targetQueue, ^{
            obj(note);
        });
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [_dic removeObjectForKey:note];
        if (copyBlock) {
            copyBlock(note);
        }
    });
}

-(NSString *)addObserverForNote:(NSString *)note usingBlock:(SunAsyncNotificationBlock)block{
    if (nil == block) {
        return nil;
    }

    NSMutableDictionary<NSString*,SunAsyncNotificationBlock> *dic= _dic[note];
    if (!dic){
        dic= [NSMutableDictionary dictionary];
        _dic[note]=dic;
    }
    NSString *identifier=[[NSUUID UUID] UUIDString];
    dic[identifier]=[block copy];
    return identifier;
}

-(void)removeObserverWithIdentifier:(NSString *)iden{
    [_dic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSMutableDictionary<NSString *,dispatch_block_t> * _Nonnull obj, BOOL * _Nonnull stop) {
        [obj removeObjectForKey:iden];
    }];
}

-(void)removeAllObserver{
    _dic=[NSMutableDictionary dictionary];
}

@end
