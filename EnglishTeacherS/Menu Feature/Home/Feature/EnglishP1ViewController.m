//
//  Feature2ViewController.m
//  iHealthS
//
//  Created by Wu on 2019/3/13.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "EnglishP1ViewController.h"
#import "UIView+Constraint.h"
#import "EnglishP2ViewController.h"

//英文單字
@interface EnglishP1ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *ACBtn;
@property (weak, nonatomic) IBOutlet UIButton *CFBtn;
@property (weak, nonatomic) IBOutlet UIButton *FLBtn;
@property (weak, nonatomic) IBOutlet UIButton *LPBtn;
@property (weak, nonatomic) IBOutlet UIButton *PSBtn;
@property (weak, nonatomic) IBOutlet UIButton *SZBtn;
@property (weak, nonatomic) NSString *sort1;
@property (weak, nonatomic) NSString *labTitle1;

@end

@implementation EnglishP1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSLog(@"ggagagaga :  %@", self.ACBtn.titleLabel.text);
    self.ACBtn.tag = 1;
    self.CFBtn.tag = 2;
    self.FLBtn.tag = 3;
    self.LPBtn.tag = 4;
    self.PSBtn.tag = 5;
    self.SZBtn.tag = 6;
    
    [self.ACBtn addTarget:self action:@selector(onClickButton:)forControlEvents:UIControlEventTouchDown];
    [self.CFBtn addTarget:self action:@selector(onClickButton:)forControlEvents:UIControlEventTouchDown];
    [self.FLBtn addTarget:self action:@selector(onClickButton:)forControlEvents:UIControlEventTouchDown];
    [self.LPBtn addTarget:self action:@selector(onClickButton:)forControlEvents:UIControlEventTouchDown];
    [self.PSBtn addTarget:self action:@selector(onClickButton:)forControlEvents:UIControlEventTouchDown];
    [self.SZBtn addTarget:self action:@selector(onClickButton:)forControlEvents:UIControlEventTouchDown];
}

- (IBAction)onClickButton:(UIButton*)sender {
    
    _sort1 = [[NSString alloc] initWithFormat:@"%d", sender.tag];
    _labTitle1 = sender.titleLabel.text;
}

#pragma mark handle segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"enP2"]) {
        
        EnglishP2ViewController *viewCtrl2 = segue.destinationViewController;
        //the destination is View 2
        viewCtrl2.sort = _sort1;
        viewCtrl2.labTitle = _labTitle1;
        
    }
}

@end
