//
//  HZGestureUnlockViewController.m
//  HZGestureUnlockExample
//
//  Created by 季怀斌 on 2017/11/10.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import "HZGestureUnlockViewController.h"
#import "HZCircleView.h"
#import "HZCircleViewConst.h"
#import "HZLockLabel.h"
#import "HZCircleInforView.h"
#import "HZCircle.h"

@interface HZGestureUnlockViewController ()<UINavigationControllerDelegate, HZCircleViewDelegate>

/**
 *  提示Label
 */
@property (nonatomic, strong) HZLockLabel *msgLabel;

/**
 *  解锁界面
 */
@property (nonatomic, strong) HZCircleView *lockView;

/**
 *  infoView
 */
@property (nonatomic, strong) HZCircleInforView *infoView;

@end

@implementation HZGestureUnlockViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 进来先清空存的第一个密码
    [HZCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:CircleViewBackgroundColor];
    
    self.navigationController.delegate = self;
    
    // 1.界面相同部分生成器
    [self setupSameUI];
    
    // 2.界面不同部分生成器
    [self setupDifferentUI];
}

#pragma mark - 界面不同部分生成器
- (void)setupDifferentUI
{
    switch (self.type) {
        case HZGestureUnlockViewControllerTypeSetting:
            [self setupSubViewsSettingVc];
            break;
        case HZGestureUnlockViewControllerTypeLogin:
            [self setupSubViewsLoginVc];
            break;
        default:
            break;
    }
}

#pragma mark - 界面相同部分生成器
- (void)setupSameUI
{
    // 解锁界面
    HZCircleView *lockView = [[HZCircleView alloc] init];
    lockView.delegate = self;
    self.lockView = lockView;
    [self.view addSubview:lockView];
    
    HZLockLabel *msgLabel = [[HZLockLabel alloc] init];
    msgLabel.frame = CGRectMake(0, 0, kScreenW, 14);
    msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(lockView.frame) - 30);
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
}

#pragma mark - 设置手势密码界面
- (void)setupSubViewsSettingVc
{
    [self.lockView setType:HZCircleViewTypeSetting];
    
    self.title = @"设置手势密码";
    
    [self.msgLabel showNormalMsg:gestureTextBeforeSet];
    
    HZCircleInforView *infoView = [[HZCircleInforView alloc] init];
    infoView.frame = CGRectMake(0, 0, CircleRadius * 2 * 0.6, CircleRadius * 2 * 0.6);
    infoView.center = CGPointMake(kScreenW/2, CGRectGetMinY(self.msgLabel.frame) - CGRectGetHeight(infoView.frame)/2 - 10);
    self.infoView = infoView;
    [self.view addSubview:infoView];
}

#pragma mark - 登陆手势密码界面
- (void)setupSubViewsLoginVc
{
    [self.lockView setType:HZCircleViewTypeLogin];
    
    // 头像
    UIImageView  *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 65, 65);
    imageView.center = CGPointMake(kScreenW/2, kScreenH/5);
    [imageView setImage:[UIImage imageNamed:@"head"]];
    [self.view addSubview:imageView];
    
    // 管理手势密码
    UIButton *leftBtn = [UIButton new];
    [self creatButton:leftBtn frame:CGRectMake(CircleViewEdgeMargin + 20, kScreenH - 60, kScreenW/2, 20) title:@"管理手势密码" alignment:UIControlContentHorizontalAlignmentLeft tag:buttonTagManager];
    
    // 登录其他账户
    UIButton *rightBtn = [UIButton new];
    [self creatButton:rightBtn frame:CGRectMake(kScreenW/2 - CircleViewEdgeMargin - 20, kScreenH - 60, kScreenW/2, 20) title:@"登陆其他账户" alignment:UIControlContentHorizontalAlignmentRight tag:buttonTagForget];
}

