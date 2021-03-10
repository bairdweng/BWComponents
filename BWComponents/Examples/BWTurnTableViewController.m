//
//  BWTurnTableViewController.m
//  BWComponents
//
//  Created by bairdweng on 2021/3/6.
//

#import "BWTurnTableViewController.h"
#import <Masonry.h>
#import "BWBaseAnimation.h"
@interface BWTurnTableViewController ()
@property(nonatomic, strong)UIView *testView;
@end

@implementation BWTurnTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.testView = [[UIView alloc]init];
    [self.view addSubview:self.testView];
    self.testView.backgroundColor = [UIColor purpleColor];
    [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.center.equalTo(self.view);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickOntheTap)];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

- (void)clickOntheTap {
    [BWBaseAnimation shake:self.testView];
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
