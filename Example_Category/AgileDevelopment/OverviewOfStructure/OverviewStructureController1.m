//
//  OverviewStructureController1.m
//  Example_Category
//
//  Created by MCL on 16/9/3.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "OverviewStructureController1.h"

/* OFFSET宏定义可取得指定结构体某成员在结构体内部的偏移 */
#define OFFSET(st, field)     (size_t)&(((st*)0)->field)

typedef struct{
    char  a;
    short b;
    char  c;
    int   d;
    char  e[3];
}T_Test;


typedef struct{
    char  c1;
    short s;
    char  c2;
    int   i;
}T_FOO;

/**
 *  ////////////////////////////////////////////////
 */
/*声明一个结构体类型, 其成员变量是普通变量*/
struct student
{
    char *name;
    int age;
};

/*声明一个结构体类型, 其成员变量是结构体*/
struct class
{
    struct student s1;
    struct student s2;
};

/*
 * 传递 2 个结构体的成员变量
 * 在函数中创建结构体并返回
 */
struct student create_student(char *name, int age)
{
    struct student s1 = {name, age};
    return s1;
}

/*
 * 传递 2 个结构体变量
 */
struct class create_class(struct student s2, struct student s3)
{
    struct class c1 = {s2, s3};
    return c1;
}

/*
 * 传入一个结构体指针
 * 通过指针访问结构体的方法 :
 *   (*结构体指针变量).成员变量 访问;
 *   结构体指针变量 -> 成员变量 访问;
 */
void printf_struct_pointer(struct student *s)
{
    printf("student : (*s).name = %s, (*s).age = %d \n", (*s).name, (*s).age);
    printf("student : s->name = %s, s->age = %d \n", s->name, s->age);
}


@interface OverviewStructureController1 ()

@end

@implementation OverviewStructureController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    T_FOO a;
    NSLog(@"c1 -> %d, s -> %d, c2 -> %d, i -> %d\n",
           (unsigned int)(void*)&a.c1 - (unsigned int)(void*)&a,
           (unsigned int)(void*)&a.s  - (unsigned int)(void*)&a,
           (unsigned int)(void*)&a.c2 - (unsigned int)(void*)&a,
           (unsigned int)(void*)&a.i  - (unsigned int)(void*)&a);
    
    NSLog(@"Size = %lu\n  a-%zu, b-%zu, c%zud, d-%zu\n  e[0]%zud, e[1]-%zu, e[2]-%zu\n",
           sizeof(T_Test), OFFSET(T_Test, a), OFFSET(T_Test, b),
           OFFSET(T_Test, c), OFFSET(T_Test, d), OFFSET(T_Test, e[0]),
           OFFSET(T_Test, e[1]),OFFSET(T_Test, e[2]));
    
    /*
     2016-09-03 16:14:15.270 Example_Category[1702:288510] c1 -> 0, s -> 2, c2 -> 4, i -> 8
     2016-09-03 16:14:15.270 Example_Category[1702:288510] Size = 16
     a-0, b-2, c4d, d-8
     e[0]12d, e[1]-13, e[2]-14
     
     下面来具体分析：
     
     首先char a占用1个字节，没问题。
     short b本身占用2个字节，根据上面准则2，需要在b和a之间填充1个字节。
     char c占用1个字节，没问题。
     int d本身占用4个字节，根据准则2，需要在d和c之间填充3个字节。
     char e[3]；本身占用3个字节，根据原则3，需要在其后补充1个字节。

     因此，sizeof(T_Test) = 1 + 1 + 2 + 1 + 3 + 4 + 3 + 1 = 16字节。
     */
    
    
    /*使用函数获取一个结构体, 传入结构体的值*/
    struct student s1 = create_student("Tom", 11);
    printf("student : name = %s, age = %d \n", s1.name, s1.age);
    
    /*创建一个成员变量是结构体的结构体, 并打印结构体数据*/
    struct class c1 = create_class(create_student("Jack", 12), create_student("CJ", 13));
    printf("c1 : s1 : name = %s, age = %d ; s2 : name = %s, age = %d \n", c1.s1.name, c1.s1.age, c1.s2.name, c1.s2.age);
    
    /*声明结构体指针*/
    struct student *p = &s1;
    printf_struct_pointer(p);
    
    /*
     student : name = Tom, age = 11
     c1 : s1 : name = Jack, age = 12 ; s2 : name = CJ, age = 13
     student : (*s).name = Tom, (*s).age = 11
     student : s->name = Tom, s->age = 11
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 结构体字节对齐的细节和具体编译器实现相关，但一般而言满足三个准则：
 
 1) 结构体变量的首地址能够被其最宽基本类型成员的大小所整除；
 
 2) 结构体每个成员相对结构体首地址的偏移量(offset)都是成员大小的整数倍，如有需要编译器会在成员之间加上填充字节(internal adding)；
 
 3) 结构体的总大小为结构体最宽基本类型成员大小的整数倍，如有需要编译器会在最末一个成员之后加上填充字节{trailing padding}。
 
 对于以上规则的说明如下：
 
 第一条：编译器在给结构体开辟空间时，首先找到结构体中最宽的基本数据类型，然后寻找内存地址能被该基本数据类型所整除的位置，作为结构体的首地址。将这个最宽的基本数据类型的大小作为上面介绍的对齐模数。
 
 第二条：为结构体的一个成员开辟空间之前，编译器首先检查预开辟空间的首地址相对于结构体首地址的偏移是否是本成员大小的整数倍，若是，则存放本成员，反之，则在本成员和上一个成员之间填充一定的字节，以达到整数倍的要求，也就是将预开辟空间的首地址后移几个字节。
 
 第三条：结构体总大小是包括填充字节，最后一个成员满足上面两条以外，还必须满足第三条，否则就必须在最后填充几个字节以达到本条要求。
 */


