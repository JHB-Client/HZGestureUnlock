//
//  ViewController.m
//  HZGestureUnlockExample
//
//  Created by 季怀斌 on 2017/11/10.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import "ViewController.h"
#import "HZGestureUnlock.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"登录";
}


-(void)viewDidAppear:(BOOL)animated {
    
    if ([[HZCircleViewConst getGestureWithKey:gestureFinalSaveKey] length]) {
        HZGestureUnlockViewController *gestureVc = [[HZGestureUnlockViewController alloc] init];
        gestureVc.type = HZGestureUnlockViewControllerTypeLogin;
        [self.view addSubview:gestureVc.view];
        [self addChildViewController:gestureVc];
    } else {
        
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂未设置手势密码，是否前往设置？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *set = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            HZGestureUnlockViewController *gestureVc = [[HZGestureUnlockViewController alloc] init];
            gestureVc.type = HZGestureUnlockViewControllerTypeSetting;
            [self.navigationController pushViewController:gestureVc animated:YES];
        }];
        [alertVc addAction:cancel];
        [alertVc addAction:set];
        [self presentViewController:alertVc animated:YES
                         completion:nil];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    HZGesturePwdVerityViewController *gestureVerifyVc = [[HZGesturePwdVerityViewController alloc] init];
    gestureVerifyVc.isToSetNewGesture = YES;
    [self.navigationController pushViewController:gestureVerifyVc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
