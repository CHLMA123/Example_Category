//
//  MyRuntimeViewController.m
//  Example_Category
//
//  Created by APP on 2017/2/13.
//  Copyright © 2017年 MCL. All rights reserved.
//

#import "MyRuntimeViewController.h"
#import "MyRuntimeClass.h"
#import <objc/runtime.h>

@interface MyRuntimeViewController ()

@end

@implementation MyRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MyRuntimeMethodTest";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self startTest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startTest{

    MyRuntimeClass *myClass = [[MyRuntimeClass alloc] init];
    unsigned int outCount = 0;
    
    Class cls = myClass.class;
    
    // 类名
    NSLog(@"class name: %s", class_getName(cls));
    
    NSLog(@"==========================================================");
    
    // 父类
    NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
    NSLog(@"==========================================================");
    
    // 是否是元类
    NSLog(@"MyClass is %@ a meta-class", (class_isMetaClass(cls) ? @"" : @"not"));
    NSLog(@"==========================================================");
    
    Class meta_class = objc_getMetaClass(class_getName(cls));
    NSLog(@"%s's meta-class is %s", class_getName(cls), class_getName(meta_class));
    NSLog(@"==========================================================");
    
    // 变量实例大小
    NSLog(@"instance size: %zu", class_getInstanceSize(cls));
    NSLog(@"==========================================================");
    
    // 成员变量
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i);
    }
    
    free(ivars);
    
    Ivar string = class_getInstanceVariable(cls, "_string");
    if (string != NULL) {
        NSLog(@"instace variable %s", ivar_getName(string));
    }
    
    NSLog(@"==========================================================");
    
    // 属性操作
    objc_property_t * properties = class_copyPropertyList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSLog(@"property's name: %s", property_getName(property));
    }
    
    free(properties);
    
    objc_property_t array = class_getProperty(cls, "array");
    if (array != NULL) {
        NSLog(@"property %s", property_getName(array));
    }
    
    NSLog(@"==========================================================");
    
    // 方法操作
    Method *methods = class_copyMethodList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSLog(@"method's signature: %s", method_getName(method));
    }
    
    free(methods);
    
    Method method1 = class_getInstanceMethod(cls, @selector(method1));
    if (method1 != NULL) {
        NSLog(@"method %s", method_getName(method1));
    }
    
    Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
    if (classMethod != NULL) {
        NSLog(@"class method : %s", method_getName(classMethod));
    }
    
    NSLog(@"MyClass is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
    
    IMP imp = class_getMethodImplementation(cls, @selector(method1));
    imp();
    
    NSLog(@"==========================================================");
    
    // 协议
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
    Protocol * protocol;
    for (int i = 0; i < outCount; i++) {
        protocol = protocols[i];
        NSLog(@"protocol name: %s", protocol_getName(protocol));
    }
    
    NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
    
    NSLog(@"==========================================================");
    
}
/**
 2017-02-13 11:31:24.239935 Example_Category[286:81938] Inter 16 Page
 2017-02-13 11:31:24.241604 Example_Category[286:81938] Ever_VC_Path : MyRuntimeViewController
 2017-02-13 11:31:24.241912 Example_Category[286:81938] class name: MyRuntimeClass
 2017-02-13 11:31:52.524707 Example_Category[286:81938] ==========================================================
 2017-02-13 11:31:55.438240 Example_Category[286:81938] super class name: NSObject
 2017-02-13 11:31:58.735784 Example_Category[286:81938] ==========================================================
 2017-02-13 11:32:13.228297 Example_Category[286:81938] MyClass is not a meta-class
 2017-02-13 11:32:18.868298 Example_Category[286:81938] ==========================================================
 2017-02-13 11:32:23.720562 Example_Category[286:81938] MyRuntimeClass's meta-class is MyRuntimeClass
 2017-02-13 11:32:34.284868 Example_Category[286:81938] ==========================================================
 2017-02-13 11:32:43.167723 Example_Category[286:81938] instance size: 24
 2017-02-13 11:32:48.699471 Example_Category[286:81938] ==========================================================
 2017-02-13 11:33:17.483575 Example_Category[286:81938] instance variable's name: _instance1 at index: 0
 2017-02-13 11:33:22.590553 Example_Category[286:81938] instance variable's name: _instance2 at index: 1
 2017-02-13 11:33:24.825566 Example_Category[286:81938] instance variable's name: _array at index: 2
 2017-02-13 11:33:28.905860 Example_Category[286:81938] instance variable's name: _string at index: 3
 2017-02-13 11:33:31.680250 Example_Category[286:81938] instance variable's name: _integer at index: 4
 2017-02-13 11:34:26.871688 Example_Category[286:81938] instace variable _string
 2017-02-13 11:34:29.109400 Example_Category[286:81938] ==========================================================
 2017-02-13 11:34:37.379220 Example_Category[286:81938] property's name: integer
 2017-02-13 11:34:38.600008 Example_Category[286:81938] property's name: array
 2017-02-13 11:34:39.429692 Example_Category[286:81938] property's name: string
 2017-02-13 11:34:41.304385 Example_Category[286:81938] property array
 2017-02-13 11:35:13.171209 Example_Category[286:81938] ==========================================================
 2017-02-13 11:35:21.646690 Example_Category[286:81938] method's signature: method1
 2017-02-13 11:35:25.247277 Example_Category[286:81938] method's signature: method3WithArg1:arg2:
 2017-02-13 11:35:26.403983 Example_Category[286:81938] method's signature: method2
 2017-02-13 11:35:27.761111 Example_Category[286:81938] method's signature: integer
 2017-02-13 11:35:30.247976 Example_Category[286:81938] method's signature: setInteger:
 2017-02-13 11:35:31.588333 Example_Category[286:81938] method's signature: .cxx_destruct
 2017-02-13 11:35:33.584419 Example_Category[286:81938] method's signature: array
 2017-02-13 11:35:34.951662 Example_Category[286:81938] method's signature: string
 2017-02-13 11:35:36.361837 Example_Category[286:81938] method's signature: setString:
 2017-02-13 11:35:37.615726 Example_Category[286:81938] method's signature: setArray:
 2017-02-13 11:35:39.761201 Example_Category[286:81938] method method1
 2017-02-13 11:35:41.505874 Example_Category[286:81938] class method : classMethod1
 2017-02-13 11:35:42.016687 Example_Category[286:81938] MyClass is responsd to selector: method3WithArg1:arg2:
 2017-02-13 11:35:43.271492 Example_Category[286:81938] call method method1
 2017-02-13 11:35:43.923117 Example_Category[286:81938] ==========================================================
 2017-02-13 11:35:52.324629 Example_Category[286:81938] MyClass is not responsed to protocol nil
 2017-02-13 11:36:01.572978 Example_Category[286:81938] ==========================================================
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
