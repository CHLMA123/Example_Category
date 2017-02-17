//
//  ViewController.m
//  UITextField
//
//  Created by MCL on 15/12/2.
//  Copyright © 2015年 MCL. All rights reserved.
//

#import "GestureRecognizerController.h"

typedef NS_ENUM(NSInteger, ImageMoveDirection) {
    
    kImageMoveDirectionNone,
    kImageMoveDirectionUp,
    kImageMoveDirectionDown,
    kImageMoveDirectionRight,
    kImageMoveDirectionLeft
};

@interface GestureRecognizerController ()<UIGestureRecognizerDelegate>
{
    ImageMoveDirection direction;
    UIImageView *imageView2;
}
@end

CGFloat const gestureMinimumTranslation = 20.0 ;

@implementation GestureRecognizerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpView];
}

- (void)setUpView {
    
    self.title = @"UIGestureRecognizer";
    //-------------------------------给view添加一个手势监测；-------------------------
    // set up the image view
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
    [imageView setBounds:CGRectMake(0.0, 0.0, 146.0, 98.0)];
    [imageView setCenter:self.view.center];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    // 单击的 Recognizer
    UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    //给imageView添加一个手势监测；
    [imageView addGestureRecognizer:singleRecognizer];
    
    // 双击的 Recognizer
    UITapGestureRecognizer* doubleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DoubleTap:)];
    doubleRecognizer.numberOfTapsRequired = 2; // 双击
    //给imageView添加一个手势监测；
    [imageView addGestureRecognizer:doubleRecognizer];
    
    // 关键在这一行，双击手势确定监测失败才会触发单击手势的相应操作
    [singleRecognizer requireGestureRecognizerToFail:doubleRecognizer];
    
    // create and configure the pinch gesture
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureDetected:)];
    [pinchGestureRecognizer setDelegate:self];
    [imageView addGestureRecognizer:pinchGestureRecognizer];
    
    // create and configure the rotation gesture
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureDetected:)];
    [rotationGestureRecognizer setDelegate:self];
    [imageView addGestureRecognizer:rotationGestureRecognizer];
    
    // creat and configure the pan gesture
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDetected:)];
    [panGestureRecognizer setDelegate:self];
    [imageView addGestureRecognizer:panGestureRecognizer];
    
    imageView2 =[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height-190, 118.0, 118.0)];
    imageView2.image = [UIImage imageNamed:@"Default"];
    imageView2.userInteractionEnabled = YES;
    [self.view addSubview:imageView2];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [imageView2 addGestureRecognizer:recognizer];
}

#pragma mark -UIPanGestureRecognizer -handleSwipe:
- ( void )handleSwipe:( UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView: imageView2];
    if (recognizer.state == UIGestureRecognizerStateBegan )
    {
        direction = kImageMoveDirectionNone
        ;
    }
    
    else if (recognizer.state == UIGestureRecognizerStateChanged && direction == kImageMoveDirectionNone)
    {
        direction = [ self determineImageDirectionIfNeeded:translation];
        switch (direction) {
            case kImageMoveDirectionDown:
                
                NSLog (@ "Start moving down" );
                break ;
                
            case kImageMoveDirectionUp:
                
                NSLog (@ "Start moving up" );
                break ;
                
            case kImageMoveDirectionRight:
                
                NSLog (@ "Start moving right" );
                break ;
                
            case kImageMoveDirectionLeft:
                
                NSLog (@ "Start moving left" );
                break ;
                
            default :
                break ;
                
        }
    }
    
    else if (recognizer.state == UIGestureRecognizerStateEnded )
        
    {
        NSLog (@ "Stop" );
    }
}

- ( ImageMoveDirection )determineImageDirectionIfNeeded:( CGPoint )translation

{
    if (direction != kImageMoveDirectionNone)
        return direction;
    
    if (fabs(translation.x) > gestureMinimumTranslation)
        
    {
        BOOL gestureHorizontal = NO;
        
        if (translation.y == 0.0 )
            gestureHorizontal = YES;
        else
            gestureHorizontal = (fabs(translation.x / translation.y) > 5.0 );
        
        if (gestureHorizontal)
            
        {
            if (translation.x > 0.0 )
                return kImageMoveDirectionRight;
            else
                return kImageMoveDirectionLeft;
        }
    }
    
    else if (fabs(translation.y) > gestureMinimumTranslation)
    {
        BOOL gestureVertical = NO;
        
        if (translation.x == 0.0 )
            gestureVertical = YES;
        else
            gestureVertical = (fabs(translation.y / translation.x) > 5.0 );
        
        if (gestureVertical)
            
        {
            if (translation.y > 0.0 )
                return kImageMoveDirectionDown;
            else
                return kImageMoveDirectionUp;
        }
    }
    return direction;
}

- (void)pinchGestureDetected:(UIPinchGestureRecognizer *)recognizer
{
    NSLog(@"______________ pinchGestureDetected _______________");
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGFloat scale = [recognizer scale];
        [recognizer.view setTransform:CGAffineTransformScale(recognizer.view.transform, scale, scale)];
        [recognizer setScale:1.0];
    }
}

- (void)rotationGestureDetected:(UIRotationGestureRecognizer *)recognizer
{
    NSLog(@"______________ rotationGestureDetected _______________");
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGFloat rotation = [recognizer rotation];
        [recognizer.view setTransform:CGAffineTransformRotate(recognizer.view.transform, rotation)];
        [recognizer setRotation:0];
    }
}

- (void)panGestureDetected:(UIPanGestureRecognizer *)recognizer
{
    NSLog(@"______________ panGestureDetected _______________");
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        [recognizer.view setTransform:CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y)];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    }
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    //处理单击操作
    NSLog(@"______________ 处理单击操作 _______________");
}

-(void)DoubleTap:(UITapGestureRecognizer*)recognizer
{
    //处理双击操作
    NSLog(@"______________ 处理双击操作 _______________");
}

#pragma UIGestureRecognizerDelegate

// called when a gesture recognizer attempts to transition out of UIGestureRecognizerStatePossible. returning NO causes it to transition to UIGestureRecognizerStateFailed
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

// called when the recognition of one of gestureRecognizer or otherGestureRecognizer would be blocked by the other
// return YES to allow both to recognize simultaneously. the default implementation returns NO (by default no two gestures can be recognized simultaneously)
//
// note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{

// called once per attempt to recognize, so failure requirements can be determined lazily and may be set up between recognizers across view hierarchies
// return YES to set up a dynamic failure requirement between gestureRecognizer and otherGestureRecognizer
//
// note: returning YES is guaranteed to set up the failure requirement. returning NO does not guarantee that there will not be a failure requirement as the other gesture's counterpart delegate or subclass methods may return YES
    
    return YES;
    
}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0);
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0);
//
//// called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the gesture recognizer from seeing this touch
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
