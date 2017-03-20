//
//  ViewController.m
//  MultilevelMenu
//
//  Created by zhanghaidi on 2017/3/13.
//  Copyright © 2017年 yanshu. All rights reserved.
//

#import "ViewController.h"
#import "MultileveMenu.h"


@interface ViewController ()<MultileveMenuDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MultileveMenu *menu = [[MultileveMenu alloc] initWithFrame:self.view.bounds];
    menu.delegate = self;
    [self.view addSubview:menu];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)multileveMenu:(MultileveMenu *)menu didSelectedMoreWithMenuIndexPath:(MultileveMenuIndexPath *)indexPath {
    NSLog(@"选中`更多` master = %d, sSection = %d", (int)indexPath.masterRow,(int)indexPath.secondaryIndexPath.section);
}

- (void)multileveMenu:(MultileveMenu *)menu didSelectedItemWithMenuIndexPath:(MultileveMenuIndexPath *)indexPath {
    NSLog(@"选中 master = %d, sSection = %d, item = %d", (int)indexPath.masterRow,(int)indexPath.secondaryIndexPath.section, (int)indexPath.secondaryIndexPath.item);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
