//
//  ViewController.m
//  XinSystem
//
//  Created by JY on 2018/9/20.
//  Copyright © 2018年 admin. All rights reserved.
//
// Description:每一部分的序号只在该方法集中起排序作用，在不同方法集或者在属性中，不可以一一对应，没有对应关系。

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "WebViewJavascriptBridge.h"
#import "DatePickerView.h"  
#import "MoneyPickerView.h"
#import "RoomDatePickerView.h"
#import "SKWebView.h"
#import "WKWebViewConfiguration+Console.h"
#import "TimeLabelView.h"
#import "FSCalenarView.h"
#import "LaunchView.h"
#import "TimePickerView.h"
#import "BlueToothView.h"
#import "HLBLEManager.h"
#import "HLPrinter.h"
#import "CuteAlert.h"

@interface ViewController ()<WKUIDelegate,WKNavigationDelegate,DateStringBack,MoneyStringBack,UIScrollViewDelegate,RoomDateStringBack,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)SKWebView *mWebView;
@property WebViewJavascriptBridge* bridge;
@property(nonatomic,strong)NSString *time_string;//首页长按色块上面显示的时间
@property(nonatomic,strong)NSString *calendar_string;//三方日历库选择的时间
@property(nonatomic,strong)NSArray *array_daily;//收到JS传来的选取器数据源
@property(nonatomic,strong)NSString *hour_minute_string;//传给JS的“时：分”选取结果
@property(nonatomic,strong)NSString *hour_minute_string_current;//点击网页内部按钮时候，JS传来的按钮上显示的文字
@property(nonatomic,strong)NSDictionary *result_dic;//显示发票使用的字典

//蓝牙部分
@property (strong, nonatomic) NSMutableArray *deviceArray; /**< 蓝牙设备 */
@property (strong, nonatomic) NSMutableArray *infos;  /**< 详情数组 */
@property (strong, nonatomic) CBCharacteristic *chatacter;  /**< 可写入数据的特性 */

//1.首页日期选择器
@property(nonatomic,strong)DatePickerView *date_PickerView;

//2.充值金钱选择器
@property(nonatomic,strong)MoneyPickerView *money_PickerView;

//3.房屋时间选择器
@property(nonatomic,strong)RoomDatePickerView *room_date_PickerView;

//4.首页长按色块
@property(nonatomic,strong)TimeLabelView *time_lable_view;

//5.日历选择器
@property(nonatomic,strong)FSCalenarView *calendar_view;

//6.遮羞布View不是用来交互的
@property(nonatomic,strong)LaunchView *launch_view;

//7.技师画页面选择时间的
@property(nonatomic,strong)TimePickerView *time_PickerView;

//8.蓝牙打印发票
@property(nonatomic,strong)BlueToothView *blue_tooth_view;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //初始化操作,这个子类化webView是为了打印日志，
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    //是否打印日志
    config.showConsole = YES;
    //是否支持JavaScript
    config.preferences.javaScriptEnabled = YES;
    self.mWebView=[[SKWebView alloc] initWithFrame:CGRectMake(0, -24, SCREEN_WIDTH, SCREEN_HEIGHT+24) configuration:config];
    
    //为了得到原生效果，做了一下特性的修改：
    //禁用下滑出现白条的手势
    self.mWebView.scrollView.bounces=NO;
    //禁用长按手势
//    for (UIView* subview in self.mWebView.scrollView.subviews) {
//            for (UIGestureRecognizer* gesture in subview.gestureRecognizers) {
//                if ([gesture isKindOfClass:UILongPressGestureRecognizer.class]) {
//                    [subview removeGestureRecognizer:gesture];
//                }
//            }
//    }
    
    self.mWebView.backgroundColor=[UIColor clearColor];
    
    NSURL *url=[NSURL URLWithString:XS_HOST];
    [self.view addSubview:self.mWebView];
    //缓存策略
    //默认的缓存策略是：NSURLRequestUseProtocolCachePolicy
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10.0f];
    [self.mWebView loadRequest:request];
    
    self.mWebView.UIDelegate=self;//弹出框等代理
    self.mWebView.navigationDelegate=self;//webView加载状态代理
    
    //与JS交互
    //初始化  WebViewJavascriptBridge
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.mWebView];
    [_bridge setWebViewDelegate:self];
    
    //申明js调用oc方法的处理事件，这里写了后，h5那边只要请求了，oc内部就会响应
    [self JS2OC];
    
    //添加遮羞布View
    [self.view addSubview:self.launch_view];
    //开始动画缩放
    //给VUE18秒的加载时间
    [UIView animateWithDuration:9.0 animations:^{
        self.launch_view.transform=CGAffineTransformScale(self.launch_view.transform, 1.3, 1.3);
    }];
    [UIView animateWithDuration:9.0 animations:^{
        self.launch_view.transform=CGAffineTransformScale(self.launch_view.transform, 0.8, 0.8);
    }];
    
    //添加app进入前台的标志
    // app启动或者app从后台进入前台都会调用这个方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

