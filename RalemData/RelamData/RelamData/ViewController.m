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
    [self deleteData];
    
    [self testSmallData];
    
//    NSDate* tmpStartData = [NSDate date];
//    [self testBigData];
//    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
//    NSLog(@">>>>>>>>>>cost time = %f ms", deltaTime*1000);
//    
//    NSDate* searchStartData = [NSDate date];
//    [self loadData];
//    double endTime = [[NSDate date] timeIntervalSinceDate:searchStartData];
//    NSLog(@">>>>>>>>>>cost time = %f ms", endTime*1000);
}

-(void)testSmallData{
    //[self createData];
    [self createDataWithBlock];
    [self loadData];
    
    //[self deleteData];
    [self updataWithNew];
    //[self updateData];
    [self loadData];
}

-(void)testBigData{
    [self createBigData];
    //[self loadData];
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
    [RealmHelper deleteWithAll:@"ProvinceEntity"];
}

-(void)updateData{
    RLMResults<ProvinceEntity *>* provinceArray=[ProvinceEntity allObjects];
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        ProvinceEntity *province=[provinceArray firstObject];
        province.shortName=@"浙江";
    }];
}

-(void)updataWithNew{
    [RealmHelper updataObject:@"ProvinceEntity"
                        where:@"" Block:^(RLMResults *result) {
                            ProvinceEntity *province=[result firstObject];
                            province.shortName=@"浙江";
                        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createBigData{
    NSString *JSONFilePath = [[NSBundle mainBundle]pathForResource:@"ChinaCityInfo" ofType:@"json"];
    NSString *JSONContent = [NSString stringWithContentsOfFile:JSONFilePath encoding:NSUTF8StringEncoding error:nil];
    NSData *JSONData = [JSONContent dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *JSONResult = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    NSArray *JSONArr  = JSONResult[@"rows"];
    //一次性存入 -- JSONArr 有序 (根据json文件  可知:数组中排列必然是  省市区)
    
    NSMutableDictionary *dic = [[NSMutableDictionary dictionary] mutableCopy];
    //字典套字典(存放省市)
    [dic setValue:[[NSMutableDictionary dictionary] mutableCopy] forKey:@"sheng"];
    [dic setValue:[[NSMutableDictionary dictionary] mutableCopy] forKey:@"shi"];
    
    for (NSDictionary *dcInfo in JSONArr){
        NSNumber *nType = [dcInfo objectForKey:@"Type"];
        if (nType) {
            switch ([nType integerValue]) {
                case 2://省
                {
                    ProvinceEntity *province = [[ProvinceEntity alloc]init];
                    
                    province.sId =(int)dcInfo[@"Id"];
                    province.pid = (int)dcInfo[@"Pid"];
                    province.type = (int)dcInfo[@"Type"];
                    province.shortName = dcInfo[@"Name"];
                    province.enName = dcInfo[@"EnName"];
                    province.prefixLetter = dcInfo[@"PrefixLetter"];
                    
                    [[dic objectForKey:@"sheng"] setValue:province forKey:[NSString stringWithFormat:@"%d",province.sId]];
                    
                }break;
                case 3://市
                {
                    CityEntity *city = [[CityEntity alloc]init];
                    
                    city.sId =(int)dcInfo[@"Id"];
                    city.pid = (int)dcInfo[@"Pid"];
                    city.type = (int)dcInfo[@"Type"];
                    city.shortName = dcInfo[@"Name"];
                    city.enName = dcInfo[@"EnName"];
                    city.prefixLetter = dcInfo[@"PrefixLetter"];
                    
                    
                    ProvinceEntity *province = [[dic objectForKey:@"sheng"] objectForKey:[NSString stringWithFormat:@"%d",city.pid]];
                    if(province)
                    {
                        [province.citys addObject:city];
                    }
                    [[dic objectForKey:@"shi"] setValue:city forKey:[NSString stringWithFormat:@"%d",city.sId]];
                }break;
                case 4://区
                {
                    AreaEntity *area = [[AreaEntity alloc]init];;
                    area.sId =(int)dcInfo[@"Id"];
                    area.pid = (int)dcInfo[@"Pid"];
                    area.type = (int)dcInfo[@"Type"];
                    area.shortName = dcInfo[@"Name"];
                    area.enName = dcInfo[@"EnName"];
                    area.prefixLetter = dcInfo[@"PrefixLetter"];
                    
                    CityEntity *city = [[dic objectForKey:@"shi"] objectForKey:[NSString stringWithFormat:@"%d",area.pid]];
                    if(city)
                    {
                        [city.areas addObject:area];
                    }
                    
                }break;
                default:break;
            }
        }
    }
    
    
    NSMutableDictionary* pDic=dic[@"sheng"];
    
    //排序
    NSArray* array=[pDic.allKeys copy];
    array=[array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if([obj1 integerValue]<[obj2 integerValue])
        {
            return  NSOrderedAscending;
        }else if([obj1 integerValue]>[obj2 integerValue])
        {
            return  NSOrderedDescending;
        }else
        {
            return  NSOrderedSame;
        }
    }];
    
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        for(int i=0;i<array.count;i++)
        {
            ProvinceEntity *province = [pDic objectForKey:array[i]];
            [[RLMRealm defaultRealm] addObject:province];
        }
    }];
}

@end
