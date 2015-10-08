//
//  CLBanner.m
//  Pods
//
//  Created by Yeung Yiu Hung on 8/10/15.
//
//

#import "CLBanner.h"

@implementation CLBanner

static CLBanner *sharedBanner;
static UIViewController *bannerDefaultViewController;

static CLBannerTapBlock bannerTapBlock;
static CLBannerCompletionBlock bannerCompletionBlock;

static id bannerViewObj;
static float bannerShowDuration;
static float bannerHeight;
static bool isAutoHide;

+ (CLBanner *)sharedBanner{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBanner = [[self alloc] init];
    });
    return sharedBanner;
}

+ (UIViewController *)defaultViewController{
    if (!bannerDefaultViewController) {
        bannerDefaultViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    }
    return bannerDefaultViewController;
}

+ (void)setDefaultViewController:(UIViewController *)viewController{
    bannerDefaultViewController = viewController;
}

+ (void)showBannerWithViewClass:(Class)viewClass
                       userInfo:(NSDictionary *)userInfo
                       duration:(float)duration
                       autoHide:(BOOL)autoHide
                   hideDuration:(float)hideDuration
                   bannerHeight:(CGFloat)height
                            tap:(CLBannerTapBlock)tapBlock
                     completion:(CLBannerCompletionBlock)completionBlock{
    bannerTapBlock = tapBlock;
    bannerShowDuration = duration;
    bannerCompletionBlock = completionBlock;
    bannerViewObj = [[viewClass alloc] init];
    bannerHeight = height;
    isAutoHide = autoHide;
    //    NSAssert([viewObj isSubclassOfClass:[UIView class]], @"viewClass must be subclass of UIView");
    //    NSAssert([viewObj conformsToProtocol:@protocol(CLBannerDelegate)], @"viewClass must conforms protocol CLBannerDelegate");
    [bannerViewObj bannerWillShowWithInfo:userInfo];
    
    UIViewController *showInVC = [self defaultViewController];
    CGRect rect = CGRectMake(0, -height, showInVC.view.bounds.size.width, height);
    
    [bannerViewObj setFrame:rect];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:[CLBanner sharedBanner] action:@selector(didTapBanner:)];
    [bannerViewObj addGestureRecognizer:tapGesture];
    [showInVC.view addSubview:bannerViewObj];
    [UIView animateWithDuration:bannerShowDuration
                     animations:^{
                         CGRect aRect = [bannerViewObj frame];
                         
                         aRect.origin.y = 0;
                         
                         [bannerViewObj setFrame:aRect];
                         
                     } completion:^(BOOL finished) {
                         completionBlock();
                     }];
    if (isAutoHide) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(hideDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:bannerShowDuration
                             animations:^{
                                 CGRect aRect = [bannerViewObj frame];
                                 
                                 aRect.origin.y = -bannerHeight;
                                 
                                 [bannerViewObj setFrame:aRect];
                             }
                             completion:^(BOOL finished) {
                                 [bannerViewObj removeFromSuperview];
                             }];
        });
    }
}

+ (void)hideBanner{
    [UIView animateWithDuration:bannerShowDuration
                     animations:^{
                         CGRect aRect = [bannerViewObj frame];
                         
                         aRect.origin.y = -bannerHeight;
                         
                         [bannerViewObj setFrame:aRect];
                     }
                     completion:^(BOOL finished) {
                         [bannerViewObj removeFromSuperview];
                     }];
}

- (void)didTapBanner:(id)sender{
    bannerTapBlock();
}

@end
