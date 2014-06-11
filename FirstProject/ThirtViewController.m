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
//    self.view.bounds
    self.view.backgroundColor = [UIColor whiteColor];
    GridMainTableView *GridTV = [[GridMainTableView alloc]initWithFrame:CGRectMake(0, 0, 320, 400)];
    [self.view addSubview:GridTV];
    
    
    UITapGestureRecognizer *lTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    UIImageView *lImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"x_alt_32x32"]];
    lImageView.frame = CGRectMake(260, 500, 40, 40);
    lImageView.alpha = 0.6;
    [lImageView addGestureRecognizer:lTapGesture];
    lImageView.userInteractionEnabled = YES;
    [self.view addSubview:lImageView];

    
    
    
}

-(void)tapClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
