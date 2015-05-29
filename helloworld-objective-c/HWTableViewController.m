//
//  HWTableViewController.m
//  helloworld-objective-c
//
//  Created by CHENHSIN-PANG on 2015/3/24.
//  Copyright (c) 2015年 CinnamonRoll. All rights reserved.
//

#import "HWTableViewController.h"
#import "CRFastImagePickerViewController.h"

@interface HWTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak)UITableView   *tableView;
@property(nonatomic, strong)NSArray     *items;

@end

@implementation HWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    tableView.dataSource = self; // 需要在上面宣告這個class有實作 UITableViewDataSource
    tableView.delegate = self;
    
    self.tableView = tableView; // 把local variable設給這個物件的property，是方便存取。
    
    self.items = @[@"image picker"];
}


// 當程式執行到這裡，self.view拿到的大小才正確
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds; // 可以查一下frame 與 bounds的差別
    

}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; // 有幾個Section
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 每個Section有幾個Row
    return self.items.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataCell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DataCell"];
    }
    
    
    NSString *item = [self.items objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];

    
    return cell;
}



#pragma mark - UITableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        CRFastImagePickerViewController *vc = [[CRFastImagePickerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}




@end
