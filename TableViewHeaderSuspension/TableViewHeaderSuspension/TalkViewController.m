//
//  TalkViewController.m
//  TableViewHeaderSuspension
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018 healifeGroup. All rights reserved.
//

#import "TalkViewController.h"

@interface TalkViewController ()

@end

@implementation TalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    
    UIButton *aButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 200,200, 40)];
    [aButton setTitle:@"click" forState:UIControlStateNormal];
    aButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [aButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [aButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [aButton addTarget:self action:@selector(abtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:aButton];
}

-(void)abtnAction:(UIButton *)sender{
    
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
    
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
