//
//  ViewController.m
//  BWComponents
//
//  Created by bairdweng on 2021/3/5.
//

#import "ViewController.h"
#import "BWScrollTextViewController.h"
#import "BWTurnTableViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *dataSources;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSources = @[
        @{
            @"title":@"文字滚动",
            @"vc":@"BWScrollTextViewController"
         },
        @{
            @"title":@"转盘",
            @"vc":@"BWTurnTableViewController"
         },
        @{
            @"title":@"文字的处理",
            @"vc":@"BWTextViewController"
         },
        @{
            @"title":@"页面视图",
            @"vc":@"BWPageViewControllerDemo"
        }
    ];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell_id"];
    
    // Do any additional setup after loading the view.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *dic = self.dataSources[indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.dataSources[indexPath.row];
    UIViewController *vc = [[NSClassFromString([dic objectForKey:@"vc"]) alloc]init];;
    vc.title = [dic objectForKey:@"title"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSources count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
@end
