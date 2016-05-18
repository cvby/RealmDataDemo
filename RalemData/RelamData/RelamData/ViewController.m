//
//  ViewController.m
//  RelamData
//
//  Created by admin on 16/5/16.
//  Copyright © 2016年 李政. All rights reserved.
//

#import "ViewController.h"
#import "ProvinceEntity.h"
#import "RealmHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self createData];
    [self createDataWithBlock];
    [self loadData];
    
    [self deleteData];
    [self loadData];
    // Do any additional setup after loading the view, typically from a nib.
}

-(ProvinceEntity*)createModel:(NSArray*)array{
    ProvinceEntity* province=[[ProvinceEntity alloc] init];
    province.sId =1;
    province.pid = 2;
    province.type = 0;
    province.shortName = @"江苏";
    province.enName = @"jiangsu";
    province.prefixLetter = @"j";
    NSArray* aArray=@[@"滨湖区",@"锡山区",@"南长区",@"崇安区",@"北塘区"];
    for (int i=0; i<array.count; i++) {
        CityEntity *city = [[CityEntity alloc] init];
        city.sId =1;
        city.pid = 3;
        city.type = 0;
        city.shortName = array[i];
        city.enName = @"wuxi";
        city.prefixLetter = @"w";
        for (int j=0; j<5; j++) {
            AreaEntity *area = [[AreaEntity alloc] init];
            area.sId =1;
            area.pid = 3;
            area.type = 0;
            area.shortName = aArray[j];
            area.enName = @"wuxi";
            area.prefixLetter = @"w";
            [city.areas addObject:area];
        }
        [province.citys addObject:city];
    }
    return province;
}

-(void)createData{
    
    ProvinceEntity* province=[self createModel:@[@"无锡",@"苏州",@"常州",@"南京",@"镇江"]];
    // Get the default Realm
    RLMRealm *realm = [RLMRealm defaultRealm];
    // You only need to do this once (per thread)
    
    // Add to Realm with transaction
    [realm beginWriteTransaction];
    [realm addObject:province];
    [realm commitWriteTransaction];
}

-(void)createDataWithBlock{
    ProvinceEntity* province=[self createModel:@[@"徐州",@"淮安",@"南京",@"扬州",@"盐城",@"南通",@"连云港"]];
    //这里的block只是一个代码块，不存在异步问题
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] addObject:province];
    }];
}

-(void)loadData{
    RLMResults<ProvinceEntity *>* province=[ProvinceEntity allObjects];
    NSLog(@"%@",province.lastObject);
    
}

-(void)deleteData{
    RLMResults<ProvinceEntity *>* province=[ProvinceEntity allObjects];
    [RealmHelper deleteWithArray:province];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
