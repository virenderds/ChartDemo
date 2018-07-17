//
//  ViewController.m
//  ChartDemo
//
//  Created by DS on 20/01/17.
//  Copyright © 2017 DS. All rights reserved.
//

#import "ViewController.h"
#import "PNChart.h"
#import "PNChartDelegate.h"

@interface ViewController ()<PNChartDelegate>
@property (nonatomic) IBOutlet PNBarChart * barChart;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self showChart];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, yyyy"];
    
    NSLog(@"%@",[formatter stringFromDate:[self getWeekDate:true minusLast:1]]);
    NSLog(@"%@",[formatter stringFromDate:[self getWeekDate:false minusLast:1]]);    // Do any additional setup after loading the view, typically from a nib.
}


+(NSDate*)getWeekDate:(BOOL)isStartDate minusLast:(int)week{
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger weekNumber =  [[calendar components: NSCalendarUnitWeekOfYear fromDate:now] weekOfYear];
    
    
    weekNumber = week;
    
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comp = [gregorian components:NSCalendarUnitYear fromDate:now];
    
    [comp setWeekOfYear:weekNumber];
    
    //First day of the week. Change it to 7 to get the last date of the week
    if (isStartDate){
        [comp setWeekday:2];
    } else{
        [comp setWeekday:7];
    }
    return [gregorian dateFromComponents:comp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showChart{
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 64, size.width, 250.0)];
    //self.barChart.showLabel = NO;
    self.barChart.yLabelPrefix=@"";
    self.barChart.yLabelSuffix=@"";
    //self.barChart.yLabelSum=Yarray.count-1;
    self.barChart.backgroundColor = [UIColor clearColor];
    self.barChart.labelMarginTop = 5.0;
    self.barChart.showChartBorder = YES;
    [self.barChart setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"]];
    //self.barChart.yLabels = Yarray;
    [self.barChart setYValues:@[@50.0,@60.0,@70.0,@65.0,@71.0,@40.0,@50.0,@60.0]];
    //[self.barChart setStrokeColors:colorArray];
    self.barChart.isGradientShow = NO;
    self.barChart.isShowNumbers = NO;
    [self.barChart strokeChart];
    self.barChart.delegate = self;
    self.barChart.yLabelFormatter = ^(CGFloat yValue){
        CGFloat yValueParsed = yValue;
        NSString * labelText = [NSString stringWithFormat:@"%0.f",yValueParsed];
        return labelText;
    };
    [self.view addSubview:self.barChart];
}
- (void)userClickedOnBarAtIndex:(NSInteger)barIndex{
    NSLog(@"user click on bar");
    //tempDic = [resultArray objectAtIndex:barIndex];
    //[self performSegueWithIdentifier:@"showHistory" sender:nil];
}
@end
