//
//  DiceView.h
//  Dice
//
//  Created by Kyle Diedrick on 2/21/12.
//  Copyright (c) 2012 Graphics Unplugged. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiceView : UIView

@property NSInteger dieValue;

- (id)initWithFrame:(CGRect)frame andValue:(NSInteger)value;

- (void)spinThisDieFor:(float)duration;

@end
