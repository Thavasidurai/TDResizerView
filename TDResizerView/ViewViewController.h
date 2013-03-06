//
//  ViewViewController.h
//  TDResizerView
//
//  Created by Thavasidurai N on 19/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewViewController : UIViewController
{
    UIView *testVw;
    
    UIImageView *resizeVw;
    UIImageView *imgvw;
    UIImageView *rotateVw;
    UIImageView *closeVw;
    
    float deltaAngle;
    CGPoint prevPoint;
    CGAffineTransform startTransform;

}

@end
