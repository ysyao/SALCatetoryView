//
//  SALTitleView.h
//  SALCatetoryView_Example
//
//  Created by 易诗尧 on 2021/10/8.
//  Copyright © 2021 jimmyandhurry@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^itemSelected)(CGFloat offsetX, NSInteger index);

@interface SALTitleView : UIView<UIScrollViewDelegate>

@property(nonatomic, copy)itemSelected itemSelectedBlock;

@property(nonatomic, assign)int currentItemIndex;

- (int)titleCount;

- (void)addItemWithTitle:(NSString *)title color:(UIColor *)color;

- (void)setSelectedItemByIndex:(int)index;

@end

NS_ASSUME_NONNULL_END
