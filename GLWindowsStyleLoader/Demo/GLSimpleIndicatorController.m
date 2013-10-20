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
@property (nonatomic, assign)BOOL startAnim;
@property (nonatomic, strong)GLWindowsStyleLoader *loadingView;
@end

@implementation GLSimpleIndicatorController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.animBtn setTitle:@"Start Animation" forState:UIControlStateNormal];
    self.startAnim = YES;

    self.loadingView = [[GLWindowsStyleLoader alloc] init];
    self.loadingView.dotSize = 6;
    self.loadingView.frame = CGRectMake(0, (self.view.frame.size.height - 30) / 2, self.view.frame.size.width, 30);
    self.loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.loadingView];
}

- (IBAction)toggleAnimation:(id)sender {
    if (self.startAnim) {
        [self.animBtn setTitle:@"Stop Animation" forState:UIControlStateNormal];
        [self.loadingView startAnimating];
    } else {
        [self.animBtn setTitle:@"Start Animation" forState:UIControlStateNormal];
        [self.loadingView stopAnimating];
    }
    
    self.startAnim = !self.startAnim;
}

@end
