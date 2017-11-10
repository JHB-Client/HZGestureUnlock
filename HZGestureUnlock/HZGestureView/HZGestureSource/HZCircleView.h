//
//  HZCircleView.h
//  HZGestureUnlockExample
//
//  Created by 季怀斌 on 2017/11/10.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  手势密码界面用途类型
 */
typedef enum {
    HZCircleViewTypeSetting = 1, // 设置手势密码
    HZCircleViewTypeLogin,       // 登陆手势密码
    HZCircleViewTypeVerify       // 验证旧手势密码
    
}HZCircleViewType;

@class HZCircleView;

@protocol HZCircleViewDelegate <NSObject>

@optional

#pragma mark - 设置手势密码代理方法
/**
 *  连线个数少于4个时，通知代理
 *
 *  @param view    circleView
 *  @param type    type
 *  @param gesture 手势结果
 */
- (void)circleView:(HZCircleView *)view type:(HZCircleViewType)type connectCirclesLessThanNeedWithGesture:(NSString *)gesture;

/**
 *  连线个数多于或等于4个，获取到第一个手势密码时通知代理
 *
 *  @param view    circleView
 *  @param type    type
 *  @param gesture 第一个次保存的密码
 */
- (void)circleView:(HZCircleView *)view type:(HZCircleViewType)type didCompleteSetFirstGesture:(NSString *)gesture;

/**
 *  获取到第二个手势密码时通知代理
 *
 *  @param view    circleView
 *  @param type    type
 *  @param gesture 第二次手势密码
 *  @param equal   第二次和第一次获得的手势密码匹配结果
 */
- (void)circleView:(HZCircleView *)view type:(HZCircleViewType)type didCompleteSetSecondGesture:(NSString *)gesture result:(BOOL)equal;

#pragma mark - 登录手势密码代理方法
/**
 *  登陆或者验证手势密码输入完成时的代理方法
 *
 *  @param view    circleView
 *  @param type    type
 *  @param gesture 登陆时的手势密码
 */
- (void)circleView:(HZCircleView *)view type:(HZCircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal;

@end

@interface HZCircleView : UIView

/**
 *  是否剪裁 default is YES
 */
@property (nonatomic, assign) BOOL clip;

/**
 *  是否有箭头 default is YES
 */
@property (nonatomic, assign) BOOL arrow;

/**
 *  解锁类型
 */
@property (nonatomic, assign) HZCircleViewType type;

// 代理
@property (nonatomic, weak) id<HZCircleViewDelegate> delegate;

// 初始化方法（设置view的相关类型、参数）
- (instancetype)initWithType:(HZCircleViewType)type clip:(BOOL)clip arrow:(BOOL)arrow;

@end
