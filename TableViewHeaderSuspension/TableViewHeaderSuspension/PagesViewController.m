//
//  PagesViewController.m
//  TableViewHeaderSuspension
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018 healifeGroup. All rights reserved.
//

#import "PagesViewController.h"

#import "PageSegmentedView.h"

#import "IntrolViewController.h"
#import "TalkViewController.h"
#import "RelationVideosViewController.h"

@interface PagesViewController ()


@property (nonatomic,strong) PageSegmentedView *segmentedView;


@end

@implementation PagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Page";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    
    IntrolViewController *intro = [IntrolViewController new];
    
    TalkViewController *talk = [TalkViewController new];
    
    RelationVideosViewController *relation = [RelationVideosViewController new];
    
    PageSegmentedView *segmentedView = [[PageSegmentedView alloc] initWithFrame:CGRectMake(0, 300, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 300 - 34) titles:@[@"互动",@"介绍",@"相关视频"] viewControllers:@[talk,intro,relation] targetVC:self];
    segmentedView.backgroundColor = [UIColor darkGrayColor];
    self.segmentedView = segmentedView;
    
    [self.view addSubview:segmentedView];
    
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
