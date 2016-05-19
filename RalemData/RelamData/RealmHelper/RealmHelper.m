//
//  RealmHelper.m
//  RelamData
//
//  Created by admin on 16/5/18.
//  Copyright © 2016年 李政. All rights reserved.
//

#import "RealmHelper.h"

@implementation RealmHelper

+(void)deleteWithAll:(NSString*)objectClassName{
    [[self class] deleteObjects:objectClassName where:@""];
}

+(void)deleteObjects:(NSString*)objectClassName where:(NSString *)predicateFormat{
    RLMResults* result=nil;
    if(predicateFormat.length>0)
    {
        result=[[RLMRealm defaultRealm] objects:objectClassName where:predicateFormat];
    }else
    {
        result=[[RLMRealm defaultRealm] allObjects:objectClassName];
    }
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] deleteObjects:result];
    }];
}

+(void)updataObject:(NSString*)objectClassName where:(NSString *)predicateFormat Block:(void(^)(RLMResults* result))block{
    RLMResults* result=nil;
    if(predicateFormat.length>0)
    {
        result=[[RLMRealm defaultRealm] objects:objectClassName where:predicateFormat];
    }else
    {
        result=[[RLMRealm defaultRealm] allObjects:objectClassName];
    }
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        block(result);
    }];
}

@end
