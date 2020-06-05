//
//  ViewController.m
//  OC-project-AddWithRomove
//
//  Created by 杨皓博 on 2020/6/4.
//  Copyright © 2020 Clinton. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *shopView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (nonatomic,strong)NSArray *dataArr;
@end

@implementation ViewController
/**
*  懒加载
   1.作用:
   1>用到的时候再加载
   2>全局只会被加载一次
   3>全局都可以使用

   过程:
   1.重写成员变量的get方法
   2.在get方法中判断:
     1>如果为空,加载数据
     2>如果不为空,就直接返回数据
*/
- (NSArray *)dataArr{
    if (_dataArr == nil) {
        // 加载数据
        self.dataArr = @[
                     @{@"name":@"单肩包", @"icon":@"danjianbao"},
                     @{@"name":@"钱包", @"icon":@"qianbao"},
                     @{@"name":@"链条包", @"icon":@"liantiaobao"},
                     @{@"name":@"手提包", @"icon":@"shoutibao"},
                     @{@"name":@"双肩包", @"icon":@"shuangjianbao"},
                     @{@"name":@"斜挎包", @"icon":@"xiekuabao"}
                     ];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)add:(UIButton *)sender {
    /***********************1.定义一些常量*****************************/
        // 1.总列数
        NSInteger allCols = 3;
        // 2.商品的宽度 和 高度
        CGFloat width = 80;
        CGFloat height = 100;
        // 3.求出水平间距 和 垂直间距
    CGFloat hMargin = (self.shopView.frame.size.width - allCols * width) / (allCols -1);
    CGFloat vMargin = (self.shopView.frame.size.height - 2 * height) / 1;
        // 4. 设置索引
    NSInteger index = self.shopView.subviews.count;
        // 5.求出x值
        CGFloat x = (hMargin + width) * (index % allCols);
        CGFloat y = (vMargin + height) * (index / allCols);
        
    /***********************2.创建一个商品*****************************/
      // 1.创建商品的view
        UIView *shopView = [[UIView alloc] init];
        
      // 2.设置frame
        shopView.frame = CGRectMake(x, y, width, height);
        
      // 3.设置背景颜色
        shopView.backgroundColor = [UIColor greenColor];
        
      // 4.添加到购物车
    [self.shopView addSubview:shopView];
        
      // 5.创建商品的UIImageView对象
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.frame = CGRectMake(0, 0, width, width);
        iconView.backgroundColor = [UIColor blueColor];
        [shopView addSubview:iconView];
        
      // 6.创建商品标题对象
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, width, width, height - width);
        titleLabel.backgroundColor = [UIColor yellowColor];
        titleLabel.textAlignment = NSTextAlignmentCenter; // 居中
        [shopView addSubview:titleLabel];
        
    /***********************3.设置数据*****************************/
        // 方式四 (数组 + 字典)
        /*
        NSArray<NSDictionary *> *dataArr = @[
                                             @{@"name":@"单肩包", @"icon":@"danjianbao"},
                                             @{@"name":@"钱包", @"icon":@"qianbao"},
                                             @{@"name":@"链条包", @"icon":@"liantiaobao"},
                                             @{@"name":@"手提包", @"icon":@"shoutibao"},
                                             @{@"name":@"双肩包", @"icon":@"shuangjianbao"},
                                             @{@"name":@"斜挎包", @"icon":@"xiekuabao"}
                                       ];
             */
        // 懒加载
        /*
        if (self.dataArr == nil) {
            self.dataArr = @[
                             @{@"name":@"单肩包", @"icon":@"danjianbao"},
                             @{@"name":@"钱包", @"icon":@"qianbao"},
                             @{@"name":@"链条包", @"icon":@"liantiaobao"},
                             @{@"name":@"手提包", @"icon":@"shoutibao"},
                             @{@"name":@"双肩包", @"icon":@"shuangjianbao"},
                             @{@"name":@"斜挎包", @"icon":@"xiekuabao"}
                             ];
        }
         */
        // 设置数据
        NSDictionary *dict = self.dataArr[index];
        iconView.image = [UIImage imageNamed:dict[@"icon"]];
        titleLabel.text = dict[@"name"];
    /***********************4.设置按钮的状态*****************************/

        sender.enabled = (index != 5);
        
        // 5.设置删除按钮的状态
        self.removeButton.enabled = YES;
        
}
- (IBAction)remove:(UIButton *)sender {
    // 1. 删除最后一个商品
    UIView *lastShopView = [self.shopView.subviews lastObject];
     [lastShopView removeFromSuperview];
     
     // 3. 设置添加按钮的状态
     self.addButton.enabled = YES;
     
     // 4. 设置删除按钮的状态
     /*
     if (self.shopCarView.subviews.count == 0) {
         self.removeButton.enabled = NO;
     }
      */
    self.removeButton.enabled = (self.shopView.subviews.count != 0);
}


@end
