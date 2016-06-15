//
//  ViewController_push.m
//  图层蒙版
//
//  Created by MCL on 16/6/7.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "ViewController_push.h"
#import "FLAnimatedImage.h"

@interface ViewController_push ()

@property (nonatomic, strong) FLAnimatedImageView *imageView1;
@property (nonatomic, strong) FLAnimatedImageView *imageView2;
@property (nonatomic, strong) FLAnimatedImageView *imageView3;

@end

@implementation ViewController_push

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated{
    // Setup the three `FLAnimatedImageView`s and load GIFs into them:
    // 1
    if (!self.imageView1) {
        self.imageView1 = [[FLAnimatedImageView alloc] init];
        self.imageView1.contentMode = UIViewContentModeScaleAspectFill;
        //UIViewContentModeScaleToFill 压缩填充
        self.imageView1.clipsToBounds = YES;
    }
    [self.view addSubview:self.imageView1];
    self.imageView1.frame = CGRectMake(5.0, 79.0, self.view.bounds.size.width-10, 100.0);
    
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"rock" withExtension:@"gif"];
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
    self.imageView1.animatedImage = animatedImage1;
    
    // 2
    if (!self.imageView2) {
        self.imageView2 = [[FLAnimatedImageView alloc] init];
        self.imageView2.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView2.clipsToBounds = YES;
    }
    [self.view addSubview:self.imageView2];
    self.imageView2.frame = CGRectMake(5.0, 190.0, self.view.bounds.size.width-10, 100.0);
    NSURL *url2 = [NSURL URLWithString:@"https://cloud.githubusercontent.com/assets/1567433/10417835/1c97e436-7052-11e5-8fb5-69373072a5a0.gif"];
    [self loadAnimatedImageWithURL:url2 completion:^(FLAnimatedImage *animatedImage) {
        self.imageView2.animatedImage = animatedImage;
    }];
    
    // 3
    if (!self.imageView3) {
        self.imageView3 = [[FLAnimatedImageView alloc] init];
        self.imageView3.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView3.clipsToBounds = YES;
    }
    [self.view addSubview:self.imageView3];
    self.imageView3.frame = CGRectMake(5.0, 300.0, self.view.bounds.size.width-10, 190.0);
    
    NSURL *url3 = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"];
    [self loadAnimatedImageWithURL:url3 completion:^(FLAnimatedImage *animatedImage) {
        self.imageView3.animatedImage = animatedImage;
    }];
    
    // ... that's it!
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// Even though NSURLCache *may* cache the results for remote images, it doesn't guarantee it.
/// Cache control headers or internal parts of NSURLCache's implementation may cause these images to become uncache.
/// Here we enfore strict disk caching so we're sure the images stay around.
- (void)loadAnimatedImageWithURL:(NSURL *const)url completion:(void (^)(FLAnimatedImage *animatedImage))completion
{
    NSString *const filename = url.lastPathComponent;
    NSString *const diskPath = [NSHomeDirectory() stringByAppendingPathComponent:filename];
    
    NSData * __block animatedImageData = [[NSFileManager defaultManager] contentsAtPath:diskPath];
    FLAnimatedImage * __block animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:animatedImageData];
    
    if (animatedImage) {
        if (completion) {
            completion(animatedImage);
        }
    } else {
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            animatedImageData = data;
            animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:animatedImageData];
            if (animatedImage) {
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(animatedImage);
                    });
                }
                [data writeToFile:diskPath atomically:YES];
            }
        }] resume];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
