//
//  GLTableController.m
//  GLWindowsStyleLoader
//
//  Created by Gautam Lodhiya on 10/09/13.
//  Copyright (c) 2013 Gautam Lodhiya. All rights reserved.
//

#import "GLTableController.h"
#import "SVPullToRefresh.h"
#import "GLWindowsStyleLoader.h"

@interface GLTableController ()
@property (nonatomic, strong)GLWindowsStyleLoader *loadingView;
@end

@implementation GLTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak GLTableController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        // prepend data to dataSource, insert cells at top of table view
        // call [tableView.pullToRefreshView stopAnimating] when done
        
        double delayInSeconds = 5.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        });
    }];
    
    
    self.loadingView = [[GLWindowsStyleLoader alloc] init];
    self.loadingView.dotSize = 5;
    self.loadingView.frame = CGRectMake(0, 0, self.tableView.pullToRefreshView.frame.size.width, 30);
    self.loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.tableView.pullToRefreshView setCustomView:self.loadingView forState:SVInfiniteScrollingStateLoading];
    
    
    [self addObserver:self forKeyPath:@"self.tableView.pullToRefreshView.state" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"self.tableView.pullToRefreshView.state"];
    self.loadingView = nil;
}

#pragma mark - Observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"self.tableView.pullToRefreshView.state"]) {
        if ([[change valueForKey:NSKeyValueChangeNewKey] integerValue] == SVInfiniteScrollingStateLoading) {
            [self.loadingView startAnimating];
        } else {
            [self.loadingView stopAnimating];
        }
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section %i", section];
}


@end
