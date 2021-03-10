//
//  BWTextViewController.m
//  BWComponents
//
//  Created by bairdweng on 2021/3/8.
//

#import "BWTextViewController.h"
#import <YYText/YYText.h>
#import <YYCategories/YYCategories.h>
#import <Masonry.h>
@interface BWTextViewController ()
@property(nonatomic, strong)YYLabel *testLabel;
@end

@implementation BWTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.testLabel];
    [self.testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@150);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.view);
    }];
    [self attTest];
    // Do any additional setup after loading the view from its nib.
}

- (YYLabel *)testLabel {
    if (!_testLabel) {
        _testLabel = [YYLabel new];
        _testLabel.numberOfLines = 0;
        _testLabel.backgroundColor = [UIColor redColor];
    }
    return _testLabel;
}

- (void)attTest {
    NSMutableAttributedString *atext = [[NSMutableAttributedString alloc] initWithString:@"江爷爷刚邀请了100位好友即将获得5000元"];
    // 设置字体大小
    [atext yy_setFont:[UIFont systemFontOfSize:20] range:atext.yy_rangeOfAll];
    self.testLabel.attributedText = atext;
    
    //局部不同颜色
    NSRange range0=[[atext string]rangeOfString:@"江爷爷"];
    [atext yy_setColor:[UIColor blueColor] range:range0];
    
    //设置行间距
    atext.yy_lineSpacing = 15;
    atext.yy_paragraphSpacing = 20;
    
    // 调整字间距
//    long number = 2;
//    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
//    [atext addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:atext.yy_rangeOfAll];
    
    //设置下划线
    NSRange range1=[[atext string]rangeOfString:@"100" ];
    YYTextDecoration* deco=[YYTextDecoration decorationWithStyle:(YYTextLineStyleSingle) width:[NSNumber numberWithInt:1] color:[UIColor redColor]];
    [atext yy_setTextUnderline:deco range:range1];
    
    //阴影
    NSRange range2=[[atext string]rangeOfString:@"5000"];
    NSShadow*  shadow=[[NSShadow alloc]init];
    [shadow setShadowColor:[UIColor redColor]];
    [shadow setShadowBlurRadius:1];
    [shadow setShadowOffset:CGSizeMake(2, 2)];
    [atext yy_setShadow:shadow range:range2];
    
    //文本内阴影
    NSRange range3=[[atext string]rangeOfString:@"刚邀请了"];
    YYTextShadow* dow=[YYTextShadow new];
    dow.color=[UIColor yellowColor];
    dow.offset=CGSizeMake(0, 2);
    dow.radius=1;
    [atext yy_setTextShadow:dow range:range3];
    self.testLabel.attributedText = atext;
    self.testLabel.textAlignment = NSTextAlignmentCenter;
}


- (void)setBaseConfig {
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Another Link"];
    //设置字号
    one.yy_font = [UIFont boldSystemFontOfSize:30];
    //设置字体颜色红色
    one.yy_color = [UIColor redColor];
    //字体边框
    YYTextBorder *border = [YYTextBorder new];
    //边框圆角
    border.cornerRadius = 50;
    //边框边距
    border.insets = UIEdgeInsetsMake(0, -10, 0, -10);
    //边框线宽
    border.strokeWidth = 0.5;
    //边框颜色等于字体颜色
    border.strokeColor = one.yy_color;
    border.lineStyle = YYTextLineStyleSingle;
    one.yy_textBackgroundBorder = border;
    
    //高亮边框
    YYTextBorder *highlightBorder = border.copy;
    highlightBorder.strokeWidth = 0;
    highlightBorder.strokeColor = one.yy_color;
    
    //填充颜色红色
    highlightBorder.fillColor = one.yy_color;
    
    //设置高亮颜色
    YYTextHighlight *highlight = [YYTextHighlight new];
    [highlight setColor:[UIColor whiteColor]];
    
    //高亮的背景框
    [highlight setBackgroundBorder:highlightBorder];
    
    //点击高亮回调
    highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        NSLog(@"高亮12");
    };
    [one yy_setTextHighlight:highlight range:one.yy_rangeOfAll];
    self.testLabel.attributedText = one;
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
