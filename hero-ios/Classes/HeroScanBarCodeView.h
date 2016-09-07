//
//  Created by gpliu@icloud.com
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "UIView+Hero.h"

@interface HeroScanBarCodeView : UIView <AVCaptureMetadataOutputObjectsDelegate>

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@end
