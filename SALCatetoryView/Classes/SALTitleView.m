//
//  SALTitleView.m
//  SALCatetoryView_Example
//
//  Created by 易诗尧 on 2021/10/8.
//  Copyright © 2021 jimmyandhurry@gmail.com. All rights reserved.
//

#import "SALTitleView.h"
#import "SALTitleViewItem.h"


static const CGFloat bottomLineWidth = 30;
static const CGFloat bottomLineHeight = 3;

@implementation SALTitleView {
    CAGradientLayer *_boLinLayer;
    NSMutableArray<NSString *> *titles;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self->titles = [[NSMutableArray alloc] init];
    }
    return self;
}

- (int)titleCount {
    return (int)self->titles.count;
}

- (void)addItemWithTitle:(NSString *)title color:(UIColor *)color {
    CGFloat width = self.bounds.size.width / (self.titleCount + 1);
    
    [self->titles addObject:title];
    
    for (int i = 0; i < self->titles.count; i++) {
        CGFloat originX = i * width;
        CGRect rect = CGRectMake(originX, 0, width, self.bounds.size.height);
        SALTitleViewItem *item;
        if (self.subviews.count == i) {
            item = [[SALTitleViewItem alloc] initWithTitle:title andFrame:rect color:color];
            item.index = i;
            [self addSubview: item];
        } else {
            item = (SALTitleViewItem *)self.subviews[i];
            item.frame = rect;
        }
        // 将第一页设置成为默认选中页
        item.itemSelected = (i == 0);
    }
    
    self.currentItemIndex = 0;
}


- (void)setCurrentItemIndex:(int)currentItemIndex {
    _currentItemIndex = currentItemIndex;
    
    // 根据选中的tag来设置bottom line的位置
    CGRect rect = self.frame;
    CGFloat bottomLineX = rect.size.width / self.titleCount / 2 * (_currentItemIndex * 2 + 1);
    
    self->_boLinLayer.bounds = CGRectMake(0, 0, bottomLineWidth, bottomLineHeight);
    self->_boLinLayer.anchorPoint = CGPointMake(0.5, 0);
    self->_boLinLayer.position = CGPointMake(bottomLineX, rect.size.height - bottomLineHeight);
    
    // 设置bottom line的颜色
    SALTitleViewItem *item = (SALTitleViewItem *)self.subviews[currentItemIndex];
    self->_boLinLayer.colors = @[(__bridge id)item.color.CGColor];
    self->_boLinLayer.backgroundColor = item.color.CGColor;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // 画底线
    [self drawBottomLineWithRect:rect];
}

- (void)drawBottomLineWithRect:(CGRect)rect {
    self->_boLinLayer = [CAGradientLayer layer];
    self->_boLinLayer.cornerRadius = 3;
    self->_boLinLayer.masksToBounds = YES;
    SALTitleViewItem *item = (SALTitleViewItem *)self.subviews[0];
    self->_boLinLayer.backgroundColor = item.color.CGColor;
    [self.layer addSublayer:self->_boLinLayer];
    self->_boLinLayer.bounds = CGRectMake(0, 0, bottomLineWidth, bottomLineHeight);
    self->_boLinLayer.anchorPoint = CGPointMake(0.5, 0);
    self->_boLinLayer.position = CGPointMake(rect.size.width / self.titleCount / 2, rect.size.height - bottomLineHeight);
    self->_boLinLayer.contentsScale = [[UIScreen mainScreen] scale];
    
}


