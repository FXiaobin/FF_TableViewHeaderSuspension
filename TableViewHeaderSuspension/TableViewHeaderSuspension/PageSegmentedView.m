//
//  PageSegmentedView.m
//  TableViewHeaderSuspension
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018 healifeGroup. All rights reserved.
//

#import "PageSegmentedView.h"

#define kSegmentedMenuHeight    50.0

@interface PageSegmentedView ()<UIScrollViewDelegate>


@property (nonatomic,strong) UIView *menuView;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) UIButton *selectedBtn;

///push用的
@property (nonatomic,weak) UIViewController *targetVC;


@end

@implementation PageSegmentedView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles viewControllers:(NSArray *)viewControllers targetVC:(UIViewController *)targetVC{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.targetVC = targetVC;
        [self setupUIWithTitles:titles viewControllers:viewControllers];
    }
    
    return self;
}

///当控制器中重设了PageSegmentedView的frame 那么就要调用这个方法来更新子视图的坐标
-(void)updatePageSegmentedViewFrame:(CGRect)frame{
    
    self.frame = frame;
    self.menuView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), kSegmentedMenuHeight);
    self.scrollView.frame = CGRectMake(0, kSegmentedMenuHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - kSegmentedMenuHeight);
   
    //self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * 3, 0);
    
    for (UIView *subView in self.scrollView.subviews) {
        UIResponder *res = [subView nextResponder];
        if ([res isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)res;
            vc.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        }
        
    }
}

-(void)setupUIWithTitles:(NSArray *)titles viewControllers:(NSArray *)viewControllers{
    if (titles.count == 0 || viewControllers.count == 0) {
        return;
    }
    
    /// 1.顶部选择按钮
    
    [self addSubview:self.menuView];
    
    [self addSubview:self.scrollView];
    
    CGFloat w = CGRectGetWidth(self.frame) / titles.count, h = kSegmentedMenuHeight;
    for (int i = 0; i < titles.count; i++) {
        
        UIButton *aButton = [[UIButton alloc] initWithFrame:CGRectMake(w * i, 0, w, h)];
        [aButton setTitle:titles[i] forState:UIControlStateNormal];
        aButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [aButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [aButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [aButton addTarget:self action:@selector(segmentedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        aButton.tag = 10000 + i;
        
        if (i == 0) {
            aButton.selected = YES;
            aButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
            self.line.frame = CGRectMake(CGRectGetMidX(aButton.frame) - 15, h - 3, 30, 2);
            self.selectedBtn = aButton;
        }
        
        [self.menuView addSubview:aButton];
    }
    
    [self.menuView addSubview:self.line];
    
    
    ///2. 控制器
    for (int i = 0; i < viewControllers.count; i++) {
        
        UIViewController *vc = viewControllers[i];
        vc.view.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame) * i, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        
        [self.targetVC addChildViewController:vc];
        [self.scrollView addSubview:vc.view];
    }
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * titles.count, 0.0);

}

- (void)segmentedBtnAction:(UIButton *)sender{
    self.selectedBtn.selected = NO;
    self.selectedBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    sender.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    sender.selected = YES;
    self.selectedBtn = sender;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.line.frame = CGRectMake(CGRectGetMidX(sender.frame) - 12, kSegmentedMenuHeight - 3, 24, 2);
    }];
    
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame) * (sender.tag - 10000), 0) animated:YES];
  
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / CGRectGetWidth(self.frame);
    UIButton *sender = (UIButton *)[self viewWithTag:10000 + index];
    self.selectedBtn.selected = NO;
    self.selectedBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    sender.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    sender.selected = YES;
    self.selectedBtn = sender;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.line.frame = CGRectMake(CGRectGetMidX(sender.frame) - 12, kSegmentedMenuHeight - 3, 24, 2);
    }];
   
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kSegmentedMenuHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - kSegmentedMenuHeight)];
        _scrollView.backgroundColor = [UIColor orangeColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

-(UIView *)line{
    if (_line == nil) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor orangeColor];
        _line.clipsToBounds = YES;
        _line.layer.cornerRadius = 1.0;
    }
    return _line;
}

-(UIView *)menuView{
    if (_menuView == nil) {
        _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), kSegmentedMenuHeight)];
        _menuView.backgroundColor = [UIColor whiteColor];
    }
    return _menuView;
}

@end