#pragma mark 与JS交互
/**
 JS  调用  OC
 */
-(void)JS2OC{
    /*
     含义：1.JS调用OC请求日期选取框
     @param registerHandler 要注册的事件名称
     @param handel 回调block函数 当后台触发这个事件的时候会执行block里面的代码
     */
    [_bridge registerHandler:@"dateAction" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data js页面传过来的参数
        NSLog(@"JS调用OC，并传值过来");
        
        // 利用data参数处理自己的逻辑
        [self.view addSubview:self.date_PickerView];
        
        // responseCallback 给后台的回复
        responseCallback(@"oc已收到js的请求");
    }];
    
    //3.JS调用OC请求房间日期选取框
    [_bridge registerHandler:@"roomDateAction" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"JS调用OC，并传值过来");
        
        //构造一个日期选取器View
        [self.view addSubview:self.room_date_PickerView];
        
        responseCallback(@"oc已收到js的请求");
    }];
    
    //4.JS调用OC请求显示时间label
    [_bridge registerHandler:@"timeLabelAction" handler:^(NSDictionary *data, WVJBResponseCallback responseCallback) {
        NSLog(@"JS调用OC，并传值过来");
        
        NSNumber *top=[data objectForKey:@"top"];
        NSNumber *left=[data objectForKey:@"left"];
        NSString *time=(NSString *)[data objectForKey:@"time"];
        
        //构造一个时间Label
        [self.view addSubview:self.time_lable_view];
        [UIView animateWithDuration:0.2 animations:^{
            self.time_lable_view.frame=CGRectMake([left integerValue]-19, [top integerValue]-19, 129, 65);
            self.time_lable_view.timeLabel.text=[NSString stringWithFormat:@"%@",time];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if ([self.time_lable_view.timeLabel.text isEqualToString:self.time_string]) {
                    [self.time_lable_view removeFromSuperview];
                }
            });
        } completion:^(BOOL finished) {
            self.time_string=self.time_lable_view.timeLabel.text;
        }];
        
        responseCallback(@"oc已收到js的请求");
    }];
    
    //5.JS调用OC请求显示日历
    [_bridge registerHandler:@"calendarViewAction" handler:^(NSDictionary *data, WVJBResponseCallback responseCallback) {
        NSLog(@"JS调用OC，并传值过来");
        
        NSNumber *origin_x=[data objectForKey:@"x"];
        NSNumber *origin_y=[data objectForKey:@"y"];
        
        //构造一个日期选取器View
        self.calendar_view.frame=CGRectMake([origin_x integerValue]-400/2, [origin_y integerValue], 400, 364);
        [self.view addSubview:self.calendar_view];
        
        responseCallback(@"oc已收到js的请求");
    }];
    
    //6.JS调用OC钟数时间下拉选取框
    [_bridge registerHandler:@"dailyReportAction" handler:^(NSDictionary *data, WVJBResponseCallback responseCallback) {
        NSLog(@"JS调用OC，并传值过来");
        
        self.array_daily=[data objectForKey:@"data"];
        
        //构造一个技师选取器
        [self pickerDaily];
        
        responseCallback(@"oc已收到js的生成滑动条的请求");
    }];
    //7.JS调用OC技师时间下部选取框
    [_bridge registerHandler:@"hourMinuteReportAction" handler:^(NSDictionary *data, WVJBResponseCallback responseCallback) {
        NSLog(@"JS调用OC，并传值过来");
        
        NSString *string=[data objectForKey:@"selectedTime"];
        self.hour_minute_string_current=string;
        self.time_PickerView.current_hour_minute=self.hour_minute_string_current;
        self.time_PickerView.timeString=self.hour_minute_string_current;
        
        //构造一个技师选取器
        [self timePicker];
        
        responseCallback(@"oc已收到js的生成滑动条的请求");
    }];
    
    //8.JS调用OC蓝牙交互
    [_bridge registerHandler:@"blueToothAction" handler:^(NSDictionary *data, WVJBResponseCallback responseCallback) {
        NSLog(@"JS调用OC，并传值过来");

        //蓝牙
        [self.view addSubview:self.blue_tooth_view];
        
        NSDictionary *allDic=[data objectForKey:@"infoData"];
        
        NSNumber *amount=[allDic objectForKey:@"amount"];
        NSNumber *orderNumber=[allDic objectForKey:@"orderNumber"];
        NSArray *array=[allDic objectForKey:@"productsInfo"];
        NSMutableString *product_string=[[NSMutableString alloc] init];
        for (NSDictionary *dic in array) {
            NSString *string=[dic objectForKey:@"productName"];
            [product_string appendString:[NSString stringWithFormat:@"%@,",string]];
        }
        NSString *shopName=[allDic objectForKey:@"shopName"];
        NSString *time=[allDic objectForKey:@"time"];
        
        self.result_dic=@{@"amount":amount,
                          @"orderNumber":orderNumber,
                          @"product_string":product_string,
                          @"shopName":shopName,
                          @"time":time
                          };
        
        self.blue_tooth_view.print_button.hidden = YES;//隐藏打印按钮
        
        self.deviceArray = [[NSMutableArray alloc] init];
        self.infos = [[NSMutableArray alloc] init];
        
        HLBLEManager *manager = [HLBLEManager sharedInstance];
        __weak HLBLEManager *weakManager = manager;
        manager.stateUpdateBlock = ^(CBCentralManager *central) {
            NSString *info = nil;
            switch (central.state) {
                case CBCentralManagerStatePoweredOn:
                    info = @"蓝牙已打开，并且可用";
                    //三种种方式
                    // 方式1
                    [weakManager scanForPeripheralsWithServiceUUIDs:nil options:nil];
                    //                // 方式2
                    //                [central scanForPeripheralsWithServices:nil options:nil];
                    //                // 方式3
                    //                [weakManager scanForPeripheralsWithServiceUUIDs:nil options:nil didDiscoverPeripheral:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
                    //
                    //                }];
                    break;
                case CBCentralManagerStatePoweredOff:
                    info = @"蓝牙可用，未打开";
                    break;
                case CBCentralManagerStateUnsupported:
                    info = @"SDK不支持";
                    break;
                case CBCentralManagerStateUnauthorized:
                    info = @"程序未授权";
                    break;
                case CBCentralManagerStateResetting:
                    info = @"CBCentralManagerStateResetting";
                    break;
                case CBCentralManagerStateUnknown:
                    info = @"CBCentralManagerStateUnknown";
                    break;
            }
            
            [self alert:info];
        };
        manager.discoverPeripheralBlcok = ^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
            if (peripheral.name.length <= 0) {
                return ;
            }
            
            if (self.deviceArray.count == 0) {
                NSDictionary *dict = @{@"peripheral":peripheral, @"RSSI":RSSI};
                [self.deviceArray addObject:dict];
            } else {
                BOOL isExist = NO;
                for (int i = 0; i < self.deviceArray.count; i++) {
                    NSDictionary *dict = [self.deviceArray objectAtIndex:i];
                    CBPeripheral *per = dict[@"peripheral"];
                    if ([per.identifier.UUIDString isEqualToString:peripheral.identifier.UUIDString]) {
                        isExist = YES;
                        NSDictionary *dict = @{@"peripheral":peripheral, @"RSSI":RSSI};
                        [self.deviceArray replaceObjectAtIndex:i withObject:dict];
                    }
                }
                
                if (!isExist) {
                    NSDictionary *dict = @{@"peripheral":peripheral, @"RSSI":RSSI};
                    [self.deviceArray addObject:dict];
                }
            }
            
            [self.blue_tooth_view.tableView reloadData];
            
        };
        
        responseCallback(@"oc已收到js的生成滑动条的请求");
    }];
}

