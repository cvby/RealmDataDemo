//
//  RealmHelper.m
//  RelamData
//
//  Created by admin on 16/5/18.
//  Copyright © 2016年 李政. All rights reserved.
//

#import "RealmHelper.h"

@implementation RealmHelper

+(void)deleteWithArray:(RLMResults*)result{
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] deleteObjects:result];
    }];
}

@end
