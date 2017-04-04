//
//  FrameProcessor.h
//  iosLaneFinder
//
//  Created by James Hulley on 4/2/17.
//  Copyright © 2017 James Hulley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoSource.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
#endif

@interface FrameProcessor : NSObject<VideoSourceDelegate>

- (void)processFrame:(cv::Mat &)frame;

@end

