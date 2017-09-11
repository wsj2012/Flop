//
//  ViewController.m
//  Flop
//
//  Created by wsj_2012 on 2017/9/11.
//
//

#import "ViewController.h"

#import "FlopView.h"

@interface ViewController ()

@property (nonatomic, strong) FlopView *flopView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *eventButton = [UIButton buttonWithType:UIButtonTypeSystem];
    eventButton.frame = CGRectMake(0, 0, 100, 40);
    eventButton.backgroundColor = [UIColor redColor];
    eventButton.center = self.view.center;
    eventButton.layer.cornerRadius = 3;
    [eventButton addTarget:self action:@selector(showFlopView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eventButton];
}

- (void)showFlopView {
    [self.view addSubview:self.flopView];
}

- (FlopView *)flopView {
    if (!_flopView) {
        _flopView = [FlopView new];
    }
    return _flopView;
}


@end
