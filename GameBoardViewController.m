//
//  GameBoardViewController.m
//  Dice
//
//  Created by Kyle Diedrick on 2/21/12.
//  Copyright (c) 2012 Graphics Unplugged. All rights reserved.
//

#import "GameBoardViewController.h"
#import "DiceView.h"
#import "GameBoardUIView.h"
#import <QuartzCore/QuartzCore.h>

@interface GameBoardViewController()

@property (strong, nonatomic) NSArray *dice;
@property BOOL areDiceRolling;
@end

@implementation GameBoardViewController

@synthesize dice = _dice;
@synthesize areDiceRolling;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/**
 *  Since this ViewController does not use a nib file to create the view
 *  it must call loadView and create and set the view here. Just creates
 *  a simple view for the board (see GameBoardUIView.h)
 */
- (void)loadView
{
    CGRect boardFrame = CGRectMake(0, 0, 320, 460);
    GameBoardUIView *boardView = [[GameBoardUIView alloc] initWithFrame:boardFrame];
    [self setView:boardView];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create the dice for this view
    int randomValue = (int) 1 + arc4random() % 6;
    CGRect dieOneFrame = CGRectMake(10, 10, 80, 80);
    DiceView *dieOne = [[DiceView alloc] initWithFrame:dieOneFrame andValue:randomValue];
    
    CGRect dieTwoFrame = CGRectMake(115, 10, 80, 80);
    randomValue = (int) 1 + arc4random() % 6;
    DiceView *dieTwo = [[DiceView alloc] initWithFrame:dieTwoFrame andValue:randomValue];
    
    CGRect dieThreeFrame = CGRectMake(230, 10, 80, 80);
    randomValue = (int) 1 + arc4random() % 6;
    DiceView *dieThree = [[DiceView alloc] initWithFrame:dieThreeFrame andValue:randomValue];
    
    CGRect dieFourFrame = CGRectMake(10, 110, 80, 80);
    randomValue = (int) 1 + arc4random() % 6;
    DiceView *dieFour = [[DiceView alloc] initWithFrame:dieFourFrame andValue:randomValue];
    
    CGRect dieFiveFrame = CGRectMake(115, 110, 80, 80);
    randomValue = (int) 1 + arc4random() % 6;
    DiceView *dieFive = [[DiceView alloc] initWithFrame:dieFiveFrame andValue:randomValue];
    
    CGRect dieSixFrame = CGRectMake(230, 110, 80, 80);
    randomValue = (int) 1 + arc4random() % 6;
    DiceView *dieSix = [[DiceView alloc] initWithFrame:dieSixFrame andValue:randomValue];
    
    
    // Assign the dice as subviews to the main view for this ViewController
    [self.view addSubview:dieOne];
    [self.view addSubview:dieTwo];
    [self.view addSubview:dieThree];
    [self.view addSubview:dieFour];
    [self.view addSubview:dieFive];
    [self.view addSubview:dieSix];
    
    // Creates an array containing all of the dice
    self.dice = [[NSArray alloc] initWithObjects:dieOne, dieTwo, dieThree, dieFour, dieFive, dieSix, nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

/**
 *  Called when the view will appear. Tells this ViewController to become 
 *  the first responder for events.
 */
- (void) viewWillAppear:(BOOL)animated
{
    [self becomeFirstResponder];
    [super viewWillAppear:animated];
}

/**
 *  Called when the view will disappear. Resigns the 
 *  first responder for events.
 */
- (void) viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

/**
 *  Called when motion events have ended. Used to listen for shake events 
 *  and then to move the dice around the screen
 *  @param motion The motion event subtype
 *  @param event The motion event object
 */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if( event.subtype == UIEventSubtypeMotionShake && !self.areDiceRolling )
    {
        // Prevent dice from being rolled if they are already rolling
        self.areDiceRolling = YES;
        
        for (DiceView *die in self.dice) {
            // For each die lets find a random spot on the screen and move it there and then back
            CGPoint originalCenter = die.center;
            
            // Get a random spot on the bottom half of the screen
            int newX = 1 + arc4random() % 320;
            int newY = 200 + arc4random() % 280;
            
            // Animate each die out and once the animation is complete, animate 
            // it back to its original position
            [UIView animateWithDuration:0.75 
                                  delay:0 
                                options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^{ 
                                 
                                 // Spin the die 2.5x
                                 [die spinThisDieFor:0.75f];
                                 
                                 // After a 0.35 second delay call the function to change the die value
                                 [self performSelector:@selector(changeValueOf:) withObject:die afterDelay:0.35f];
                                 
                                 // Animate the die to the new randomly chosen position
                                 [die setCenter:CGPointMake(newX, newY)];
                                 
                             } 
                             completion:^(BOOL completion) {
                                 [UIView animateWithDuration:0.75 
                                                       delay:0 
                                                     options:UIViewAnimationOptionBeginFromCurrentState
                                                  animations:^{ 
                                                      
                                                      // Spin the die 2.5x
                                                      [die spinThisDieFor:0.75f];
                                                      
                                                      // After a 0.35 second delay call the function to change the die value
                                                      [self performSelector:@selector(changeValueOf:) withObject:die afterDelay:0.35f];
                                                      
                                                      // Return the die to its original position
                                                      [die setCenter:originalCenter];
                                                      
                                                      // Set property to allow dice to roll again
                                                      self.areDiceRolling = NO;
                                                      
                                                  } completion:nil];
                             }];
            
        }
        
    }
    
    // If super can also respond to this event send it up to the super
    if( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

/**
 *  Changes the value of a die and sets it to needs display
 *  which will trigger it to be redrawn
 *  @param die The die to change the value of
 */
- (void)changeValueOf:(DiceView *)die
{
    die.dieValue = 1 + arc4random() % 6;
    
    [die setNeedsDisplay];
}

/**
 *  This is needed to allow this ViewController to become the first 
 *  responder for shake events
 *  @return BOOL 
 */
- (BOOL)canBecomeFirstResponder
{ 
    return YES; 
}

/**
 *  Returns whether or not to rotate the view for different orientations
 *  Since the view is just pictures it is not rotated for this app.
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end