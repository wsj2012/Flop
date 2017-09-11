//
//  CardView.h
//  Flop
//
//  Created by wsj_2012 on 2017/9/11.
//
//

#import <UIKit/UIKit.h>

@interface CardView : UIView

@property (nonatomic, assign) CGPoint originCenter;
@property (nonatomic, strong) UIImageView *bgImageView;

- (void)prepareWithImageName:(NSString *)imageName;

@end
