//
//  QTRuntimeHelper.m
//  runtimeHelper
//
//  Created by MasterBie on 2019/5/9.
//  Copyright © 2019 MasterBie. All rights reserved.
//

#import "QTRuntimeHelper.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation QTRuntimeHelper
// 获取成员变量
+ (NSDictionary *)getIvarListWithObject:(NSObject *)object
{
    uint ivarCount;
    Ivar *ivars = class_copyIvarList([object class], &ivarCount);
    NSMutableDictionary *list = [NSMutableDictionary dictionary];
    for (uint i = 0; i < ivarCount; i++) {
        Ivar ivar = ivars[i];
        const char *ivarName = ivar_getName(ivar);
        id pro = [object valueForKey:[NSString stringWithUTF8String:ivarName]];
        NSDictionary *dic = @{@"value":pro,@"class":NSStringFromClass([pro class])};
        [list setObject:dic forKey:[NSString stringWithUTF8String:ivarName]];
       // NSLog(@"ivarName:%@",[NSString stringWithUTF8String:ivarName]);
    }
    
    return list;
}

//交换方法
+ (void)exchageMethodWithClass:(Class)obj method1:(SEL)method1 method2:(SEL)method2
{
    Method me1 = class_getInstanceMethod(obj, method1);
    Method me2 = class_getInstanceMethod(obj, method2);
    method_exchangeImplementations(me1, me2);
}

// 往类对象中添加方法
+ (BOOL)addMethodFromClass:(Class)obj toClass:(Class)obj2 method:(SEL)method
{
    Method meh = class_getInstanceMethod(obj, method);
    BOOL success = class_addMethod(obj2, method, method_getImplementation(meh), method_getTypeEncoding(meh));
    return success;
}

// 通知对象执行方法(无参数)
+ (void)messgaeSentWithObject:(NSObject *)obj method:(SEL)method
{
    ((void (*)(id, SEL))objc_msgSend)((id)obj, method);
}

//动态添加属性
+(void)addPropertyToObject:(NSObject *)object propertyName:(NSString *)name value:(id)value type:(qtruntime_propertyType)type
{
    const char * _Nullable temp  =[name cStringUsingEncoding:NSASCIIStringEncoding];
    objc_setAssociatedObject(object, temp, value, (objc_AssociationPolicy)type);
}

//获取动态添加属性的值
+ (id)getPropertyFromObject:(NSObject *)object propertyName:(NSString *)name
{
    const char * _Nullable temp  =[name cStringUsingEncoding:NSASCIIStringEncoding];
    return objc_getAssociatedObject(object, temp);
}

//创建类
+ (Class)creatNewClassWithName:(NSString *)className superClass:(Class)superClass
{
    const char * name;
    name = [className UTF8String];
    Class kclass = objc_getClass(name);
    //判断此类是否已经存在
    if (!kclass)
    {
        if (!superClass) {
            superClass = [NSObject class];
        }
        kclass = objc_allocateClassPair(superClass, name, 0);
        objc_registerClassPair(kclass);
        return kclass;
    }
    else
    {
        return kclass;
    }
}

//修改对象的类
+ (Class)setObjectClassWithObject:(NSObject *)object class:(Class) objClass
{
    NSLog(@"%@ - %@", object,objClass);
         return  object_setClass(object, objClass);
}

//销毁类
+ (void)releseClass:(Class) cla
{
    objc_disposeClassPair(cla);
}
@end