-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    [self.mWebView reload];
}

/**
 OC  调用  JS
 */
//1.首页日期选择器返回值给JS
-(void)OC2JS_DATE{
    /*
     含义：OC调用JS返回字符串参数
     @param callHandler 商定的事件名称,用来调用网页里面相应的事件实现
     @param data id类型,相当于我们函数中的参数,向网页传递函数执行需要的参数
     注意，这里callHandler分3种，根据需不需要传参数和需不需要后台返回执行结果来决定用哪个
     */
    [self.date_PickerView removeFromSuperview];
    
    //[_bridge callHandler:@"registerAction" data:@"我是oc请求js的参数"];
    [_bridge callHandler:@"resultDateAction" data:self.date_PickerView.dateString responseCallback:^(id responseData) {
        NSLog(@"oc请求js后接受的回调结果：%@",responseData);
    }];
}

//3.房屋时间选择器返回值给JS
-(void)OC2JS_ROOM_DATE{
    [self.room_date_PickerView removeFromSuperview];
    
    if (self.room_date_PickerView.result_string.length<1) {
        
    }else{
        //OC调用JS返回money参数
        [_bridge callHandler:@"resultRoomDateAction" data:self.room_date_PickerView.result_string responseCallback:^(id responseData) {
            NSLog(@"oc请求js后接受的回调结果：%@",responseData);
        }];
    }
}

