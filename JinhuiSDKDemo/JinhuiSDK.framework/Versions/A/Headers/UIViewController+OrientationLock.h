//
//  UIViewController+OrientationLock.h
//  TestOrientation
//
//  Created by mshqiu on 2019/9/19.
//  Copyright © 2019 mshqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (OrientationLock)

+ (UIInterfaceOrientationMask)orientationMask;

+ (void)setInitialInterfaceOrientation:(UIInterfaceOrientation)orientation;

- (void)lockToInterfaceOrientation:(UIInterfaceOrientation)orientation;

@end

NS_ASSUME_NONNULL_END
