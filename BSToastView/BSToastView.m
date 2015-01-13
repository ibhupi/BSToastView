//
//  BSToastView.m
//  docchi
//
//  Created by Bhupendra Singh on 1/13/15.
//  Copyright (c) 2015 Bhupendra. All rights reserved.
//

#import "BSToastView.h"

@interface BSToastView ()

@property (nonatomic, copy) BSToastViewTappedBlock tappedBlock;

@end

@implementation BSToastView

+ (BSToastView *)toastWithMessage:(NSString *)message
{
    BSToastView *toastView = [[[NSBundle mainBundle] loadNibNamed:@"BSToastView" owner:self options:nil] objectAtIndex:0];
    toastView.layer.cornerRadius = 4;
    
    toastView.label.text = message;
    
    return toastView;
}

- (void)showFromView:(UIView *)fromView padding:(CGFloat)padding
{
    self.alpha = 0;
    CGPoint horizontalCenterPoint;
    if (fromView)
    {
        [fromView addSubview:self];
        horizontalCenterPoint = fromView.center;
        horizontalCenterPoint.y = CGRectGetMaxY(fromView.frame) - CGRectGetHeight(self.frame) - padding;
    }
    else
    {
        UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
        [mainWindow addSubview:self];
        horizontalCenterPoint = mainWindow.center;
        horizontalCenterPoint.y = CGRectGetMaxY(mainWindow.frame) - CGRectGetHeight(self.frame) - padding;
    }
    self.center = horizontalCenterPoint;

    [UIView animateWithDuration:0.8 animations:^{
        self.alpha = 1;
    }completion:^(BOOL finished) {
        if (finished)
        {
            [self performSelector:@selector(_hideAnimated) withObject:nil afterDelay:3];
        }
    }];
}

- (void)showFromView:(UIView *)fromView padding:(CGFloat)padding tappedBlock:(BSToastViewTappedBlock)tappedBlock
{
    if (tappedBlock)
    {
        self.tappedBlock = tappedBlock;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tappedOnToast)];
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    [self showFromView:fromView padding:padding];
}

- (void)_hideAnimated
{
    [self hide:YES];
}

- (void)hide:(BOOL)animated
{
    if (animated)
    {
        [UIView animateWithDuration:0.8 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            self.tappedBlock = nil;
        }];
    }
    else
    {
        self.alpha = 0;
        [self removeFromSuperview];
        self.tappedBlock = nil;
    }
}

- (void)_tappedOnToast
{
    if (self.tappedBlock)
    {
        self.tappedBlock();
    }
    [self _hideAnimated];
}

@end
