//
//  ViewController.m
//  SystemFont
//
//  Created by dev on 2017/6/9.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import "ViewController.h"

#import "FontCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *familyNameAry;

@property (nonatomic, strong) NSMutableArray *fontNameAry;

@end

@implementation ViewController

- (NSMutableArray *)familyNameAry{
    if (!_familyNameAry) {
        _familyNameAry = [NSMutableArray arrayWithArray:[UIFont familyNames]];
    }
    return _familyNameAry;
}

- (NSMutableArray *)fontNameAry{
    if (!_fontNameAry) {
        
        _fontNameAry = [NSMutableArray array];
        for (NSString *fontName in self.familyNameAry) {
            NSArray *nameAry = [UIFont fontNamesForFamilyName:fontName];
            [_fontNameAry addObject:nameAry];
        }
    }
    return _fontNameAry;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"系统字体";
    
    [self setupTableView];
}

- (void)setupTableView{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [tableView registerClass:NSClassFromString(@"FontCell") forCellReuseIdentifier:TableViewCellIdentifier0];

}

#pragma mark -
#pragma mark --- tableView delegate - dataSource ---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[self.fontNameAry objectAtIndex:section] count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.familyNameAry.count;
}

static NSString* TableViewCellIdentifier0 = @"TableViewCellIdentifier0";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FontCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier0];
    
    cell.textLabel.font = [UIFont fontWithName:self.fontNameAry[indexPath.section][indexPath.row] size:16];
    cell.textLabel.text = self.fontNameAry[indexPath.section][indexPath.row];
    
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.familyNameAry[section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self copyPasteboardWithIndexPath:indexPath];
}

#pragma mark -
#pragma mark --- 将字体复制到剪贴板 ---
- (void)copyPasteboardWithIndexPath:(NSIndexPath *)indexPath{
    
    NSString *str = self.fontNameAry[indexPath.section][indexPath.row];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:str];
    
    [[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"已将“%@”复制到剪贴板",str] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
