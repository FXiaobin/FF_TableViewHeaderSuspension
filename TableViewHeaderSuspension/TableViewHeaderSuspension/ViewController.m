//
//  ViewController.m
//  TableViewHeaderSuspension
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018 healifeGroup. All rights reserved.
//

#import "ViewController.h"
#import "PagesViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *tableView;


@property (nonatomic,strong) UIView *suspensionHeader;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.suspensionHeader];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = @"fsfsdfsfa";
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *hIdentifier = @"hIdentifier";
    
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:hIdentifier];
    if(header == nil) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:hIdentifier];
        header.contentView.backgroundColor = [UIColor orangeColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,50)];
        label.text = [NSString stringWithFormat:@"  header - %ld",section];
        header.tag = 1000 + section;
        
        [header addSubview:label];
    }
    
    if (section == 2) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollToSection:)];
        header.userInteractionEnabled = YES;
        [header addGestureRecognizer:tap];
    }
   
    return header;
}

-(void)scrollToSection:(UITapGestureRecognizer *)sender{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PagesViewController *vc = [PagesViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    static NSString *fIdentifier = @"fIdentifier";
    
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:fIdentifier];
    if(footer == nil) {
        footer = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:fIdentifier];
        footer.contentView.backgroundColor = [UIColor grayColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,50)];
        label.text = [NSString stringWithFormat:@"  footer - %ld",section];
        footer.tag = 1000 + section;
        
        [footer addSubview:label];
    }
    
    return footer;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.tableView) {
        ///这个方法获取Header footer 需要用系统的方法从队列获取
        UITableViewHeaderFooterView *header = [self.tableView headerViewForSection:2];
        if (header) {
            //UIWindow *window = [UIApplication sharedApplication].keyWindow;
            CGRect frame = [self.tableView convertRect:header.frame toView:self.view];
            //NSLog(@"--- frame = %@",NSStringFromCGRect(frame));
            
            if (frame.origin.y <= 88.0) {
                self.suspensionHeader.hidden = NO;
            }else{
                self.suspensionHeader.hidden = YES;
            }
        }
        
        
    }
}

-(UIView *)suspensionHeader{
    if (_suspensionHeader == nil) {
        _suspensionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 88.0, self.view.bounds.size.width, 50)];
        _suspensionHeader.hidden = YES;
        _suspensionHeader.backgroundColor = [UIColor redColor];
    }
    return _suspensionHeader;
}

@end
