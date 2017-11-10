//
//  HZGesturePwdVerityViewController.m
//  HZGestureUnlockExample
//
//  Created by 季怀斌 on 2017/11/10.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import "HZGesturePwdVerityViewController.h"
#import "HZCircleViewConst.h"
#import "HZCircleView.h"
#import "HZLockLabel.h"
#import "HZGestureUnlockViewController.h"

@interface HZGesturePwdVerityViewController ()<HZCircleViewDelegate>

/**
 *  文字提示Label
 */
@property (nonatomic, strong) HZLockLabel *msgLabel;

@end

@implementation HZGesturePwdVerityViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:CircleViewBackgroundColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"验证手势解锁";
    
    HZCircleView *lockView = [[HZCircleView alloc] init];
    lockView.delegate = self;
    [lockView setType:HZCircleViewTypeVerify];
    [self.view addSubview:lockView];
    
    HZLockLabel *msgLabel = [[HZLockLabel alloc] init];
    msgLabel.frame = CGRectMake(0, 0, kScreenW, 14);
    msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(lockView.frame) - 30);
    [msgLabel showNormalMsg:gestureTextOldGesture];
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
}

#pragma mark - login or verify gesture
- (void)circleView:(HZCircleView *)view type:(HZCircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    if (type == HZCircleViewTypeVerify) {
        
        if (equal) {
            NSLog(@"验证成功");
            
            if (self.isToSetNewGesture) {
                HZGestureUnlockViewController *gestureVc = [[HZGestureUnlockViewController alloc] init];
                [gestureVc setType:HZGestureUnlockViewControllerTypeSetting];
                [self.navigationController pushViewController:gestureVc animated:YES];
            } else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        } else {
            NSLog(@"密码错误！");
            [self.msgLabel showWarnMsgAndShake:gestureTextGestureVerifyError];
        }
    }
}
@end
