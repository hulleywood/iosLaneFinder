//
//  LaneDetector.h
//  iosLaneFinder
//
//  Created by James Hulley on 4/3/17.
//  Copyright © 2017 James Hulley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoSource.h"
#import "Eigen/Dense"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
#endif

@interface LaneDetector : NSObject<VideoSourceDelegate>
{
    
    double leftLaneOrigin;
    int leftFrameGap;
    double leftCurveRad;
    bool leftReset;
    NSMutableArray *leftLastNX;
    NSMutableArray *leftSmoothX;
    NSMutableArray *leftPolyFit;
    
    double rightLaneOrigin;
    int rightFrameGap;
    double rightCurveRad;
    bool rightReset;
    NSMutableArray *rightLastNX;
    NSMutableArray *rightSmoothX;
    NSMutableArray *rightPolyFit;
    
}

- (void)resetForSide:(NSString*)side;
- (void)processFrame:(cv::Mat &)frame;
- (void)lanePixels:(cv::Mat &)frame;
- (cv::Mat)colorPixels:(cv::Mat &)frame;
- (cv::Mat)linePixels:(cv::Mat &)frame;

@end


//self.img_shape = img.shape
//self.M, self.Minv = self.transpose_matrices(self.img_shape)
//self.y_vals = np.array(range(self.img_shape[0]))[::-1]
//self.ym_per_pix = 30/self.img_shape[0] # meters per pixel in y dimension
//self.xm_per_pix = 3.7/(self.img_shape[1]*.55) # meteres per pixel in x dimension

//self.image_variables_set = True
//self.reset_left = False
//self.reset_right = False
