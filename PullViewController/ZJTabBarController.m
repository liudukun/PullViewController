//
//  ZJTabBarViewController.m
//
//
//  Created by 汉子科技 on 15/7/31.
//
//

#import "ZJTabBarController.h"
#import "UIView+MJExtension.h"



@interface ZJTabBarController ()
{
    BOOL pulled;
    CGPoint op;
    CGPoint np;
    BOOL lock;
    CGFloat panEffectWidth;
    NSArray *tabbarItemModels;
    
}
@end

@implementation ZJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initPullStyle];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self initPullStyle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initPullStyle{
    if (self.pullCtroller) {
        return;
    }
    panEffectWidth = 60;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.pullCtroller = [ZJPullViewController new];
    [window addSubview:self.pullCtroller.view];
    UIPanGestureRecognizer *leftPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [window addGestureRecognizer:leftPan];
    lock = YES;
}

- (void)pan:(UIPanGestureRecognizer *)gestureRecognizer{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGPoint p = [gestureRecognizer locationInView:window];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        op = CGPointZero;
        np = p;
        if (np.x < panEffectWidth) {
            lock = NO;
        }
        if (pulled) {
            lock = NO;
        }
        
        NSLog(@"start%f,%f",op.x,np.x);
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        op = np;
        np = p;
        CGFloat off = np.x - op.x;
        NSLog(@"change%f,%f,%f,%f",op.x,np.x,off,self.pullCtroller.view.mj_x);
        //
        if (lock == NO && self.pullCtroller.view.mj_x + off >= -self.pullCtroller.view.mj_w && self.pullCtroller.view.mj_x + off <= 0) {
            self.view.mj_x += off;
            self.pullCtroller.view.mj_x += off;
        }
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        op = np;
        np = p;
        CGFloat off = np.x - op.x;
        NSLog(@"end %f,%f,%f",op.x,np.x,off);
        if (lock == NO && self.pullCtroller.view.mj_x + off >= -self.pullCtroller.view.mj_w && self.pullCtroller.view.mj_x + off <= 0) {
            self.view.mj_x += off;
            self.pullCtroller.view.mj_x += off;
        }
        // animation
        if (self.pullCtroller.view.mj_x < - self.pullCtroller.view.mj_w *0.3) {
            [UIView animateWithDuration:0.2 animations:^{
                self.view.mj_x = 0;
                self.pullCtroller.view.mj_x = -self.pullCtroller.view.mj_w;
            }completion:^(BOOL finished) {
                pulled = NO;
            }];
        }
        
        if (self.pullCtroller.view.mj_x > - self.pullCtroller.view.mj_w *0.7) {
            [UIView animateWithDuration:0.2 animations:^{
                self.view.mj_x = self.pullCtroller.view.mj_w;
                self.pullCtroller.view.mj_x = 0;
            }completion:^(BOOL finished) {
                pulled = YES;
            }];
        }
        
        //init
        lock = YES;
    }
    
}





@end
