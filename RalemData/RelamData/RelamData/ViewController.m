//
//  ViewController.m
//  RelamData
//
//  Created by admin on 16/5/16.
//  Copyright © 2016年 李政. All rights reserved.
//

#import "ViewController.h"
#import "ProvinceEntity.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createData];
    [self loadData];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)createData{
    ProvinceEntity* province=[[ProvinceEntity alloc] init];
    province.sId =1;
    province.pid = 2;
    province.type = 0;
    province.shortName = @"江苏";
    province.enName = @"jiangsu";
    province.prefixLetter = @"j";
    
    NSArray* array=@[@"无锡",@"苏州",@"常州",@"南京",@"镇江"];
    for (int i=0; i<5; i++) {
        CityEntity *city = [[CityEntity alloc] init];
        city.sId =1;
        city.pid = 3;
        city.type = 0;
        city.shortName = array[i];
        city.enName = @"wuxi";
        city.prefixLetter = @"w";
        [province.citys addObject:city];
    }
    
    // Get the default Realm
    RLMRealm *realm = [RLMRealm defaultRealm];
    // You only need to do this once (per thread)
    
    // Add to Realm with transaction
    [realm beginWriteTransaction];
    [realm addObject:province];
    [realm commitWriteTransaction];
}

-(void)loadData{
    RLMResults<ProvinceEntity *>* province=[ProvinceEntity allObjects];
    NSLog(@"%@",province.lastObject);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