#pragma mark - 创建UIButton
- (void)creatButton:(UIButton *)btn frame:(CGRect)frame title:(NSString *)title alignment:(UIControlContentHorizontalAlignment)alignment tag:(NSInteger)tag
{
    btn.frame = frame;
    btn.tag = tag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:alignment];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didClickRightItem {
    NSLog(@"点击了重设按钮");
    // 1.隐藏按钮
    self.navigationItem.rightBarButtonItem.title = nil;
    
    // 2.infoView取消选中
    [self infoViewDeselectedSubviews];
    
    // 3.msgLabel提示文字复位
    [self.msgLabel showNormalMsg:gestureTextBeforeSet];
    
    // 4.清除之前存储的密码
    [HZCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
}

#pragma mark - button点击事件
- (void)didClickBtn:(UIButton *)sender
{
    NSLog(@"%ld", (long)sender.tag);
    switch (sender.tag) {
        case buttonTagManager:
        {
            NSLog(@"点击了管理手势密码按钮");
            
        }
            break;
        case buttonTagForget:
            NSLog(@"点击了登录其他账户按钮");
            
            break;
        default:
            break;
    }
}

#pragma mark - circleView - delegate
#pragma mark - circleView - delegate - setting
- (void)circleView:(HZCircleView *)view type:(HZCircleViewType)type connectCirclesLessThanNeedWithGesture:(NSString *)gesture
{
    NSString *gestureOne = [HZCircleViewConst getGestureWithKey:gestureOneSaveKey];
    
    // 看是否存在第一个密码
    if ([gestureOne length]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"重设" style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightItem)];
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
    } else {
        NSLog(@"密码长度不合法%@", gesture);
        [self.msgLabel showWarnMsgAndShake:gestureTextConnectLess];
    }
}

- (void)circleView:(HZCircleView *)view type:(HZCircleViewType)type didCompleteSetFirstGesture:(NSString *)gesture
{
    NSLog(@"获得第一个手势密码%@", gesture);
    [self.msgLabel showWarnMsg:gestureTextDrawAgain];
    
    // infoView展示对应选中的圆
    [self infoViewSelectedSubviewsSameAsCircleView:view];
}

- (void)circleView:(HZCircleView *)view type:(HZCircleViewType)type didCompleteSetSecondGesture:(NSString *)gesture result:(BOOL)equal
{
    NSLog(@"获得第二个手势密码%@",gesture);
    
    if (equal) {
        
        NSLog(@"两次手势匹配！可以进行本地化保存了");
        
        [self.msgLabel showWarnMsg:gestureTextSetSuccess];
        [HZCircleViewConst saveGesture:gesture Key:gestureFinalSaveKey];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } else {
        NSLog(@"两次手势不匹配！");
        
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"重设" style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightItem)];
    }
}

#pragma mark - circleView - delegate - login or verify gesture
- (void)circleView:(HZCircleView *)view type:(HZCircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    // 此时的type有两种情况 Login or verify
    if (type == HZCircleViewTypeLogin) {
        
        if (equal) {
            //
            [self setAlert:@"登陆成功" isSuccess:YES];
            //
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self.msgLabel showWarnMsgAndShake:@"密码正确"];
        } else {
            [self setAlert:@"密码错误" isSuccess:NO];
            [self.msgLabel showWarnMsgAndShake:gestureTextGestureVerifyError];
        }
    } else if (type == HZCircleViewTypeVerify) {
        
        if (equal) {
            NSLog(@"验证成功，跳转到设置手势界面");
            
        } else {
            NSLog(@"原手势密码输入错误！");
            
        }
    }
}


- (void)setAlert:(NSString *)alertStr isSuccess:(BOOL)isSuccess {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:alertStr preferredStyle:UIAlertControllerStyleAlert];
    
    
    NSString *ensureStr = isSuccess ? @"确定" : @"再试";
   
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:ensureStr style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *set = [UIAlertAction actionWithTitle:@"重制" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        HZGestureUnlockViewController *gestureVc = [[HZGestureUnlockViewController alloc] init];
        gestureVc.type = HZGestureUnlockViewControllerTypeSetting;
        [self.navigationController pushViewController:gestureVc animated:YES];
    }];
    
    [alertVc addAction:cancel];
    if (!isSuccess) {
        [alertVc addAction:set];
    }
    
    [self presentViewController:alertVc animated:YES
                     completion:nil];
}
#pragma mark - infoView展示方法
#pragma mark - 让infoView对应按钮选中
- (void)infoViewSelectedSubviewsSameAsCircleView:(HZCircleView *)circleView {
    for (HZCircle *circle in circleView.subviews) {
        
        if (circle.state == CircleStateSelected || circle.state == CircleStateLastOneSelected) {
            
            for (HZCircle *infoCircle in self.infoView.subviews) {
                if (infoCircle.tag == circle.tag) {
                    [infoCircle setState:CircleStateSelected];
                }
            }
        }
    }
}

#pragma mark - 让infoView对应按钮取消选中

- (void)infoViewDeselectedSubviews {
    [self.infoView.subviews enumerateObjectsUsingBlock:^(HZCircle *obj, NSUInteger idx, BOOL *stop) {
        [obj setState:CircleStateNormal];
    }];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isLoginType = [viewController isKindOfClass:[self class]];
    
    if (self.type == HZGestureUnlockViewControllerTypeLogin) {
        [self.navigationController setNavigationBarHidden:isLoginType animated:YES];
    }
}

@end
