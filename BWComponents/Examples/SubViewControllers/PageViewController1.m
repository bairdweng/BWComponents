//
//  PageViewController1.m
//  BWComponents
//
//  Created by bairdweng on 2021/3/8.
//

#import "PageViewController1.h"
#import <Masonry.h>
#import "BWPageView.h"
@interface PageViewController1 ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation PageViewController1

- (UIScrollView *)subScrollView {
    
    return self.tableView;
}

- (void)mainHeaderHeight:(CGFloat)height {
    UIView *tableViewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    self.tableView.tableHeaderView = tableViewHeader;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid1"];
    }
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid1" forIndexPath:indexPath];
    cell.textLabel.text = @"hello1";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)dealloc {
    NSLog(@"PageViewController1释放啦");
}
@end
