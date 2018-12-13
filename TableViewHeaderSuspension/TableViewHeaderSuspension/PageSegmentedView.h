//
//  PageSegmentedView.h
//  TableViewHeaderSuspension
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageSegmentedView : UIView



-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles viewControllers:(NSArray *)viewControllers targetVC:(UIViewController *)targetVC;

///更新frame
-(void)updatePageSegmentedViewFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
