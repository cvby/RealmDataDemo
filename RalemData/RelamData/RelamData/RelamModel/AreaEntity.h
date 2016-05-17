//
//  AreaEntity.h
//  RelamData
//
//  Created by admin on 16/5/17.
//  Copyright © 2016年 李政. All rights reserved.
//

#import <Realm/Realm.h>

@interface AreaEntity : RLMObject

@property NSString *enName;
@property int pid;
@property NSString *prefixLetter;
@property NSString *shortName;
@property int sId;
@property int type;
//@property CityEntity *inCity;

@end
