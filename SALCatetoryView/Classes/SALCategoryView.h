//
//  SALCategoryView.h
//  SALCatetoryView_Example
//
//  Created by 易诗尧 on 2021/10/8.
//  Copyright © 2021 jimmyandhurry@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SALTitleView.h"
#import "SALScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SALCategoryView : UIView

- (void)addCategory:(NSString *)category withViewController:(UIViewController *)viewController color:(UIColor *)color;

@property(nonatomic, strong) SALTitleView *titleView;

@property(nonatomic, strong) SALScrollView *scrollView;
@end

NS_ASSUME_NONNULL_END
