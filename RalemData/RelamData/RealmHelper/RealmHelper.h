//
//  RealmHelper.h
//  RelamData
//
//  Created by admin on 16/5/18.
//  Copyright © 2016年 李政. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface RealmHelper : NSObject

+(void)deleteWithArray:(RLMResults*)result;

@end
