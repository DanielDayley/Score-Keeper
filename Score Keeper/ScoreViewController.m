//
//  ScoreViewController.m
//  Score Keeper
//
//  Created by Cole Wilkes on 4/28/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController () {
    CGFloat previousY;
}

@end

@implementation ScoreViewController

static CGFloat viewWidth;
static CGFloat viewHeight;
static CGFloat sideMargin = 15;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scoreLabels = [[NSMutableArray alloc] init];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:self.scrollView];
    
    viewWidth = self.scrollView.frame.size.width;
    viewHeight = 64.0;
    
    self.title = @"Score Keeper";
    previousY = 0;
    sideMargin = 15;
    
    [self addScoreView:10];
}

- (void)addScoreView:(NSInteger)index {
    CGFloat scrollViewHeight = 0;
    
    for (int i = 0; i <= index; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, previousY, viewWidth, viewHeight)];
        
        UITextField *name = [[UITextField alloc] initWithFrame:CGRectMake(sideMargin, viewHeight / 2 - 15, 125, 30)];
        name.placeholder = @"Name";
        name.borderStyle = UITextBorderStyleRoundedRect;
        
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth / 2, viewHeight / 2 - 25, 50, 50)];
        scoreLabel.text = @"0";
        [self.scoreLabels insertObject:scoreLabel atIndex:i];
        
        UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectMake(viewWidth - 94 - sideMargin, viewHeight / 2 - 15, 0, 20)];
        stepper.maximumValue = 100;
        stepper.minimumValue = 0;
        stepper.stepValue = 5;
        stepper.tag = index;
        
        [stepper addTarget:self action:@selector(changeLabelAtIndex:) forControlEvents:UIControlEventValueChanged];
        
        [view addSubview:name];
        [view addSubview:scoreLabel];
        [view addSubview:stepper];
        
        [self.scrollView addSubview:view];
        
        previousY += view.frame.size.height + 1;
    }
    scrollViewHeight = previousY;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, scrollViewHeight);
}

- (void)changeLabelAtIndex:(UIStepper *)sender {
    UILabel *scoreLabel = [self.scoreLabels objectAtIndex:sender.tag];
    NSString *value = [NSString stringWithFormat:@"%f", sender.stepValue];
    [scoreLabel setText:value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
