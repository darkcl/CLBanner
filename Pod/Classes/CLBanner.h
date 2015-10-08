//
//  CLBanner.h
//  Pods
//
//  Created by Yeung Yiu Hung on 8/10/15.
//
//

#import <Foundation/Foundation.h>

typedef void(^CLBannerCompletionBlock)(void);
typedef void(^CLBannerTapBlock)(void);

@protocol CLBannerDelegate <NSObject>

@required
- (void)bannerWillShowWithInfo:(NSDictionary *)info;

@end

@interface CLBanner : NSObject

+ (CLBanner *)sharedBanner;

+ (UIViewController *)defaultViewController;

+ (void)setDefaultViewController:(UIViewController *)viewController;

+ (void)showBannerWithViewClass:(Class)viewClass
                       userInfo:(NSDictionary *)userInfo
                       duration:(float)duration
                       autoHide:(BOOL)autoHide
                   hideDuration:(float)hideDuration
                   bannerHeight:(CGFloat)height
                            tap:(CLBannerTapBlock)tapBlock
                     completion:(CLBannerCompletionBlock)completionBlock;

+ (void)hideBanner;
@end
