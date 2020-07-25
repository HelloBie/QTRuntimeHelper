//
//  QTRuntimeHelper.h
//  runtimeHelper
//
//  Created by MasterBie on 2019/5/9.
//  Copyright © 2019 MasterBie. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef OBJC_ENUM(uintptr_t, qtruntime_propertyType) {
    QTRT_ASSIGN = 0,           /**< Specifies a weak reference to the associated object. */
    QTRT_RETAIN_NONATOMIC = 1, /**< Specifies a strong reference to the associated object.
                                            *   The association is not made atomically. */
    QTRT_COPY_NONATOMIC = 3,   /**< Specifies that the associated object is copied.
                                            *   The association is not made atomically. */
    QTRT_RETAIN = 01401,       /**< Specifies a strong reference to the associated object.
                                            *   The association is made atomically. */
    QTRT_COPY = 01403          /**< Specifies that the associated object is copied.
                                            *   The association is made atomically. */
};
NS_ASSUME_NONNULL_BEGIN

@interface QTRuntimeHelper : NSObject

// 获取成员列表
+ (NSDictionary *)getIvarListWithObject:(NSObject *)object;

//方法交换
+ (void)exchageMethodWithClass:(Class)obj method1:(SEL)method1 method2:(SEL)method2;

// 往类对象中添加方法
+ (BOOL)addMethodFromClass:(Class)obj toClass:(Class)obj2 method:(SEL)method;

// 通知对象执行方法(无参数)
+ (void)messgaeSentWithObject:(NSObject *)obj method:(SEL)method;

//动态添加(修改)属性
+(void)addPropertyToObject:(NSObject *)object propertyName:(NSString *)name value:(id)value type:(qtruntime_propertyType)type;

//获取动态添加属性的值
+ (id)getPropertyFromObject:(NSObject *)object propertyName:(NSString *)name;

//创建类,创建成功返回yes,失败返回no
+ (Class)creatNewClassWithName:(NSString *)className superClass:(Class)superClass;

//销毁类
+ (void)releseClass:(Class) cla;

//修改对象的类
+ (Class)setObjectClassWithObject:(NSObject *)object class:(Class) objClass;
@end

NS_ASSUME_NONNULL_END
