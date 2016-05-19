//
//  RealmHelper.h
//  RelamData
//
//  Created by admin on 16/5/18.
//  Copyright © 2016年 李政. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import <Realm/RLMRealm_Dynamic.h>

@interface RealmHelper : NSObject

/**根据对象名称，删除数据库对应的对象表
 *  @param objectClassName 对象名称
 *  @return nil
 */

+(void)deleteWithAll:(NSString*)objectClassName;

/**根据对象名称和查询条件，删除数据库对应的对象
 *  @param objectClassName 对象名称
 *  @param predicateFormat 查找条件
 *  @return nil
 */
+(void)deleteObjects:(NSString*)objectClassName where:(NSString *)predicateFormat;

/**根据条件更新数据方法
 *  @param objectClassName 对象名称
 *  @param predicateFormat 查找条件
 *  @param Block 会传出查找到的结果，以供调用
 *  @return nil
 */

+(void)updataObject:(NSString*)objectClassName where:(NSString *)predicateFormat Block:(void(^)(RLMResults* result))block;

@end
