//
//  ViewViewController.m
//  TDResizerView
//
//  Created by Thavasidurai N on 19/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //In visible background view
    testVw = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    testVw.backgroundColor = [UIColor clearColor];
    [self.view addSubview:testVw];    
    
    //Content view
    imgvw = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, testVw.frame.size.width-24, testVw.frame.size.height-27)];
    imgvw.backgroundColor = [UIColor clearColor];
    imgvw.layer.borderColor = [[UIColor brownColor]CGColor];
    imgvw.layer.borderWidth = 2.0f;
    imgvw.image = [UIImage imageNamed:@"sampleImage.png" ];
    [testVw addSubview:imgvw];
    
    //Close button view which is in top left corner
    closeVw = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    closeVw.backgroundColor = [UIColor clearColor];
    closeVw.image = [UIImage imageNamed:@"close_gold.png" ];
    closeVw.userInteractionEnabled = YES;
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [closeVw addGestureRecognizer:singleTap];    
    
    [testVw addSubview:closeVw];
    
    //Resizing view which is in bottom right corner
    resizeVw = [[UIImageView alloc]initWithFrame:CGRectMake(testVw.frame.size.width-25, testVw.frame.size.height-25, 25, 25)];
    resizeVw.backgroundColor = [UIColor clearColor];
    resizeVw.userInteractionEnabled = YES;
    resizeVw.image = [UIImage imageNamed:@"button_02.png" ];
    
    [testVw addSubview:resizeVw];
    UIPanGestureRecognizer* panResizeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(resizeTranslate:)];
    [resizeVw addGestureRecognizer:panResizeGesture];
    
    //Rotating view which is in bottom left corner
    rotateVw = [[UIImageView alloc]initWithFrame:CGRectMake(0, testVw.frame.size.height-25, 25, 25)];
    rotateVw.backgroundColor = [UIColor clearColor];
    rotateVw.image = [UIImage imageNamed:@"button_01.png" ];
    rotateVw.userInteractionEnabled = YES;
    [testVw addSubview:rotateVw];
    
    UIPanGestureRecognizer * panRotateGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rotateViewPanGesture:)];
    [rotateVw addGestureRecognizer:panRotateGesture];    
    [panRotateGesture requireGestureRecognizerToFail:panResizeGesture]; 
}
-(void)singleTap:(UIPanGestureRecognizer *)recognizer
{
    UIView * close = (UIView *)[recognizer view];
    [close.superview removeFromSuperview];
    
}

-(void)resizeTranslate:(UIPanGestureRecognizer *)recognizer
{
    if ([recognizer state]== UIGestureRecognizerStateBegan) 
    {
        prevPoint = [recognizer locationInView:testVw.superview];
        [testVw setNeedsDisplay];
        
        
    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged)
    {
        if (testVw.bounds.size.width < 20)
        {
            
            testVw.bounds = CGRectMake(testVw.bounds.origin.x, testVw.bounds.origin.y, 20, testVw.bounds.size.height);
            imgvw.frame = CGRectMake(12, 12, testVw.bounds.size.width-24, testVw.bounds.size.height-27);
            resizeVw.frame =CGRectMake(testVw.bounds.size.width-25, testVw.bounds.size.height-25, 25, 25);
            rotateVw.frame = CGRectMake(0, testVw.bounds.size.height-25, 25, 25);
            closeVw.frame = CGRectMake(0, 0, 25, 25);
            
            
            
            
        }
        
        if(testVw.bounds.size.height < 20)
        {
            testVw.bounds = CGRectMake(testVw.bounds.origin.x, testVw.bounds.origin.y, testVw.bounds.size.width, 20);
            imgvw.frame = CGRectMake(12, 12, testVw.bounds.size.width-24, testVw.bounds.size.height-27);
            resizeVw.frame =CGRectMake(testVw.bounds.size.width-25, testVw.bounds.size.height-25, 25, 25);
            rotateVw.frame = CGRectMake(0, testVw.bounds.size.height-25, 25, 25);
            closeVw.frame = CGRectMake(0, 0, 25, 25);
            
            
        }
        
        CGPoint point = [recognizer locationInView:testVw.superview];
        float wChange = 0.0, hChange = 0.0;
        
        wChange = (point.x - prevPoint.x); //Slow down increment
        hChange = (point.y - prevPoint.y); //Slow down increment 
        
        
        testVw.bounds = CGRectMake(testVw.bounds.origin.x, testVw.bounds.origin.y, testVw.bounds.size.width + (wChange), testVw.bounds.size.height + (hChange));
        imgvw.frame = CGRectMake(12, 12, testVw.bounds.size.width-24, testVw.bounds.size.height-27);
        
        resizeVw.frame =CGRectMake(testVw.bounds.size.width-25, testVw.bounds.size.height-25, 25, 25);
        rotateVw.frame = CGRectMake(0, testVw.bounds.size.height-25, 25, 25);
        closeVw.frame = CGRectMake(0, 0, 25, 25);
        
        prevPoint = [recognizer locationInView:testVw.superview];
        
        [testVw setNeedsDisplay];
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
        
        prevPoint = [recognizer locationInView:testVw.superview];
        [testVw setNeedsDisplay];
    }
}
-(void)rotateViewPanGesture:(UIPanGestureRecognizer *)recognizer
{
    if ([recognizer state] == UIGestureRecognizerStateBegan) 
    {
        deltaAngle = atan2([recognizer locationInView:testVw].y-testVw.center.y, [recognizer locationInView:testVw].x-testVw.center.x);
        startTransform = testVw.transform;
    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged) 
    {
        float ang = atan2([recognizer locationInView:testVw.superview].y - testVw.center.y, [recognizer locationInView:testVw.superview].x - testVw.center.x);
        float angleDiff = deltaAngle - ang;
        testVw.transform = CGAffineTransformMakeRotation(-angleDiff);
        [testVw setNeedsDisplay];
    }
    else if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
        deltaAngle = atan2([recognizer locationInView:testVw].y-testVw.center.y, [recognizer locationInView:testVw].x-testVw.center.x);
        startTransform = testVw.transform;
        [testVw setNeedsDisplay];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
