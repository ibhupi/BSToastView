//
//  BSToastView.h
//  docchi
//
//  Created by Bhupendra Singh on 1/13/15.
//  Copyright (c) 2015 Bhupendra. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BSToastViewTappedBlock)(void);

@interface BSToastView : UIView

@property (strong, nonatomic) IBOutlet UILabel *label;


+ (BSToastView *)toastWithMessage:(NSString *)message;
- (void)showFromView:(UIView *)fromView padding:(CGFloat)padding;
- (void)showFromView:(UIView *)fromView padding:(CGFloat)padding tappedBlock:(BSToastViewTappedBlock)tappedBlock;

- (void)hide:(BOOL)animated;

@end
