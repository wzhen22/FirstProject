//
//  ThirtViewController.m
//  FirstProject
//
//  Created by 传晟 on 14-6-2.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "ThirtViewController.h"
#import "GridMainTableView.h"



@interface ThirtViewController ()

@end

@implementation ThirtViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    GridMainTableView *GridTV = [[GridMainTableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:GridTV];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
