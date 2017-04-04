//
//  OpenCVWrapper.m
//  iosLaneFinder
//
//  Created by James Hulley on 3/30/17.
//  Copyright © 2017 James Hulley. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import "OpenCVWrapper.h"
#import "FrameProcessor.h"
#import "LaneDetector.h"
#import "VideoSource.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
#endif

using namespace cv;
using namespace std;

@interface OpenCVWrapper ()
@property(nonatomic, strong)LaneDetector *laneDetector;
@property(nonatomic, strong)VideoSource *videoSource;
@end

@implementation OpenCVWrapper : NSObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        _laneDetector = [[LaneDetector alloc] init];
        _videoSource = [[VideoSource alloc] init];
        _videoSource.delegate = _laneDetector;
    }
    return self;
}

- (void)setTargetView:(UIView *)view {
    self.videoSource.targetView = view;
}

- (void)start {
    [self.videoSource start];
}

@end
