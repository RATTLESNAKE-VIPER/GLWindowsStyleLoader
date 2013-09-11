//
//  GLModalController.m
//  GLWindowsStyleLoader
//
//  Created by Gautam Lodhiya on 11/09/13.
//  Copyright (c) 2013 Gautam Lodhiya. All rights reserved.
//

#import "GLModalController.h"
#import "GLWindowsStyleLoader.h"

@interface GLModalController ()
@property (nonatomic, strong)GLWindowsStyleLoader *loadingView;
@end

@implementation GLModalController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)dealloc
{
    [self hidePanel];
    self.loadingView = nil;
}

#pragma mark - Custom methods

- (GLWindowsStyleLoader *)loadingView
{
    if (!_loadingView) {
        _loadingView = [[GLWindowsStyleLoader alloc] init];
        _loadingView.backgroundColor = [UIColor blackColor];
        _loadingView.dotSize = 4;
        _loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    return _loadingView;
}

- (void)showInView:(UIView *)view
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    [self.loadingView.layer addAnimation:transition forKey:nil];
    
    self.loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50);
    [self.view addSubview:self.loadingView];
    [self.loadingView startAnimating];
}

-(void)hidePanel {
    [self.loadingView stopAnimating];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    CATransition *transition = [CATransition animation];
	transition.duration = 0.25;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;
	transition.subtype = kCATransitionFromTop;
	[self.loadingView.layer addAnimation:transition forKey:nil];
    self.loadingView.frame = CGRectMake(0, -self.loadingView.frame.size.height, self.loadingView.frame.size.width, self.loadingView.frame.size.height);
    
    [self.loadingView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.25];
}

- (IBAction)showPanel:(id)sender {
    [self showInView:self.view];
    
    double delayInSeconds = 5.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self hidePanel];
    });
}

@end