/*
 (32位，X86处理器，GCC编译器)：
 
 struct A{
 int    a;
 char   b;
 short  c;
 };
 
 struct B{
 char   b;
 int    a;
 short  c;
 };
 
 已知32位机器上各数据类型的长度为：char为1字节、short为2字节、int为4字节、long为4字节、float为4字节、double为8字节。那么上面两个结构体大小如何呢？
 
 结果是：sizeof(strcut A)值为8；sizeof(struct B)的值却是12。
 
 结构体A中包含一个4字节的int数据，一个1字节char数据和一个2字节short数据；B也一样。按理说A和B大小应该都是7字节。之所以出现上述结果，就是因为编译器要对数据成员在空间上进行对齐。
 
 
 */

/*
 对齐准则
 
 先来看四个重要的基本概念：
 
 1) 数据类型自身的对齐值：char型数据自身对齐值为1字节，short型数据为2字节，int/float型为4字节，double型为8字节。
 
 2) 结构体或类的自身对齐值：其成员中自身对齐值最大的那个值。
 
 3) 指定对齐值：#pragma pack (value)时的指定对齐值value。
 
 4) 数据成员、结构体和类的有效对齐值：自身对齐值和指定对齐值中较小者，即有效对齐值=min{自身对齐值，当前指定的pack值}。
 */

/*
 一  什么是字节对齐
 
 现代计算机中，内存空间按照字节划分，理论上可以从任何起始地址访问任意类型的变量。但实际中在访问特定类型变量时经常在特定的内存地址访问，这就需要各种类型数据按照一定的规则在空间上排列，而不是顺序一个接一个地存放，这就是对齐。
 
 
 二  对齐的原因和作用
 
 不同硬件平台对存储空间的处理上存在很大的不同。某些平台对特定类型的数据只能从特定地址开始存取，而不允许其在内存中任意存放。例如Motorola 68000 处理器不允许16位的字存放在奇地址，否则会触发异常，因此在这种架构下编程必须保证字节对齐。
 
 但最常见的情况是，如果不按照平台要求对数据存放进行对齐，会带来存取效率上的损失。比如32位的Intel处理器通过总线访问(包括读和写)内存数据。每个总线周期从偶地址开始访问32位内存数据，内存数据以字节为单位存放。如果一个32位的数据没有存放在4字节整除的内存地址处，那么处理器就需要2个总线周期对其进行访问，显然访问效率下降很多。
 
 因此，通过合理的内存对齐可以提高访问效率。为使CPU能够对数据进行快速访问，数据的起始地址应具有“对齐”特性。比如4字节数据的起始地址应位于4字节边界上，即起始地址能够被4整除。
 
 此外，合理利用字节对齐还可以有效地节省存储空间。但要注意，在32位机中使用1字节或2字节对齐，反而会降低变量访问速度。因此需要考虑处理器类型。还应考虑编译器的类型。在VC/C++和GNU GCC中都是默认是4字节对齐。
 
 
 三  对齐的分类和准则
 
 主要基于Intel X86架构介绍结构体对齐和栈内存对齐，位域本质上为结构体类型。
 
 对于Intel X86平台，每次分配内存应该是从4的整数倍地址开始分配，无论是对结构体变量还是简单类型的变量。
 3.1 结构体对齐
 
 在C语言中，结构体是种复合数据类型，其构成元素既可以是基本数据类型(如int、long、float等)的变量，也可以是一些复合数据类型(如数组、结构体、联合等)的数据单元。编译器为结构体的每个成员按照其自然边界(alignment)分配空间。各成员按照它们被声明的顺序在内存中顺序存储，第一个成员的地址和整个结构的地址相同。
 
 字节对齐的问题主要就是针对结构体。
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
