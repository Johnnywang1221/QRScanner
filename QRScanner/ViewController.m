//
//  ViewController.m
//  QRScanner
//
//  Created by tls on 15/10/6.
//  Copyright (c) 2015年 tls. All rights reserved.
//

#import "ViewController.h"
#import "TLSQRScannerViewController.h"

@interface ViewController ()
//@property (nonatomic, strong) TLSQRScannerViewController *scanViewController;
- (IBAction)scanButtonClicked:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scanButtonClicked:(id)sender {
    TLSQRScannerViewController *scanViewController = [[TLSQRScannerViewController alloc]init];
    [self presentViewController:scanViewController animated:YES completion:nil];
    
}

#pragma mark - getter/setter

//-(TLSQRScannerViewController *)scanViewController{
//    if (_scanViewController == nil) {
//        _scanViewController = [[TLSQRScannerViewController alloc]init];
//    }
//    return _scanViewController;
//}
@end
