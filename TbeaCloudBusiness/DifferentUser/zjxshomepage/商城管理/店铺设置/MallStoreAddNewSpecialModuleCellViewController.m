//
//  MallStoreAddNewSpecialModuleCellViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/9/3.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MallStoreAddNewSpecialModuleCellViewController.h"

@interface MallStoreAddNewSpecialModuleCellViewController ()

@end

@implementation MallStoreAddNewSpecialModuleCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    [button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局

-(void)initview
{
    self.title = @"添加规格型号";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}


#pragma mark actiondelegate
-(void)DGSaveSpecifiModulename:(NSString *)strname SetFlag:(NSString *)setflag
{
    if([setflag isEqualToString:@"添加规格"])
    {
        FCspecialname = strname;
    }
    else
        FCmodulename = strname;
    
    [tableview reloadData];
}


#pragma mark otherdelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}





#pragma mark IBaction
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tableview delegate
//隐藏那些没有cell的线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

-(void)viewDidLayoutSubviews
{
    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *reuseIdetify = @"cell";
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    
    
    textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, SCREEN_WIDTH-120, 30)];
    textfield.backgroundColor = [UIColor clearColor];
    textfield.font = FONTN(14.0f);
    textfield.textColor = [UIColor blackColor];
    textfield.delegate = self;
    textfield.enabled = NO;
    switch (indexPath.row)
    {
        case 0:
            labelname.text = @"规格";
            labelname.font = FONTN(15.0f);
            labelname.textColor = [UIColor blackColor];
            [cell.contentView addSubview:labelname];
            
            textfield.text = FCspecialname;
            [cell.contentView addSubview:textfield];
            break;
        case 1:
            labelname.text = @"型号";
            labelname.font = FONTN(15.0f);
            labelname.textColor = [UIColor blackColor];
            [cell.contentView addSubview:labelname];
            

            textfield.text = FCmodulename;
            [cell.contentView addSubview:textfield];
            break;
            
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        MallStoreSpecialModuleListViewController *mall = [[MallStoreSpecialModuleListViewController alloc] init];
        mall.FCtitle = @"规格列表";
        mall.delegate1 = self;
        [self.navigationController pushViewController:mall animated:YES];
        
//        MallStoreAddNewSpecialModuleViewController *mall = [[MallStoreAddNewSpecialModuleViewController alloc] init];
//        mall.FCtitle = @"添加规格";
//        mall.delegate1 = self;
//        [self.navigationController pushViewController:mall animated:YES];
    }
    else
    {
        MallStoreSpecialModuleListViewController *mall = [[MallStoreSpecialModuleListViewController alloc] init];
        mall.FCtitle = @"型号列表";
        mall.delegate1 = self;
        [self.navigationController pushViewController:mall animated:YES];
        
//        MallStoreAddNewSpecialModuleViewController *mall = [[MallStoreAddNewSpecialModuleViewController alloc] init];
//        mall.FCtitle = @"添加型号";
//        mall.delegate1 = self;
//        [self.navigationController pushViewController:mall animated:YES];
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
