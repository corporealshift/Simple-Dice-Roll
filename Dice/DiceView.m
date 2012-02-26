//
//  DiceView.m
//  Dice
//
//  Created by Kyle Diedrick on 2/21/12.
//  Copyright (c) 2012 Graphics Unplugged. All rights reserved.
//

#import "DiceView.h"
#import <QuartzCore/QuartzCore.h>

@interface DiceView ()

- (void)drawTopLeftDotInFrame:(CGRect)rect;
- (void)drawTopRightDotInFrame:(CGRect)rect;
- (void)drawBottomLeftDotInFrame:(CGRect)rect;
- (void)drawBottomRightDotInFrame:(CGRect)rect;
- (void)drawCenterDotInFrame:(CGRect)rect;
- (void)drawCenterLeftDotInFrame:(CGRect)rect;
- (void)drawCenterRightDotInFrame:(CGRect)rect;

- (void)drawDieInRect:(CGRect)rect;

@end

@implementation DiceView

@synthesize dieValue = _dieValue;

/**
 *  Custom version of initWithFrame. Takes the value of 
 *  the die on initialization
 *  @param frame The rectangle to use to draw this die
 *  @param value The value of this die (1-6)
 */
- (id)initWithFrame:(CGRect)frame andValue:(NSInteger)value
{
    self = [super initWithFrame:frame];
    if (self) {
        // Ensure the value of the die is in range or force it to be.
        if( value > 6 ) {
            value = 6;
        } else if( value < 1 ) {
            value = 1;
        }
        self.dieValue = value;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{    
    // Get the drawing reference context

    CGRect frame = self.bounds;
    
    // Draw the border of the die
    UIBezierPath *border = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:5.0];
    
    [[[UIColor alloc] initWithRed:0.1 green:0.5 blue:0.8 alpha:1] setFill];
    [border fill];
    
    // Make the frame to fill a little bit smaller, then draw a white 
    // rectangle. This draws the die's face
    frame.size.width = frame.size.width - 3;
    frame.size.height = frame.size.height - 3;
    frame.origin.x = frame.origin.x + 1.5;
    frame.origin.y = frame.origin.y + 1.5;
    
    UIBezierPath *background = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:5.0];
    
    [[UIColor whiteColor] setFill];
    [background fill];
    
    // Draw the die with the value it has in the provided rectangle
    [self drawDieInRect:rect];
    
}

/**
 *  Spins a die for the provided rotation. 
 *  @param duration The duration in seconds to spin the die
 */
- (void)spinThisDieFor:(float)duration
{
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    rotate.fromValue = [NSNumber numberWithFloat:0];
    
    rotate.toValue = [NSNumber numberWithFloat:M_PI * 5];
    
    rotate.duration = duration; // seconds
    
    [self.layer addAnimation:rotate forKey:nil]; // "key" is optional
}

/**
 *  Draws the dots that represent the value for this die
 *  @param The rectangle to use to draw this die
 */
- (void)drawDieInRect:(CGRect)rect
{
    switch (self.dieValue) {
        case 1:
            [self drawCenterDotInFrame:rect];
            break;
        case 2:
            [self drawTopLeftDotInFrame:rect];
            [self drawBottomRightDotInFrame:rect];
            break;
        case 3:
            [self drawTopLeftDotInFrame:rect];
            [self drawCenterDotInFrame:rect];
            [self drawBottomRightDotInFrame:rect];
            break;
        case 4:
            [self drawTopLeftDotInFrame:rect];
            [self drawTopRightDotInFrame:rect];
            [self drawBottomLeftDotInFrame:rect];
            [self drawBottomRightDotInFrame:rect];
            break;
        case 5:
            [self drawTopLeftDotInFrame:rect];
            [self drawTopRightDotInFrame:rect];
            [self drawBottomLeftDotInFrame:rect];
            [self drawBottomRightDotInFrame:rect];
            [self drawCenterDotInFrame:rect];
            break;
        case 6:
            [self drawTopLeftDotInFrame:rect];
            [self drawTopRightDotInFrame:rect];
            [self drawBottomLeftDotInFrame:rect];
            [self drawBottomRightDotInFrame:rect];
            [self drawCenterLeftDotInFrame:rect];
            [self drawCenterRightDotInFrame:rect];
            break;
        default:
            break;
    }
}

