//
//  CityEntity.h
//  RelamData
//
//  Created by admin on 16/5/17.
//  Copyright © 2016年 李政. All rights reserved.
//

#import "AreaEntity.h"
#import <Realm/Realm.h>

RLM_ARRAY_TYPE(AreaEntity)

@interface CityEntity : RLMObject

@property NSString *enName;
@property int pid;
@property NSString *prefixLetter;
@property NSString *shortName;
@property int sId;
@property int type;
@property  RLMArray<AreaEntity *><AreaEntity> *areas;
//@property ProvinceEntity *inProvince;

@end
