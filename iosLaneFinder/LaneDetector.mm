//
//  LaneDetector.mm
//  iosLaneFinder
//
//  Created by James Hulley on 4/3/17.
//  Copyright © 2017 James Hulley. All rights reserved.
//

#import "LaneDetector.h"

@implementation LaneDetector

- (instancetype)init
{
    self = [super init];
    
    [self resetForSide:@"left"];
    [self resetForSide:@"right"];
    
    return self;
}

- (void)resetForSide:(NSString*)side {
    
    if ([side  isEqual: @"left"]) {
        leftLaneOrigin = -1;
        leftFrameGap = 0;
        leftCurveRad = -1;
        leftReset = false;
        //    NSMutableArray *leftLastNX;
        //    NSMutableArray *leftSmoothX;
        //    NSMutableArray *leftPolyFit;
    } else if ([side  isEqual: @"right"]) {
        rightLaneOrigin = -1;
        rightFrameGap = 0;
        rightCurveRad = -1;
        rightReset = false;
        //    NSMutableArray *rightLastNX;
        //    NSMutableArray *rightSmoothX;
        //    NSMutableArray *rightPolyFit;
    }
    
}

- (void)processFrame:(cv::Mat &)frame {

    if (leftReset) {
        [self resetForSide:@"left"];
    }

    if (rightReset) {
       [self resetForSide:@"right"];
    }
    
    cv::cvtColor(frame, frame, cv::COLOR_BGRA2GRAY);
    
}

@end
