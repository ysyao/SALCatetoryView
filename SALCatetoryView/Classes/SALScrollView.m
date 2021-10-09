//
//  SALScrollView.m
//  SALCatetoryView_Example
//
//  Created by 易诗尧 on 2021/10/8.
//  Copyright © 2021 jimmyandhurry@gmail.com. All rights reserved.
//

#import "SALScrollView.h"

@implementation SALScrollView {
    int categoryCount;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self->categoryCount = 0;
    }
    return self;
}

- (void)addCategory:(UIViewController *)viewController {
    CGFloat x = (self->categoryCount * self.bounds.size.width);
    CGRect rect = CGRectMake(x, 0, self.bounds.size.width, self.bounds.size.height);
    viewController.view.frame = rect;
    [self addSubview:viewController.view];
    
    self->categoryCount += 1;

    self.contentSize = CGSizeMake(x * self->categoryCount, self.bounds.size.height);
    [self layoutIfNeeded];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

@end
