//
//  GLWindowsStyleLoader.h
//  GLWindowsStyleLoader
//
//  Created by Gautam Lodhiya on 10/09/13.
//  Copyright (c) 2013 Gautam Lodhiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLWindowsStyleLoader : UIView
@property (nonatomic, assign)CGFloat dotSize;
- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;
@end
