//
//  SALViewController.m
//  SALCatetoryView
//
//  Created by jimmyandhurry@gmail.com on 10/08/2021.
//  Copyright (c) 2021 jimmyandhurry@gmail.com. All rights reserved.
//

#import "SALViewController.h"
#import "SALCategoryView.h"

@interface SALViewController ()

@property(nonatomic, strong) SALCategoryView *categoryView;

@end

@implementation SALViewController

- (SALCategoryView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[SALCategoryView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
    
    return _categoryView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:UIColor.whiteColor];
    
    [self.view addSubview:self.categoryView];
    
    UIViewController *leVc = [UIViewController new];
    leVc.view = [[UIView alloc] initWithFrame:CGRectZero];
    [leVc.view setBackgroundColor:UIColor.orangeColor];
    [self.categoryView addCategory:@"左边" withViewController:leVc color:UIColor.orangeColor];
    
    UIViewController *riVc = [UIViewController new];
    riVc.view = [[UIView alloc] initWithFrame:CGRectZero];
    [riVc.view setBackgroundColor:UIColor.redColor];
    [self.categoryView addCategory:@"右边" withViewController:riVc color:UIColor.redColor];
    
}



@end
