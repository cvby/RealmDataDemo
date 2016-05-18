//
//  RealmHelper.m
//  RelamData
//
//  Created by admin on 16/5/18.
//  Copyright © 2016年 李政. All rights reserved.
//

#import "RealmHelper.h"

@implementation RealmHelper

+(void)deleteWithArray:(NSString*)objectClassName{
    RLMResults* result=[[RLMRealm defaultRealm] allObjects:objectClassName];
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] deleteObjects:result];
    }];
}

@end