//4.首页长按色块不需要返回值给JS，只是用作显示

//5.日历选择器返回值给JS
-(void)OC2JS_CALENDAR{
    //OC调用JS返回日历选择参数
    
    [_bridge callHandler:@"resultCalendarAction" data:self.calendar_string responseCallback:^(id responseData) {
        NSLog(@"oc请求js后接受的回调结果：%@",responseData);
    }];
    
    [self.calendar_view removeFromSuperview];
}

//6.钟数返回选择器值给JS
-(void)OC2JS_DAILY{
    //OC调用JS返回钟数时间
    NSInteger row=[self.money_PickerView.moneyString integerValue];
    NSDictionary *dic=self.array_daily[row];
    
    [self.money_PickerView removeFromSuperview];
    
    if (self.money_PickerView.moneyString.length<1) {
        
    }else{
    [_bridge callHandler:@"resultDailyAction" data:dic responseCallback:^(id responseData) {
        NSLog(@"oc请求js后接受的回调结果：%@",responseData);
    }];
    
    }
}

//7.将时间选择器值返回给JS
-(void)OC2JS_TIME_HOUR{
    //OC调用JS返回时间
    [_bridge callHandler:@"resultHourMinuteAction" data:self.hour_minute_string responseCallback:^(id responseData) {
        NSLog(@"oc请求js后接受的回调结果：%@",responseData);
    }];
}


#pragma mark 懒加载
//1.
-(DatePickerView *)date_PickerView{
    if (!_date_PickerView) {
        _date_PickerView=[[DatePickerView alloc] initWithFrame:self.view.bounds];
        _date_PickerView.delegate=self;
    }
    return _date_PickerView;
}

//3.
-(RoomDatePickerView*)room_date_PickerView{
    if (!_room_date_PickerView) {
        _room_date_PickerView=[[RoomDatePickerView alloc] initWithFrame:self.view.bounds];
        _room_date_PickerView.delegate=self;
    }
    return _room_date_PickerView;
}

//4.
-(TimeLabelView *)time_lable_view{
    if (!_time_lable_view) {
        _time_lable_view=[[TimeLabelView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 129, 80)];
    }
    return _time_lable_view;
}

//5.
-(FSCalenarView *)calendar_view{
    if (!_calendar_view) {
        _calendar_view=[[FSCalenarView alloc] initWithFrame:CGRectMake(0, 0, 400, 300)];
        
        __weak __typeof(self) weakself=self;
        self.calendar_view.date_result_Block = ^(NSString *dateString) {
            weakself.calendar_string=dateString;
            [weakself OC2JS_CALENDAR];
            [weakself.calendar_view removeFromSuperview];
        };
        
        self.calendar_view.cacel_result_Block = ^{
            [weakself.calendar_view removeFromSuperview];
        };
    }
    return _calendar_view;
}

//6.
-(void)pickerDaily{
    [self.view addSubview:self.money_PickerView];
    _money_PickerView.moneyArray=[[NSMutableArray alloc] init];
    for (NSDictionary *dic in self.array_daily) {
        NSString *sequenceId=[dic objectForKey:@"sequenceId"];
        NSString *string=[NSString stringWithFormat:@"%@号 技师",sequenceId];
        [_money_PickerView.moneyArray addObject:string];
    }
    [_money_PickerView addUI];
    //动画弹出View
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.money_PickerView.frame=CGRectMake(0, SCREEN_HEIGHT-400, SCREEN_WIDTH, 400);
    } completion:^(BOOL finished) {
    }];
}

-(MoneyPickerView*)money_PickerView{
    if (!_money_PickerView) {
        _money_PickerView=[[MoneyPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400)];
        _money_PickerView.delegate=self;
    }
    return _money_PickerView;
}

