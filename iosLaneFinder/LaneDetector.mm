//
//  LaneDetector.mm
//  iosLaneFinder
//
//  Created by James Hulley on 4/3/17.
//  Copyright © 2017 James Hulley. All rights reserved.
//

#import "LaneDetector.h"

using namespace cv;

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
    
    [self lanePixels:frame];
    
}

- (Mat)colorPixels:(cv::Mat &)frame {
    
    Mat hsv, gray, yellowMask, yellowMasked, whiteMask, whiteMasked, dst;
    
    int thresholdType = 0; // THRESH_BINARY
    double maxVal = 255; // max pixel val is 255
    double thresholdVal = 0; // anything greater than 0
    
    Scalar lowerYellow(10, 100, 100);
    Scalar upperYellow(40, 255, 255);
    Scalar lowerWhite(0, 0, 190);
    Scalar upperWhite(180, 255, 255);
    
    cvtColor(frame, hsv, COLOR_BGR2HSV);
    cvtColor(frame, gray, COLOR_BGRA2GRAY);
    
    // mask yellow colors
    inRange(hsv, lowerYellow, upperYellow, yellowMask);
    gray.copyTo(yellowMasked, yellowMask);
    
    // mask white colors
    inRange(hsv, lowerWhite, upperWhite, whiteMask);
    gray.copyTo(whiteMasked, whiteMask);
    
    // if either masked image contains non-zero value, set to max and return
    bitwise_or(whiteMasked, yellowMasked, dst);
    threshold(dst, dst, thresholdVal, maxVal, thresholdType);
        
    return dst;
}

- (Mat)linePixels:(cv::Mat &)frame {
    
    Mat hls, sobelX, absSobelX, dst;
    Mat channels[3];
    int dx = 1;
    int dy = 0;
    int ddepth = CV_16S;
    int thresholdType = 0; // THRESH_BINARY
    double maxVal = 255; // max pixel val is 255
    double thresholdVal = 0; // anything greater than 0
    Scalar sxThreshold(10, 100);
    
    cvtColor(frame, hls, COLOR_BGR2HLS);
    split(hls, channels);
    Sobel(channels[1], sobelX, ddepth, dx, dy);
    convertScaleAbs(sobelX, sobelX);
    
    normalize(sobelX, sobelX, 0, 255, NORM_MINMAX, CV_8UC1);
    inRange(sobelX, sxThreshold[0], sxThreshold[1], dst);
    threshold(dst, dst, thresholdVal, maxVal, thresholdType);
    
    return dst;
}

- (void)lanePixels:(cv::Mat &)frame {
    
//    Mat colorPixels = [self colorPixels:frame];
    Mat linePixels = [self linePixels:frame];
    
//    colorPixels.copyTo(frame);
    linePixels.copyTo(frame);
}

@end
