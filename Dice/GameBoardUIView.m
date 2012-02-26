//
//  GameBoardUIView.m
//  Dice
//
//  Created by Kyle Diedrick on 2/24/12.
//  Copyright (c) 2012 Graphics Unplugged. All rights reserved.
//

#import "GameBoardUIView.h"

@implementation GameBoardUIView

/**
 *  While this view does not do much currently, it has been created to make 
 *  modification of the game board view easier if so desired
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Set the background color to black
        [self setBackgroundColor:[UIColor blackColor]];
        
        // Create the label for the background
        CGRect labelArea = CGRectMake(20, 300, 280, 40);
        UILabel *explanationLabel = [[UILabel alloc] initWithFrame:labelArea];
        explanationLabel.text = @"Shake the phone to roll the dice";
        explanationLabel.textAlignment = UITextAlignmentCenter;
        explanationLabel.textColor = [UIColor darkGrayColor];
        
        [explanationLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:explanationLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
