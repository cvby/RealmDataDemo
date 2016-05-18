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

+(void)deleteWithArray:(NSString*)objectClassName;

@end
