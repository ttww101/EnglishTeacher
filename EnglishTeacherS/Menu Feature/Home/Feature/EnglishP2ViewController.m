//
//  EnglishP2ViewController.m
//  iHealthS
//
//  Created by Apple on 2019/3/21.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "EnglishP2ViewController.h"
#import "EnglishData.h"
#import "EnglishCellContorllerTableViewCell.h"

@interface EnglishP2ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mtableView;
@property (weak, nonatomic) IBOutlet UIButton *page1;
@property (weak, nonatomic) IBOutlet UIButton *page2;
@property (weak, nonatomic) IBOutlet UIButton *page3;
@property (weak, nonatomic) IBOutlet UIButton *page4;
@property (weak, nonatomic) IBOutlet UIButton *page5;
@property (weak, nonatomic) IBOutlet UIButton *page6;
@property (weak, nonatomic) IBOutlet UIButton *page7;
@property (weak, nonatomic) IBOutlet UIButton *page8;
@property (weak, nonatomic) IBOutlet UIButton *page9;
@property (weak, nonatomic) IBOutlet UIButton *page10;
@property (weak, nonatomic) IBOutlet UILabel *P2title;



@property NSString *jsonString;

//宣告一個存放連絡人的陣列變數，_contacts
@property NSMutableArray * contactsL;
@property NSMutableArray * contactsR;
@property NSMutableArray * answerL;
@property NSMutableArray * answerL_sw;
@property NSMutableArray * answerR;
@property NSMutableArray * answerR_sw;
@end

EnglishCellContorllerTableViewCell *cell;

@implementation EnglishP2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _url = @"http://47.75.131.189/a4dcb6f3661942c3f3d6090cf5320934/";
    
    self.P2title.text = _labTitle;
    
    NSLog(@" URL : %@", _url);
    NSLog(@" SORT : %@", _sort);
    
    _contactsL = [[NSMutableArray alloc] init];
    _contactsR = [[NSMutableArray alloc] init];
    _answerL = [[NSMutableArray alloc] init];
    _answerR = [[NSMutableArray alloc] init];
    _answerL_sw = [[NSMutableArray alloc] init];
    _answerR_sw = [[NSMutableArray alloc] init];
    
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:_url];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = [NSString stringWithFormat:@"sort=%@", _sort] ;//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    _jsonString = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    
    EnglishData *EnData = [[EnglishData alloc] initWithString:_jsonString error:nil];
    
    for(int i = 0 ; i < EnData.data.count; i += 1){
        DATA *data = EnData.data[i];
        if( i % 2){
            [_contactsL addObject:data.chinese];
            [_answerL addObject:data.english];
            [_answerL_sw addObject:@""];
        } else {
            [_contactsR addObject:data.chinese];
            [_answerR addObject:data.english];
            [_answerR_sw addObject:@""];
        }
    }
    
  
    self.mtableView.delegate = self;
    self.mtableView.dataSource = self;
    [self.mtableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    self.page1.tag = 1;
    self.page2.tag = 2;
    self.page3.tag = 3;
    self.page4.tag = 4;
    self.page5.tag = 5;
    self.page6.tag = 6;
    self.page7.tag = 7;
    self.page8.tag = 8;
    self.page9.tag = 9;
    self.page10.tag = 10;
    
    [self.page1 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.page2 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.page3 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.page4 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.page5 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.page6 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.page7 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.page8 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.page9 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.page10 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];

    [self.view addSubview:self.mtableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"reuse";
    //自訂Cell的類別
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        //載入CustomCell.xib檔
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"reuse" owner:nil options:nil];
        for (UIView *view in views) {
            if ([view isKindOfClass:[EnglishCellContorllerTableViewCell class]]){
                cell = (EnglishCellContorllerTableViewCell *)view;
            }
        }
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    [cell.Lbtan setTitle:[_contactsL objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [cell.Rbtn setTitle:[_contactsR objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [cell.Lt setText:[_answerL_sw objectAtIndex:indexPath.row]];
    [cell.Rt setText:[_answerR_sw objectAtIndex:indexPath.row]];
    
    [cell.Lbtan addTarget:self action:@selector(onClickedL:) forControlEvents:UIControlEventTouchUpInside];
    cell.Lbtan .tag = indexPath.row;
    [cell.Rbtn addTarget:self action:@selector(onClickedR:) forControlEvents:UIControlEventTouchUpInside];
    cell.Rbtn .tag = indexPath.row;

    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_contactsL count];
}



- (void)onClickedL:(UIButton *)sender{
    
    
    for(int i =0 ; i < 10 ; i++)
    {
        if( i == sender.tag)
        {
            if([_answerL_sw[i] isEqualToString:@""]){
                _answerL_sw[i] = _answerL[i];
            } else {
                _answerL_sw[i] = @"";
            }
            [_mtableView reloadData];
        }
    }
}

- (void)onClickedR:(UIButton *)sender{
    
    for(int i =0 ; i < 10 ; i++)
    {
        if( i == sender.tag)
        {
            if([_answerR_sw[i] isEqualToString:@""]){
                _answerR_sw[i] = _answerR[i];
            } else {
                _answerR_sw[i] = @"";
            }
            [_mtableView reloadData];
        }
    }
}

- (IBAction)onClickPageButton:(UIButton*)sender {
    
    for(int i =0; i< 11 ; i++){
        if(i == sender.tag){
            
            _contactsL = [[NSMutableArray alloc] init];
            _contactsR = [[NSMutableArray alloc] init];
            _answerL = [[NSMutableArray alloc] init];
            _answerR = [[NSMutableArray alloc] init];
            _answerL_sw = [[NSMutableArray alloc] init];
            _answerR_sw = [[NSMutableArray alloc] init];
            
            //第一步，创建URL
            NSURL *url = [NSURL URLWithString:_url];
            NSString * page = [[NSString alloc] initWithFormat:@"%ld", (long)sender.tag];
            NSDictionary *jsonBodyDict = @{@"sort":_sort, @"page":page};
            
            //第二步，创建请求
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
            //设置请求方式为POST，默认为GET
            [request setHTTPMethod:@"POST"];
            //设置参数
            NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:jsonBodyDict options:kNilOptions error:nil];
            [request setHTTPBody:jsonBodyData];
            //第三步，连接服务器
            NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            
            _jsonString = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
            EnglishData *EnData = [[EnglishData alloc] initWithString:_jsonString error:nil];
            
            for(int i = 0 ; i < EnData.data.count; i += 1){
                DATA *data = EnData.data[i];
                if( i % 2){
                    [_contactsL addObject:data.chinese];
                    [_answerL addObject:data.english];
                    [_answerL_sw addObject:@""];
                } else {
                    [_contactsR addObject:data.chinese];
                    [_answerR addObject:data.english];
                    [_answerR_sw addObject:@""];
                }
            }
            
             [_mtableView reloadData];
        }
    }
}

@end
