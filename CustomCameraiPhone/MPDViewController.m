//
//  ViewController.m
//  CustomCameraiPhone
//
//  Created by Marcin Pędzimąż on 20.12.2014.
//  Copyright (c) 2014 Marcin Pedzimaz. All rights reserved.
//

#import "MPDViewController.h"
#import "MPDCustomCameraViewController.h"

#import "UIImage+Utilities.h"
#import "MDPConstants.h"

@interface MPDViewController ()

@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;
@property (weak, nonatomic) MPDCustomCameraViewController *cameraController;

@end

@implementation MPDViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setupSatutrationSlider];
}

- (void)setupSatutrationSlider
{
    UIImage *thumbImage = [UIImage imageWithRadius:10.5
                                             color:[UIColor lightGrayColor]];
    
    [self.saturationSlider setThumbImage:thumbImage
                                forState:UIControlStateNormal];
    [self.saturationSlider setThumbImage:thumbImage
                                forState:UIControlStateHighlighted];
}

- (IBAction)handleStaruationValueChange:(UISlider *)sender {

    self.cameraController.saturation = sender.value;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:MDPSegueIdentifiers.customCamera]) {
        
        MPDCustomCameraViewController *cameraController = segue.destinationViewController;
        
        self.cameraController = cameraController;
        
        [self decorateCameraController:cameraController];
        [self animateCameraController:cameraController];
        
        [cameraController startCameraCapture];
    }
}

- (void)decorateCameraController:(MPDCustomCameraViewController *)cameraController
{
    CGFloat viewSize = 256.0f;
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, viewSize, viewSize)
                                                cornerRadius:viewSize*0.5].CGPath;
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    
    cameraController.view.layer.mask = maskLayer;
    
    CAShapeLayer *cornerCircle = [CAShapeLayer layer];
    
    cornerCircle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, viewSize, viewSize)
                                                   cornerRadius:viewSize*0.5].CGPath;
    cornerCircle.fillColor = [UIColor clearColor].CGColor;
    cornerCircle.strokeColor = [UIColor whiteColor].CGColor;
    cornerCircle.lineWidth = 2.0f;
    
    [cameraController.view.layer addSublayer:cornerCircle];
}

- (void)animateCameraController:(MPDCustomCameraViewController *)cameraController
{
    UIView *cameraView = cameraController.view;
    
    const CGFloat initialScale = 0.0001;
    const CGFloat halfAnimationScale = 1.4;
    const CGFloat endAnimationScale = 1.0;
    
    const CGFloat animationDuration = 0.4f;
    
    cameraView.alpha = 0.0f;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       
                       cameraView.transform = CGAffineTransformMakeScale(initialScale, initialScale);
                       
                       [UIView animateWithDuration:animationDuration
                                             delay:0.0
                            usingSpringWithDamping:0.5
                             initialSpringVelocity:0.0
                                           options:UIViewAnimationOptionAllowUserInteraction
                                        animations:^{
                                            
                                            cameraView.alpha = 1.0f;
                                            cameraView.transform = CGAffineTransformMakeScale(halfAnimationScale, halfAnimationScale);
                                            
                                        } completion:^(BOOL finished) {
                                            
                                            [UIView animateWithDuration:animationDuration
                                                                  delay:0.0
                                                 usingSpringWithDamping:0.5
                                                  initialSpringVelocity:0.0
                                                                options:UIViewAnimationOptionAllowUserInteraction
                                                             animations:^{
                                                                 
                                                                 cameraView.transform = CGAffineTransformMakeScale(endAnimationScale, endAnimationScale);
                                                                 
                                                             } completion:^(BOOL finished) {
                                                                 
                                                             }];
                                        }];
                   });
}

@end
