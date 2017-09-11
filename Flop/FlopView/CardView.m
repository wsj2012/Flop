//
//  CardView.m
//  Flop
//
//  Created by wsj_2012 on 2017/9/11.
//
//

#import "CardView.h"

@implementation CardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self.bgImageView setImage:[UIImage imageNamed:@"sign_card_back"]];
    [self addSubview:self.bgImageView];
}

- (void)prepareWithImageName:(NSString *)imageName {
    [self.bgImageView setImage:nil];
    self.backgroundColor = [UIColor orangeColor];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

#pragma mark - getter

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.layer.cornerRadius = 3.0f;
        _bgImageView.clipsToBounds = YES;
        _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

@end
