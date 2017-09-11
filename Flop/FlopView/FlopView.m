//
//  FlopView.m
//  Flop
//
//  Created by wsj_2012 on 2017/9/11.
//
//

#import "FlopView.h"
#import "CardView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface FlopView()<CAAnimationDelegate>

@property (nonatomic, strong) NSMutableArray *cardViewArray;
@property (nonatomic, strong) UIView *popView;
@property (nonatomic, strong) CardView *tapView;
@property (nonatomic, assign) BOOL flag;
@property (nonatomic, strong) UIView *popBgView;
@property (nonatomic, assign) NSInteger clickTag;

@end

@implementation FlopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.flag = NO;
        [self initSubviews];
    }
    return self;
}

#pragma mark - private methods

- (void)initSubviews
{
    [self addSubview:self.popView];
    CGFloat width = (kScreenWidth - 68 - 32) / 3.0;
    NSInteger tag = 0;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            
            CardView *carView = [[CardView alloc] initWithFrame:CGRectMake(34 + j * (width + 16), self.center.y - 117 + i * (110 + 14), width, 110)];
            carView.tag = 1987 + tag;
            carView.originCenter = carView.center;
            [self addSubview:carView];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTaped:)];
            [carView addGestureRecognizer:tapGesture];
            tag++;
            [self.cardViewArray addObject:carView];
        }
    }
}

- (void)imageViewTaped:(UITapGestureRecognizer *)tap
{
    self.tapView =  (CardView *)tap.view;
    tap.view.hidden = YES;
    self.clickTag = tap.view.tag;
    [self addSubview:self.popBgView];
    self.tapView.center = self.tapView.originCenter;
    self.tapView.hidden = NO;
    [self.popBgView addSubview:self.tapView];
    [self animationToView:self.tapView];
    
}

- (void)animationToView:(CardView *)view
{
    [self bringSubviewToFront:self.popBgView];
    self.flag = !self.flag;
    
    CGPoint fromPoint = view.originCenter;
    if (!self.flag) {
        fromPoint = self.popBgView.center;
        view.userInteractionEnabled = NO;
    }
    
    CGPoint toPoint = self.popBgView.center;
    if (!self.flag) {
        toPoint = view.originCenter;
    }
    
    CGFloat _duration = 1;
    
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:-M_PI];
    rotationAnimation.toValue = [NSNumber numberWithFloat: 0];
    rotationAnimation.duration = _duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]; //缓入缓出
    
    CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint: fromPoint];
    animation.toValue = [NSValue valueWithCGPoint: toPoint];
    animation.duration = _duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat: self.flag ? 1.0 : 2.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:self.flag ? 2.0 : 1.0];
    scaleAnimation.duration = _duration;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = _duration;
    animationGroup.autoreverses = NO;
    animationGroup.repeatCount = 1;
    animationGroup.removedOnCompletion = NO;
    
    if (self.flag) {
        [animationGroup setAnimations:[NSArray arrayWithObjects:rotationAnimation, animation,scaleAnimation, nil]];
    }else {
        [animationGroup setAnimations:[NSArray arrayWithObjects:animation,scaleAnimation, nil]];
    }
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.delegate = self;
    [view.layer addAnimation:animationGroup forKey:@"animationGroup"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_duration/2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view prepareWithImageName:@"sign_card_positive"];
    });
    
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    self.popBgView.hidden = NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.flag) {
        self.tapView.transform = CGAffineTransformMakeScale(2, 2);
        self.tapView.center = self.center;
    }else {
        self.tapView.transform = CGAffineTransformMakeScale(1, 1);
        self.tapView.center = self.tapView.originCenter;
        [self addSubview:self.tapView];
        self.popBgView.hidden = YES;
        
        
        for (CardView *view in self.cardViewArray) {
            if (view.tag != self.clickTag) {
                [view prepareWithImageName:@"sign_card_positive"];
            }
        }
    }
}

#pragma mark - getter

- (UIView *)popView {
    if (!_popView) {
        _popView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 28, 338)];
        _popView.center = self.center;
        _popView.backgroundColor = [UIColor whiteColor];
        _popView.layer.cornerRadius = 6.0f;
    }
    return _popView;
    
}

- (NSMutableArray *)cardViewArray {
    if (!_cardViewArray) {
        _cardViewArray = [NSMutableArray array];
    }
    return _cardViewArray;
}

- (UIView *)popBgView {
    if (!_popBgView) {
        _popBgView = [[UIView alloc] initWithFrame:self.bounds];
        _popBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return _popBgView;
}

@end
