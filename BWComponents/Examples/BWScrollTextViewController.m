//
//  BWScrollTextViewController.m
//  BWComponents
//
//  Created by bairdweng on 2021/3/5.
//

#import "BWScrollTextViewController.h"
#import "DYScrollTextLabel.h"
#import <Masonry.h>

@interface BWScrollTextViewController ()

@property(nonatomic, strong)DYScrollTextLabel *textLabel;

@end

@implementation BWScrollTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.textLabel];
    self.textLabel.texts = @[
        [[NSAttributedString alloc]initWithString:@"测试1"],
        [[NSAttributedString alloc]initWithString:@"测试2"],
        [[NSAttributedString alloc]initWithString:@"测试3"],
        [[NSAttributedString alloc]initWithString:@"测试4"]
    ];
    [self.textLabel start];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@100);
        make.center.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}


- (DYScrollTextLabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [DYScrollTextLabel new];
    }
    return _textLabel;
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
