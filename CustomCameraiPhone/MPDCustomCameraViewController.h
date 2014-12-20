//
//  MPDCustomCameraViewController.h
//  CustomCameraiPhone
//
//  Created by Marcin Pędzimąż on 20.12.2014.
//  Copyright (c) 2014 Marcin Pedzimaz. All rights reserved.
//

@interface MPDCustomCameraViewController : GLKViewController

@property(nonatomic) CGFloat saturation;

- (void)startCameraCapture;
- (void)stopCameraCapture;

@end
