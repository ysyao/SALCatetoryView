//
//  SALTitleViewItem.m
//  SALCatetoryView_Example
//
//  Created by 易诗尧 on 2021/10/8.
//  Copyright © 2021 jimmyandhurry@gmail.com. All rights reserved.
//

#import "SALTitleViewItem.h"

@implementation SALTitleViewItem

- (void)drawRect:(CGRect)rect {
    
    [self drawTitleWithRect:rect];
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemSelected = (frame.origin.x == 0);
        [self initViewsWithFrame: frame];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title andFrame:(CGRect)frame color:(UIColor *)color {
    self = [self initWithFrame:frame];
    if (self) {
        self.title = title;
        self.color = color;
    }
    return self;
}


- (void)initViewsWithFrame:(CGRect)frame {
    
}

- (void)drawTitleWithRect:(CGRect)rect {
    
    CGSize size = CGSizeMake(MAXFLOAT, 30);
    NSDictionary *attributes = @{
        NSForegroundColorAttributeName: UIColor.blackColor,
        NSFontAttributeName: [UIFont systemFontOfSize:17]
    };
    // 计算当前属性下title的宽和高
    CGRect titleFrame = [self.title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes: attributes context:nil];
    
    CATextLayer *txtLayer = CATextLayer.layer;
    txtLayer.font = CFBridgingRetain([UIFont systemFontOfSize: 17]);
    txtLayer.fontSize = 17;
    if (!self.itemSelected) {
        txtLayer.foregroundColor = UIColor.blackColor.CGColor;
    } else {
        txtLayer.foregroundColor = self.color.CGColor;
    }
    txtLayer.alignmentMode = kCAAlignmentCenter;
    txtLayer.string = self.title;
    // 文字模糊，需要用下面代码重新计算
    txtLayer.contentsScale = [[UIScreen mainScreen] scale];
    txtLayer.anchorPoint = CGPointMake(0.5, 0.5);
    txtLayer.position = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    txtLayer.bounds = CGRectMake(0, 0, titleFrame.size.width, titleFrame.size.height);
    [self.layer addSublayer:txtLayer];
    
}


@end