/**
 *  Draws a dot at the top left position for the die
 */
- (void)drawTopLeftDotInFrame:(CGRect)rect
{
    CGRect dotFrame = CGRectMake(rect.size.width / 7, rect.size.height / 7, rect.size.width / 7, rect.size.height / 7);
    
    UIBezierPath *dot = [UIBezierPath bezierPathWithRoundedRect:dotFrame cornerRadius:5];
    [[UIColor blackColor] setFill];
    [dot fill];
}

/**
 *  Draws a dot at the top right position for the die
 */
- (void)drawTopRightDotInFrame:(CGRect)rect
{
    CGRect dotFrame = CGRectMake(rect.size.width - (rect.size.width / 7) * 2, rect.size.height / 7, rect.size.width / 7, rect.size.height / 7);
    
    UIBezierPath *dot = [UIBezierPath bezierPathWithRoundedRect:dotFrame cornerRadius:5];
    [[UIColor blackColor] setFill];
    [dot fill];
}

/**
 *  Draws a dot at the bottom left position for the die
 */
- (void)drawBottomLeftDotInFrame:(CGRect)rect
{
    CGRect dotFrame = CGRectMake(rect.size.width / 7, rect.size.width - (rect.size.width / 7) * 2, rect.size.width / 7, rect.size.height / 7);
    
    UIBezierPath *dot = [UIBezierPath bezierPathWithRoundedRect:dotFrame cornerRadius:5];
    [[UIColor blackColor] setFill];
    [dot fill];
}

/**
 *  Draws a dot at the bottom right position for the die
 */
- (void)drawBottomRightDotInFrame:(CGRect)rect
{
    float positionValue = rect.size.width - (rect.size.width / 7) * 2;
    
    CGRect dotFrame = CGRectMake(positionValue, positionValue, rect.size.width / 7, rect.size.height / 7);
    
    UIBezierPath *dot = [UIBezierPath bezierPathWithRoundedRect:dotFrame cornerRadius:5];
    [[UIColor blackColor] setFill];
    [dot fill];
}

/**
 *  Draws a dot at the center position for the die
 */
- (void)drawCenterDotInFrame:(CGRect)rect
{
    float leftPosition = (rect.size.width / 2) - ((rect.size.width / 7) / 2);
    float verticalPosition = (rect.size.height / 2) - ((rect.size.height / 7) / 2);
    
    CGRect dotFrame = CGRectMake(leftPosition, verticalPosition, rect.size.width / 7, rect.size.height / 7);
    
    UIBezierPath *dot = [UIBezierPath bezierPathWithRoundedRect:dotFrame cornerRadius:5];
    [[UIColor blackColor] setFill];
    [dot fill];
}

/**
 *  Draws a dot at the center left position for the die
 */
- (void)drawCenterLeftDotInFrame:(CGRect)rect
{
    float verticalPosition = (rect.size.height / 2) - ((rect.size.height / 7) / 2);
    
    CGRect dotFrame = CGRectMake(rect.size.width / 7, verticalPosition, rect.size.width / 7, rect.size.height / 7);
    
    UIBezierPath *dot = [UIBezierPath bezierPathWithRoundedRect:dotFrame cornerRadius:5];
    [[UIColor blackColor] setFill];
    [dot fill];
}

/**
 *  Draws a dot at the center right position for the die
 */
- (void)drawCenterRightDotInFrame:(CGRect)rect
{
    float verticalPosition = (rect.size.height / 2) - ((rect.size.height / 7) / 2);
    float xPosition = rect.size.width - (rect.size.width / 7) * 2;
    
    CGRect dotFrame = CGRectMake(xPosition, verticalPosition, rect.size.width / 7, rect.size.height / 7);
    
    UIBezierPath *dot = [UIBezierPath bezierPathWithRoundedRect:dotFrame cornerRadius:5];
    [[UIColor blackColor] setFill];
    [dot fill];
}


@end
