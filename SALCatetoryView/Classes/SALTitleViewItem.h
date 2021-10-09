//
//  SALTitleViewItem.h
//  SALCatetoryView_Example
//
//  Created by 易诗尧 on 2021/10/8.
//  Copyright © 2021 jimmyandhurry@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SALTitleViewItem : UIView


- (instancetype)initWithTitle:(NSString *)title andFrame:(CGRect)frame color:(UIColor *)color;

@property(nonatomic, assign)int index;

@property(nonatomic, copy)NSString *title;

@property(nonatomic, assign)BOOL itemSelected;

@property(nonatomic, strong)UIColor *color;


@end

NS_ASSUME_NONNULL_END
