# SunAsyncNotification
一个优雅的异步通知框架。

# Demo

```
-(void)time:(int )count{
    for(int i=0;i<count;i++){
        double count0;
        for (double j=0.0; j<1000000.0; j++) {
            count0=j*j;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    SunAsyncNotifacation *not = [SunAsyncNotifacation defaultCenter];
    NSString *SunLogoutCommand=@"退出登录";

    [not addObserverForNote:SunLogoutCommand usingBlock:^(NSString * _Nonnull note) {
        NSLog(@"接收到：%@,刷新界面A",note);
        [self time:arc4random_uniform(800)+100];
        NSLog(@"刷新界面A完成");
    }];

    [not addObserverForNote:SunLogoutCommand usingBlock:^(NSString * _Nonnull note) {
        NSLog(@"接收到：%@,刷新界面B",note);
        [self time:arc4random_uniform(800)+100];
        NSLog(@"刷新界面B完成");
    }];

    [not addObserverForNote:SunLogoutCommand usingBlock:^(NSString * _Nonnull note) {
        NSLog(@"接收到：%@,清理数据库",note);
        [self time:arc4random_uniform(800)+100];
        NSLog(@"清理数据库完成");
    }];

    NSLog(@"命令：%@",SunLogoutCommand);
    NSLog(@"显示HUD,开始执行准备操作");
    [not postNotification:SunLogoutCommand usingBlock:^(NSString * _Nonnull note) {
        NSLog(@"准备完成");
        NSLog(@"隐藏HUD，刷新界面");
    }];
}
```
