//
//  GLWindowsStyleLoader.m
//  GLWindowsStyleLoader
//
//  Created by Gautam Lodhiya on 10/09/13.
//  Copyright (c) 2013 Gautam Lodhiya. All rights reserved.
//

#import "GLWindowsStyleLoader.h"


@interface Dot : UIView
@property (nonatomic, assign)CGFloat translateX;
@property (nonatomic, assign)CFTimeInterval animationDuration;
- (void)setLayerProperties;
- (void)attachAnimations;
@end

@implementation Dot

+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (void)setLayerProperties
{
    CAShapeLayer *layer = (CAShapeLayer *)self.layer;
    layer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    layer.fillColor = [UIColor colorWithRed: 0.31 green: 0.631 blue: 0.698 alpha: 1].CGColor;
}

- (void)attachAnimations
{
    [self attachPathAnimation];
}

- (void)attachPathAnimation
{
    CGMutablePathRef linearPath = CGPathCreateMutable();
    CGPathMoveToPoint(linearPath, NULL, self.frame.origin.x, self.frame.origin.y);
    CGPathAddLineToPoint(linearPath, NULL, self.translateX, self.frame.origin.y);
    
    CAKeyframeAnimation *pacedAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pacedAnimation.duration = self.animationDuration;
    pacedAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.15f :0.60f :0.85f :0.4f];
    [pacedAnimation setCalculationMode:kCAAnimationPaced];
    pacedAnimation.path = linearPath;
    pacedAnimation.repeatCount = HUGE_VALF;
    [self.layer addAnimation:pacedAnimation forKey:pacedAnimation.keyPath];
    
    CGPathRelease(linearPath);
}

@end






static int stage = 0;

@interface GLWindowsStyleLoader() {
    BOOL isAnimating;
    int maxDots;
}

@property (nonatomic, strong)NSTimer *timer;

@end


@implementation GLWindowsStyleLoader

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self commonInit];
    }
    return self;
}

#pragma mark - Cleanup methods

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - Custom methods

- (void)commonInit
{
    isAnimating = NO;
    maxDots = 5;
    self.dotSize = 4;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (isAnimating)
    {
        [self stopAnimating];
        [self startAnimating];
    }
}

- (void)startAnimating
{
    if (!isAnimating) {
        isAnimating = YES;
        stage = 0;
        
        if (!self.timer.isValid) {
            //self.timer =[NSTimer timerWithTimeInterval:0.20 target:self selector:@selector(addMore) userInfo:nil repeats:YES];
            //[[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
            self.timer = [NSTimer scheduledTimerWithTimeInterval: 0.20 target: self
                                                        selector: @selector(addMore) userInfo: nil repeats: YES];
        }
        
        self.hidden = NO;
    }
}

- (void)stopAnimating
{
    isAnimating = NO;
    for (UIView *v in self.subviews){
        [v removeFromSuperview];
    }
    
    self.hidden = YES;
    [self.timer invalidate];
}

- (BOOL)isAnimating
{
    return isAnimating;
}

- (void)addMore
{
    if (stage < maxDots) {
        stage++;
        
        Dot *dotView = [[Dot alloc] initWithFrame:CGRectMake(0, self.frame.size.height / 2, self.dotSize, self.dotSize)];
        dotView.animationDuration = 1.5;
        dotView.translateX = self.frame.size.width;
        [dotView setLayerProperties];
        [self addSubview:dotView];
        
        [dotView attachAnimations];
        
    } else {
        [self.timer invalidate];
    }
}


@end