/// 通过这个方法来设置下划线动画（其实这里应该可以加入分类数量的变量作为计算位置的输入）
/// @param point 点击点
/// @param event 点击事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    for (UIView *subview in self.subviews) {
        // 这里很重要，将当前view的point转换成为subview的坐标体系下的point，才能够进一步去掉用subivew的hitTest方法。
        CGPoint childP = [self convertPoint:point toView:subview];
        UIView *fitView = [subview hitTest:childP withEvent:event];
        
        SALTitleViewItem *item = (SALTitleViewItem *)subview;
        
        // 不为空的情况，设置subview item的各种参数
        if (fitView) {
            item.itemSelected = YES;
            self.currentItemIndex = item.index;
            [item setNeedsDisplay];
            
            if (self.itemSelectedBlock) {
                self.itemSelectedBlock(self.bounds.size.width * self.currentItemIndex, self.currentItemIndex);
            }
            
            return item;
        } else {
            item.itemSelected = NO;
            [item setNeedsDisplay];
        }
        
    }
   
    return self;
}

- (void)setSelectedItemByIndex:(int)index {
    for (UIView *subview in self.subviews) {
        SALTitleViewItem *item = (SALTitleViewItem *)subview;
        if (item.index == index) {
            item.itemSelected = YES;
            self.currentItemIndex = index;
        } else {
            item.itemSelected = NO;
        }
        
        [item setNeedsDisplay];
    }
}

# pragma mark delegator
// 滑动结束会调用这个方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (page != self.currentItemIndex) {
        [self setSelectedItemByIndex:page];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x - self.currentItemIndex * scrollView.bounds.size.width;
    CGPoint anchorPoint;
    CGPoint position;
    CGFloat itemWidth = self.bounds.size.width / self.titleCount;
    CGFloat lineWidth = bottomLineWidth;
    CGFloat lineHeight = bottomLineHeight;
    CGFloat bottomLineLayerWidth;
    int nextPageIndex;
    int currentIndex = self.currentItemIndex;
    CGPoint startPoint;
    CGPoint endPoint;
    
    // 为偏移量设定一个响应的范围
    if (offsetX >= -1 && offsetX <= 1) {
        [self setSelectedItemByIndex:currentIndex];
        return;
    }
    
    // 向左滑动
    if (offsetX > 0) {
        // 设置颜色
        nextPageIndex = currentIndex + 1;
        startPoint = CGPointMake(0, 0.5);
        endPoint = CGPointMake(1.0, 0.5);
        
        // 设置宽高
        anchorPoint = CGPointMake(0, 0);
        CGFloat x = (itemWidth - lineWidth) / 2 + currentIndex * itemWidth;
        position = CGPointMake(x, self.frame.size.height - lineHeight);
        CGFloat road = itemWidth + lineWidth / 2;
        bottomLineLayerWidth = road * offsetX / scrollView.bounds.size.width;
    } else {
        // 向右滑动
        
        // 设置颜色
        nextPageIndex = currentIndex - 1;
        startPoint = CGPointMake(1.0, 0.5);
        endPoint = CGPointMake(0, 0.5);
        
        // 设置宽高
        anchorPoint = CGPointMake(1, 0);
        CGFloat x = (itemWidth - lineWidth) / 2 + currentIndex * itemWidth;
        position = CGPointMake(x + lineWidth, self.frame.size.height - lineHeight);
        CGFloat road = itemWidth + lineWidth / 2;
        bottomLineLayerWidth = - road * offsetX / scrollView.bounds.size.width;
    }
    
    if (nextPageIndex >= 0 && nextPageIndex < self.subviews.count) {
        UIColor *currentIndexColor = ((SALTitleViewItem *)self.subviews[currentIndex]).color;
        UIColor *nextIndexColor = ((SALTitleViewItem *)self.subviews[nextPageIndex]).color;
        
        self->_boLinLayer.colors = @[(__bridge id)currentIndexColor.CGColor, (__bridge id)nextIndexColor.CGColor];
        self->_boLinLayer.locations = @[@0.0, @1.0];
        self->_boLinLayer.startPoint = startPoint;
        self->_boLinLayer.endPoint = endPoint;
        self->_boLinLayer.anchorPoint = anchorPoint;
        self->_boLinLayer.position = position;
        self->_boLinLayer.bounds = CGRectMake(0, 0, bottomLineLayerWidth + lineWidth, lineHeight);
    }
    
    
}


@end