//7.
-(LaunchView *)launch_view{
    if (!_launch_view) {
        _launch_view=[[LaunchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _launch_view;
}

//8.
-(void)timePicker{
    [self.view addSubview:self.time_PickerView];
    [_time_PickerView addUI];
    //动画弹出View
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.time_PickerView.frame=CGRectMake(0, SCREEN_HEIGHT-400, SCREEN_WIDTH, 400);
    } completion:^(BOOL finished) {
    }];
}

-(TimePickerView *)time_PickerView{
    if (!_time_PickerView) {
        _time_PickerView=[[TimePickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400)];
        
        __weak __typeof(self) weakself=self;
        _time_PickerView.time_string_back_block = ^(NSString *time_string) {
            weakself.hour_minute_string=time_string;
            [weakself OC2JS_TIME_HOUR];
            [weakself.time_PickerView removeFromSuperview];
        };
        
        _time_PickerView.time_string_cancel_block = ^{
            [weakself.time_PickerView removeFromSuperview];
        };
    }
    return _time_PickerView;
}

//9.蓝牙
-(BlueToothView *)blue_tooth_view{
    if (!_blue_tooth_view) {
        _blue_tooth_view=[[BlueToothView alloc] initWithFrame:self.view.bounds];
        _blue_tooth_view.tableView.delegate=self;
        _blue_tooth_view.tableView.dataSource=self;
        __weak __typeof(self) weakself=self;
        _blue_tooth_view.cancel_block = ^{
          
            HLBLEManager *manager = [HLBLEManager sharedInstance];
            [manager stopScan];
            [manager clear];
            [weakself.blue_tooth_view removeFromSuperview];
        };
        _blue_tooth_view.print_block = ^{
            if (weakself.chatacter) {
                NSData *mainData = [[weakself getPrinter] getFinalData];

                HLBLEManager *bleManager = [HLBLEManager sharedInstance];
                [bleManager writeValue:mainData forCharacteristic:weakself.chatacter type:CBCharacteristicWriteWithoutResponse];
            } else {
                [weakself alert:@"查找特性失败！,重新连接"];
            }
        };
    }
    return _blue_tooth_view;
}


#pragma mark 代理方法

//交互桥的代理方法
-(void)disableSafetyTimeout {
    [self.bridge disableJavscriptAlertBoxSafetyTimeout];
}

//传值的代理方法
-(void)dateStringToJs{
  [self OC2JS_DATE];
}

//传值的代理方法
-(void)moneyStringToJs{
  [self OC2JS_DAILY];
    
  [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.money_PickerView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400);
    } completion:^(BOOL finished) {
        
    }];
}

//传值的代理方法
-(void)cancelMoneyStringToJS{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.money_PickerView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 400);
    } completion:^(BOOL finished) {
        
    }];
}

//传值的代理方法
-(void)roomDateStringToJs{
    [self OC2JS_ROOM_DATE];
}

//WKWebView的导航代理方法
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"加载完成了");
    //在网页加载完毕之后移除遮羞布View
    [UIView animateWithDuration:0.7 animations:^{
        self.launch_view.opaque=YES;
        self.launch_view.alpha=0.0;
    }];
}

//tableview代理及数据源

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deviceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_blue"];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell_blue"];
    }
    
    // Configure the cell...
    NSDictionary *dict = [self.deviceArray objectAtIndex:indexPath.row];
    CBPeripheral *peripherral = dict[@"peripheral"];
    cell.textLabel.text = [NSString stringWithFormat:@"名称:%@",peripherral.name];
    //    cell.detailTextLabel.text = [NSString stringWithFormat:@"信号强度:%@",dict[@"RSSI"]];
    
    if (peripherral.state == CBPeripheralStateConnected) {
        cell.detailTextLabel.text = @"已连接";
    } else {
        cell.detailTextLabel.text = @"未连接";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 连接蓝牙
    [self loadBLEInfoWithIndexPath:indexPath];
}

