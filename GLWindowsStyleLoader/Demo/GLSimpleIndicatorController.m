//
//  GLViewController.m
//  GLWindowsStyleLoader
//
//  Created by Gautam Lodhiya on 10/09/13.
//  Copyright (c) 2013 Gautam Lodhiya. All rights reserved.
//

#import "GLSimpleIndicatorController.h"
#import "GLWindowsStyleLoader.h"

@interface GLSimpleIndicatorController ()
@property (nonatomic, strong)GLWindowsStyleLoader *loadingView;
@end

@implementation GLSimpleIndicatorController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.loadingView = [[GLWindowsStyleLoader alloc] init];
    self.loadingView.dotSize = 6;
    self.loadingView.frame = CGRectMake(0, (self.view.frame.size.height - 30) / 2, self.view.frame.size.width, 30);
    self.loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.loadingView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAnimation:(id)sender {
    [self.loadingView startAnimating];
}

- (IBAction)stopAnimation:(id)sender {
    [self.loadingView stopAnimating];
}
@end
