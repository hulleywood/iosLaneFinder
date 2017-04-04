//
//  VideoSource.h
//  iosLaneFinder
//
//  Created by James Hulley on 4/2/17.
//  Copyright © 2017 James Hulley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
#endif

@protocol VideoSourceDelegate<NSObject>

- (void)processFrame:(cv::Mat &)frame;

@end

@interface VideoSource : NSObject

- (void)start;
- (void)stop;

@property(nonatomic, weak) id<VideoSourceDelegate> delegate;
@property(nonatomic, strong) UIView *targetView;

@end
