//
//  TLSQRScannerViewController.m
//  QRScanner
//
//  Created by tls on 15/10/6.
//  Copyright (c) 2015年 tls. All rights reserved.
//

#import "TLSQRScannerViewController.h"
#import "UIAlertView+BlocksKit.h"


@interface TLSQRScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate>
- (IBAction)cancleScanButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *preView;

@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation TLSQRScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initScanningEnvironment];
    [self startScanning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [self endScanning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - event
- (IBAction)cancleScanButtonClicked:(id)sender {
    [self startScanning];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - delegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            [self stopScanning];
            
            [UIAlertView bk_showAlertViewWithTitle:@"QRMessage" message:[metadataObj stringValue] cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                ;
            }];
        }
    }
}


#pragma mark - private
- (BOOL)initScanningEnvironment{
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!deviceInput) {
        NSLog(@"device init is failed, %@",[error localizedDescription]);
        return NO;
    }
    self.captureSession = [[AVCaptureSession alloc]init];
    [self.captureSession addInput:deviceInput];
    
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    [output setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    [self.captureSession addOutput:output];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [output setMetadataObjectsDelegate:self queue:dispatchQueue];
    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.videoPreviewLayer.frame = self.preView.layer.bounds;
    [self.preView.layer addSublayer:self.videoPreviewLayer];
    
    return YES;
    
    
    
    
    return YES;
}
- (BOOL)startScanning{
    [self.captureSession startRunning];
    
    return YES;
}
- (BOOL)stopScanning{
    [self.captureSession stopRunning];
    
    return YES;
}
- (BOOL)endScanning{
    [self.captureSession stopRunning];
    self.captureSession = nil;
    [self.videoPreviewLayer removeFromSuperlayer];
    
    return YES;
}

@end
