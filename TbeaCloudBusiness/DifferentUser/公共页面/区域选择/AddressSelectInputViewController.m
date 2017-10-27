//
//  AddressSelectInputViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/4.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "AddressSelectInputViewController.h"

@interface AddressSelectInputViewController ()

@end

@implementation AddressSelectInputViewController

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
    
    
    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
    buttonright.titleLabel.font = FONTN(14.0f);
    buttonright.tag = 900;
    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonright setTitle:@"保存" forState:UIControlStateNormal];
    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    [buttonright addTarget:self action: @selector(clickdone:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局

-(void)initview
{
    self.title = @"地址选择";
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



#pragma mark otherdelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == EnTimeSelectTextfieldtag1)
    {
        [self clickselectcity];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark 地址选择代理 
//地址选择
- (void)clickselectcity{
    FDCityPicker *city = [[FDCityPicker alloc] initWithDelegate:self];
    [city show];
}

- (void)pickerAreaer:(FDCityPicker *)pickerAreaer province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    FCprovice = province;
    FCcity = city;
    FCarea = area;
    NSString *text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    UITextField *textfield = [tableview viewWithTag:EnTimeSelectTextfieldtag1];
    textfield.text = text;
}

#pragma mark IBaction
-(void)clickdone:(id)sender
{
    UITextField *textfield1 = [self.view viewWithTag:EnTimeSelectTextfieldtag1];
    UITextField *textfield2 = [self.view viewWithTag:EnTimeSelectTextfieldtag2];
    if(([textfield1.text length]==0)||([textfield2.text length]==0))
    {
        [MBProgressHUD showError:@"请填写地址" toView:app.window];
    }
    else
    {
        if([self.delegate1 respondsToSelector:@selector(DGSelectAreaAddress:City:Area:Address:)])
        {
            UITextField *textfield2 = [self.view viewWithTag:EnTimeSelectTextfieldtag2];
            [self.delegate1 DGSelectAreaAddress:FCprovice City:FCcity Area:FCarea Address:textfield2.text];
        }
        [self returnback];
    }
}

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
        cell.accessoryType = UITableViewCellAccessoryNone;
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
    
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, SCREEN_WIDTH-120, 30)];
    textfield.backgroundColor = [UIColor clearColor];
    textfield.font = FONTN(14.0f);
    textfield.textColor = [UIColor blackColor];
    textfield.delegate = self;
    
    switch (indexPath.row)
    {
        case 0:
            labelname.text = @"省市区";
            labelname.font = FONTN(15.0f);
            labelname.textColor = [UIColor blackColor];
            [cell.contentView addSubview:labelname];
            
            textfield.placeholder = @"点击选择省市区";
            textfield.tag = EnTimeSelectTextfieldtag1;
            if([FCprovice length]>0)
                textfield.text = [NSString stringWithFormat:@"%@%@%@",FCprovice,FCcity,FCarea];
            [cell.contentView addSubview:textfield];
            break;
        case 1:
            labelname.text = @"详细地址";
            labelname.font = FONTN(15.0f);
            labelname.textColor = [UIColor blackColor];
            [cell.contentView addSubview:labelname];
            
            textfield.placeholder = @"请填写详细地址";
            if([FCspecificaddress length]>0)
                textfield.text = FCspecificaddress;
            textfield.tag = EnTimeSelectTextfieldtag2;
            [cell.contentView addSubview:textfield];
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
