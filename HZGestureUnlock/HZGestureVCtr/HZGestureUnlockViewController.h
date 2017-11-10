//
//  HZGestureUnlockViewController.h
//  HZGestureUnlockExample
//
//  Created by 季怀斌 on 2017/11/10.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    HZGestureUnlockViewControllerTypeSetting = 1,
    HZGestureUnlockViewControllerTypeLogin
}HZGestureUnlockViewControllerType;

typedef enum{
    buttonTagReset = 1,
    buttonTagManager,
    buttonTagForget
    
}buttonTag;

@interface HZGestureUnlockViewController : UIViewController

/**
 *  控制器来源类型
 */
@property (nonatomic, assign) HZGestureUnlockViewControllerType type;

@end
