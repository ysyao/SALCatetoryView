//
//  SALCategoryView.m
//  SALCatetoryView_Example
//
//  Created by 易诗尧 on 2021/10/8.
//  Copyright © 2021 jimmyandhurry@gmail.com. All rights reserved.
//

#import "SALCategoryView.h"
#import "SALTitleViewItem.h"


const static CGFloat titleViewHeight = 50;

@implementation SALCategoryView {
    CGFloat _width;
    CGFloat _height;
}


#pragma mark getter & setter

- (SALTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[SALTitleView alloc] initWithFrame:CGRectMake(self->_width * 0.2, 0, self->_width * 0.6, titleViewHeight)];
        
    }
    
    return _titleView;
}

- (SALScrollView *)scrollView {
    if (!_scrollView) {
        CGFloat h = self->_height - titleViewHeight;
        _scrollView = [[SALScrollView alloc] initWithFrame:CGRectMake(0, titleViewHeight + 1, self->_width, h)];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setAlwaysBounceVertical:NO];
        [_scrollView setAlwaysBounceHorizontal:NO];
        [_scrollView setPagingEnabled:YES]; // 滑到一半自动收缩
        _scrollView.delegate = self.titleView;
    }
    return _scrollView;
}

#pragma mark initialize
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViewWithFrame:frame];
    }
    return self;
}

- (void)initViewWithFrame:(CGRect)frame {
    self->_width = frame.size.width;
    self->_height = frame.size.height;
    
    [self addSubview:self.titleView];
    [self addSubview:self.scrollView];
    
    __weak typeof(self) weakSelf = self;
    [self.titleView setItemSelectedBlock:^(CGFloat offsetX, NSInteger index) {
        [weakSelf.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width * index, 0)];
//        [weakSelf.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }];
}

- (void)addCategory:(NSString *)category withViewController:(UIViewController *)viewController color:(UIColor *)color {
    
    // 标题
    [self.titleView addItemWithTitle:category color:color];
    
    //内容
    [self.scrollView addCategory:viewController];
     
}
@end
