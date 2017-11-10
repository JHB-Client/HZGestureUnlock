//
//  HZLockLabel.h
//  HZGestureUnlockExample
//
//  Created by 季怀斌 on 2017/11/10.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZLockLabel : UILabel
/*
 *  普通提示信息
 */
- (void)showNormalMsg:(NSString *)msg;
/*
 *  警示信息
 */
- (void)showWarnMsg:(NSString *)msg;

/*
 *  警示信息(shake)
 */
- (void)showWarnMsgAndShake:(NSString *)msg;
@end
