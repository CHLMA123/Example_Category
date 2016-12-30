//
//  LocationViewController.m
//  READMEKit
//
//  Created by MCL on 16/6/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong)CLLocationManager *locationManger;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 89, 290, 60);
    btn.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.25];
    [btn addTarget:self action:@selector(LocationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)LocationAction{
    
//    if ([CLLocationManager locationServicesEnabled]) {
//        
//        _locationManger = [[CLLocationManager alloc] init];
//        self.locationManger.delegate = self;
//    }else{
//        NSLog(@"没有权限，无法进行定位");
//    }
    _locationManger = [[CLLocationManager alloc] init];
    self.locationManger.delegate = self;
    if ([[UIDevice currentDevice].systemVersion floatValue] > 8.0) {
        [_locationManger requestAlwaysAuthorization];
    }
    [self.locationManger startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    CLLocationCoordinate2D cur = currentLocation.coordinate;
    NSLog(@"latitude: %f, longitude: %f", cur.latitude, cur.longitude);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count >0) {
            CLPlacemark *loc = [[CLPlacemark alloc] initWithPlacemark:placemarks[0]];
            NSString *name = loc.name; // eg. Apple Inc.
            NSLog(@"name: %@",name);
//            NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
//            NSDictionary *dic1 = @{  @"name":loc.name,
//                                    @"thoroughfare":loc.thoroughfare,
//                                    @"subThoroughfare":loc.subThoroughfare,
//                                    @"locality":loc.locality,
//                                    @"subLocality":loc.subLocality,
//                                    @"administrativeArea":loc.administrativeArea,
//                                    @"subAdministrativeArea":loc.subAdministrativeArea,
//                                    @"postalCode":loc.postalCode,
//                                    @"ISOcountryCode":loc.ISOcountryCode,
//                                    @"country":loc.country};
//            [mDic addEntriesFromDictionary:dic1];
//            NSLog(@"dic1 = %@ ",dic1);

        }
        
    }];
    [self.locationManger stopUpdatingLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
