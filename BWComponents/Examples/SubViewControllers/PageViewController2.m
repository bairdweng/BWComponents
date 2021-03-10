//
//  PageViewController2.m
//  BWComponents
//
//  Created by bairdweng on 2021/3/8.
//

#import "PageViewController2.h"
#import <Masonry.h>

@interface PageViewController2 ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation PageViewController2


- (UIScrollView *)subScrollView {
    return self.tableView;
}

- (void)mainHeaderHeight:(CGFloat)height {
    UIView *tableViewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    self.tableView.tableHeaderView = tableViewHeader;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
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
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid2"];

    }
    return _tableView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid2" forIndexPath:indexPath];
    cell.textLabel.text = @"hello2";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}





- (void)dealloc {
    NSLog(@"PageViewController2释放啦");
}

@end
