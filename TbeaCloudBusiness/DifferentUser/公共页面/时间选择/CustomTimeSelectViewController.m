//
//  CustomTimeSelectViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy on 2017/8/2.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "CustomTimeSelectViewController.h"

@interface CustomTimeSelectViewController ()

@end

@implementation CustomTimeSelectViewController

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
    self.title = @"时间选择";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, SCREEN_HEIGHT-64-80, SCREEN_WIDTH-40, 40);
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.titleLabel.font = FONTN(15.0f);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = COLORNOW(0, 170, 236);
    [button addTarget:self action:@selector(clickdone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
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
        enselecttime = EnStartTime;
        [self clickselecttime];
        return NO;
    }
    else if(textField.tag == EnTimeSelectTextfieldtag2)
    {
        enselecttime = EnEndTime;
        [self clickselecttime];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)clickselecttime{
    
    DateTimePickerView *pickerView = [[DateTimePickerView alloc] init];
    self.datePickerView = pickerView;
    pickerView.delegate = self;
    pickerView.pickerViewMode = DatePickerViewDateTimeMode;
    if(self.datemode==DatePickerViewDateMode)
        pickerView.pickerViewMode = DatePickerViewDateMode;
    [self.view addSubview:pickerView];
    [pickerView showDateTimePickerView];
}

#pragma mark - delegate

- (void)didClickFinishDateTimePickerView:(NSString *)date{
    if(enselecttime == EnStartTime)
    {
        UITextField *textfield = [tableview viewWithTag:EnTimeSelectTextfieldtag1];
        textfield.text = date;
    }
    else
    {
       UITextField *textfield = [tableview viewWithTag:EnTimeSelectTextfieldtag2];
        textfield.text = date;
    }
 
}


#pragma mark IBaction
-(void)clickdone:(id)sender
{
    UITextField *textfield1 = [self.view viewWithTag:EnTimeSelectTextfieldtag1];
    UITextField *textfield2 = [self.view viewWithTag:EnTimeSelectTextfieldtag2];
    if(([textfield1.text length]==0)||([textfield2.text length]==0))
    {
        [MBProgressHUD showError:@"请选择开始与结束时间" toView:app.window];
    }
    else
    {
        UITextField *textfield1 = [self.view viewWithTag:EnTimeSelectTextfieldtag1];
        UITextField *textfield2 = [self.view viewWithTag:EnTimeSelectTextfieldtag2];
        DLog(@"textfield====%@,%@",textfield1.text,textfield2);
        if([textfield1.text compare:textfield2.text] == NSOrderedAscending)
        {
            if([self.delegate1 respondsToSelector:@selector(DGSelectDateHourSecondDone:EndTime:)])
            {
                [self.delegate1 DGSelectDateHourSecondDone:textfield1.text EndTime:textfield2.text];
            }
            [self returnback];
        }
        else
            [MBProgressHUD showError:@"终止时间必须大于开始时间" toView:app.window];
        
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
            labelname.text = @"起始时间";
            labelname.font = FONTN(15.0f);
            labelname.textColor = [UIColor blackColor];
            [cell.contentView addSubview:labelname];
            
            textfield.placeholder = [AddInterface returnnowdatefromstr:@"yyyy-MM-dd hh:mm"];
            if(self.datemode==DatePickerViewDateMode)
                textfield.placeholder = [AddInterface returnnowdatefromstr:@"yyyy-MM-dd"];
            if([self.FCstarttime length]>0)
                textfield.text = self.FCstarttime;
            textfield.tag = EnTimeSelectTextfieldtag1;
            [cell.contentView addSubview:textfield];
            break;
        case 1:
            labelname.text = @"终止时间";
            labelname.font = FONTN(15.0f);
            labelname.textColor = [UIColor blackColor];
            [cell.contentView addSubview:labelname];
            
            textfield.placeholder = [AddInterface returnnowdatefromstr:@"yyyy-MM-dd hh:mm"];
            if(self.datemode==DatePickerViewDateMode)
                textfield.placeholder = [AddInterface returnnowdatefromstr:@"yyyy-MM-dd"];
            if([self.FCendtime length]>0)
                textfield.text = self.FCendtime;
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