//连接
- (void)loadBLEInfoWithIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.blue_tooth_view.tableView cellForRowAtIndexPath:indexPath];
    
    NSDictionary *dict = [self.deviceArray objectAtIndex:indexPath.row];
    CBPeripheral *peripheral = dict[@"peripheral"];
    
    HLBLEManager *manager = [HLBLEManager sharedInstance];
    [manager connectPeripheral:peripheral
                connectOptions:@{CBConnectPeripheralOptionNotifyOnDisconnectionKey:@(YES)}
        stopScanAfterConnected:YES
               servicesOptions:nil
        characteristicsOptions:nil
                 completeBlock:^(HLOptionStage stage, CBPeripheral *peripheral, CBService *service, CBCharacteristic *character, NSError *error) {
                     switch (stage) {
                         case HLOptionStageConnection:
                         {
                             if (error) {
                                 //                                 [SVProgressHUD showErrorWithStatus:@"连接失败"];
                                 [self alert:@"连接失败"];
                             } else {
                                 //                                 [SVProgressHUD showSuccessWithStatus:@"连接成功"];
                                 [self alert:@"连接成功"];
                                 cell.detailTextLabel.text = @"已连接";
                                 [self.blue_tooth_view.tableView reloadData];
                             }
                             break;
                         }
                         case HLOptionStageSeekServices:
                         {
                             if (error) {
                                 //                                 [SVProgressHUD showSuccessWithStatus:@"查找服务失败"];
                                 //ALERT(@"查找服务失败");
                             } else {
                                 //                                 [SVProgressHUD showSuccessWithStatus:@"查找服务成功"];
                                 [self.infos addObjectsFromArray:peripheral.services];
                                 //                                 [_tableView reloadData];
                                 //ALERT(@"查找服务成功");
                             }
                             break;
                         }
                         case HLOptionStageSeekCharacteristics:
                         {
                             // 该block会返回多次，每一个服务返回一次
                             if (error) {
                                 NSLog(@"查找特性失败");
                             } else {
                                 NSLog(@"查找特性成功");
                                 //                                 [_tableView reloadData];
                                 
                                 self.blue_tooth_view.print_button.hidden = NO;
                                 
                                 for (int i = 0; i < self.infos.count; i++) {
                                     
                                     CBService *service = self.infos[i];
                                     for (int j = 0; j < service.characteristics.count; j++) {
                                         CBCharacteristic *character = [service.characteristics objectAtIndex:j];
                                         CBCharacteristicProperties properties = character.properties;
                                         if (properties & CBCharacteristicPropertyWriteWithoutResponse) {
                                             self.chatacter = character;
                                         }
                                     }
                                 }
                                 
                             }
                             break;
                         }
                         case HLOptionStageSeekdescriptors:
                         {
                             // 该block会返回多次，每一个特性返回一次
                             if (error) {
                                 NSLog(@"查找特性的描述失败");
                             } else {
                                 NSLog(@"查找特性的描述成功");
                             }
                             break;
                         }
                         default:
                             break;
                     }
                 }];
}

- (HLPrinter *)getPrinter
{
    NSString *title = @"验券历史记录";
    
    HLPrinter *printer = [[HLPrinter alloc] initWithShowPreview:YES];
    [printer appendImage:[UIImage imageNamed:@"bluetoothLogo"] alignment:HLTextAlignmentCenter maxWidth:320];
    [printer appendTitle:@"" value:@"" valueOffset:20];
    [printer appendText:title alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleMiddle];
    [printer appendTitle:@"套餐名:" value:self.result_dic[@"product_string"] valueOffset:20];
    [printer appendTitle:@"售价:" value:[NSString stringWithFormat:@"%@元", self.result_dic[@"amount"]] valueOffset:20];
    [printer appendTitle:@"消费门店:" value:[NSString stringWithFormat:@"Xin SPA(%@)", self.result_dic[@"shopName"]] valueOffset:20];
    [printer appendTitle:@"消费时间:" value:self.result_dic[@"time"] valueOffset:20];
    
    
    [printer appendSeperatorLine];
    [printer appendTitle:@"验证张数:" value: @"1张" valueOffset:20 ];
    [printer appendTitle:@"总额:" value: [NSString stringWithFormat:@"%@元", self.result_dic[@"amount"]] valueOffset:20];
    [printer appendTitle:@"订单号：" value:[self.result_dic[@"orderNumber"] substringToIndex:15] valueOffset:20];
    
    [printer appendFooter:nil];
    [printer appendTitle:@"" value: @"" valueOffset:20];
    [printer appendTitle:@"" value: @"" valueOffset:20];
    [printer appendTitle:@"" value: @"" valueOffset:20];
    
    return printer;
}

#pragma mark target action

-(void)alert:(NSString *)info{
    CuteAlert *alert=[[CuteAlert alloc] initWithFrame:CGRectMake(0, -100, SCREEN_WIDTH, 100)];
    [self.mWebView addSubview:alert];
    [alert showAlert:info];
}

#pragma mark 生命周期方法
-(void)applicationBecomeActive{
//    [self.mWebView reload];
    NSLog(@"重新加载一次");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
