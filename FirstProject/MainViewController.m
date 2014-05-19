//
//  MainViewController.m
//  FirstProject
//
//  Created by 传晟 on 14-5-18.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "MainViewController.h"
#import "HeaderForCustoms.h"

@interface MainViewController (){
    UIScrollView *fScrollView;
    UIPageControl *pageCon;
    NSTimer *timer;
}

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我的首页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.baseScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 810)];
    self.baseScrollerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.baseScrollerView];
    
    wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
    NSString *lstring = [[NSBundle mainBundle] resourcePath];
    NSString *path = [lstring stringByAppendingPathComponent:@"MainController.json"];
    NSData *ldata = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:ldata options:NSJSONReadingAllowFragments error:nil];
    
    int rows = [[lDictionary objectForKey:@"rowsOfType"] intValue];//纪录json描绘的有多少行
    for (int i= 0; i<rows; i++) {
        NSString *keyOfGroupItems = [NSString stringWithFormat:@"itemsOfGroup_%d",i];
        NSDictionary *lDic = [lDictionary objectForKey:keyOfGroupItems];
        [dynamicLayout loadItemsForGroup:lDic AndBaseView:self.baseScrollerView];
    }
    
    
    NSDictionary *ldic = [dynamicLayout getItemsOfGroup:lDictionary];//直接调用解析的json文件的第一个字典----返回所有控件的tag值与类型的字典
    NSLog(@"***************%@",ldic);
    
    
    NSArray *widgetArray = [dynamicLayout instanceCustomButtonFromDic:ldic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
    [self customButtonClick:widgetArray];//执行响应的响应事件
    
    
    NSArray *imageArray = [dynamicLayout instanceCImageViewFromDic:ldic AndSupperView:self.view];
    [self imageViewClick:imageArray];
//    CImageVIew *iamgV = [imageArray objectAtIndex:0];
//    if ([iamgV isAnimating]) {
//        [iamgV performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
//        [iamgV performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"6"] afterDelay:2.1];
//    }
    NSArray *scrollViewArray = [dynamicLayout instanceCustomScrollViewFromDic:ldic AndSupperView:self.view];
    [self cScrollerViewClick:scrollViewArray];
    
    NSArray *pageControlArray = [dynamicLayout instanceCPageControlFromDic:ldic AndSupperView:self.view];
    //    NSLog(@"%@",pageControlArray);
    [self customPageControlClick:pageControlArray];
    
    
    NSArray *segmentControlArray = [dynamicLayout instanceCSegmentControlFromDic:ldic AndSupperView:self.view];
    //    NSLog(@"%@",segmentControlArray);
    [self customSegmentClick:segmentControlArray];
    
    NSArray *sliderArray = [dynamicLayout instanceSliderFromDic:ldic AndSupperView:self.view];
    [self customSliderClick:sliderArray];
    
    NSArray *swtichArray = [dynamicLayout instanceSwitchFromDic:ldic AndSupperView:self.view];
    [self customSwitchClick:swtichArray];
    
    NSArray *textFieldArray = [dynamicLayout instanceTextFieldFromDic:ldic AndSupperView:self.view];
    [self customTextFieldClick:textFieldArray];
    
    NSArray *customViewArray = [dynamicLayout instanceCustomViewFromDic:ldic AndSupperView:self.view];
    [self customViewClick:customViewArray];

    
}
#pragma mark 事件响应通过tag值取出后的描述方法
-(void)customButtonClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[customButton class]]) {
                customButton *cButton = [array objectAtIndex:i];
                __block customButton *cB = cButton;
                cButton.myblock = ^(customButton *button){
                    //        [cB performSelector:@selector(buttonClick:)];
                    if (cB.clickOfType == 1) {
                       
                    }
                    if (cB.clickOfType == 2)  {
                        
                    }
                    if (cB.clickOfType == 3) {
                        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"warning" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                        [alertView show];
                        NSLog(@"%ld",(long)alertView.cancelButtonIndex);
                        NSLog(@"%ld",(long)alertView.firstOtherButtonIndex);
                    }
                    if (cB.clickOfType == 4)  {
                        UIImage *image1 = [UIImage imageNamed:@"4"];
                        UIImage *image2 = [UIImage imageNamed:@"3"];
                        if ([[cB backgroundImageForState:UIControlStateNormal]isEqual:image2]) {
                            [cB setBackgroundImage:image1 forState:UIControlStateNormal];
                        }else{
                            [cB setBackgroundImage:image2 forState:UIControlStateNormal];
                        }
                    }
                    if (cB.clickOfType == 5)  {
                        
                        
                    }
                    NSLog(@"____________________");
                };
                
            }
        }
        
    }
}
//pagecontrol的事件监听描述
-(void)customPageControlClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CpageControl class]]){
                CpageControl *cPageControl = [array objectAtIndex:i];
                [cPageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventValueChanged];
                if (i==0) {
                    pageCon = cPageControl;
                }
            }
        }
    }
    
}
-(void)pageControlClick:(CpageControl *)sender{
    NSLog(@"hello");
    CGPoint point = fScrollView.contentOffset;
    point.x = sender.currentPage * 320;
    [fScrollView setContentOffset:point animated:YES];
    
}
//segmentcontrol的事件监听描述
-(void)customSegmentClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CustomSegmetnControl class]]){
                CustomSegmetnControl *cSement = [array objectAtIndex:i];
                [cSement addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
            }
        }
    }
    
}
-(void)segmentClick:(CustomSegmetnControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"first");
    }else{
        NSLog(@"other");
    }
}
//UISlider的事件监听描述
-(void)customSliderClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CustomSlider class]]){
                CustomSlider *cSlider = [array objectAtIndex:i];
                [cSlider addTarget:self action:@selector(sliderClick:) forControlEvents:UIControlEventValueChanged];
            }
        }
    }
    
}
-(void)sliderClick:(CustomSlider *)sender{
    NSLog(@"sender.value = %f",sender.value);
}
//CustomSwitch的事件监听描述
-(void)customSwitchClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CustomSwitch class]]){
                CustomSwitch *cSwitch = [array objectAtIndex:i];
                [cSwitch addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
            }
        }
    }
    
}
-(void)switchClick:(CustomSwitch *)sender{
    if (sender.on) {
        NSLog(@"选中状态");
    }else{
        NSLog(@"空闲状态");
    }
}
//textField的事件监听描述
-(void)customTextFieldClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CustomTextField class]]){
                CustomTextField *cTextField = [array objectAtIndex:i];
                [cTextField addTarget:self action:@selector(textFieldClick:) forControlEvents:UIControlEventEditingDidEndOnExit];
            }
        }
    }
}
-(void)textFieldClick:(CustomTextField *)sender{
    [sender resignFirstResponder];
    NSLog(@"resign");
}
//customView的事件点击描述
-(void)customViewClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CustomView class]]){
                CustomView *cView = [array objectAtIndex:i];
                cView.customViewBlock = ^(CustomView *viwe){
                    NSLog(@"customView be Touch!");
                };
            }
        }
    }
    
}
//imageView的事件点击描述
-(void)imageViewClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CImageVIew class]]){
                CImageVIew *cView = [array objectAtIndex:i];
                if ([cView isAnimating]) {
                    [cView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
                    [cView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"6"] afterDelay:2.1];
                }
            }
        }
    }
    
}
#pragma mark ScrollView description
//cutomScrollView的事件点击描述
-(void)cScrollerViewClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CustomScrollerView class]]){
                CustomScrollerView *cSView = [array objectAtIndex:i];
                
                if (i==0) {
                    cSView.pagingEnabled = YES;
                    fScrollView = cSView;
                    fScrollView.delegate = self;
                    //开启新的线程
//                    [self performSelectorInBackground:@selector(moreMetheard) withObject:nil];
                    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
                }
            }
        }
    }
    
}
-(void)moreMetheard{
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] run];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)scrollView.contentOffset.x/320;
    if ((int)scrollView.contentOffset.x % 320 == 0) {
        if (page == 3) {
            scrollView.contentOffset = CGPointMake(320, 0);
            page = 0;
        }else if (page == 0) {
            scrollView.contentOffset = CGPointMake(320*2, 0);
            page = 2;
        }
        
        pageCon.currentPage = page-1;
        
        NSLog(@"DidScroll");
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([timer isValid]) {  // 判断定时器是否运行
        [timer invalidate]; // 停止定时器
        timer = nil;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (timer == nil) {
//        [self performSelectorInBackground:@selector(moreMetheard) withObject:nil];
//        [self moreMetheard];
    }
}
- (void)onTimer:(NSTimer *)timer
{
    CGPoint point = fScrollView.contentOffset;
    point.x += 320;
    
    [fScrollView setContentOffset:point animated:YES];
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
