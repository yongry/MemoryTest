//
//  InfoClient.m
//  MemoryTest
//
//  Created by JessieYong on 02/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "InfoClient.h"
#import "InfoHunter.h"


@interface InfoClient()
@property (strong, nonatomic) NSDictionary *link;

- (void)getLinkFromWeb;

@end


@implementation InfoClient

- (NSMutableArray *)horoData
{
    if (!_horoData) {
        _horoData = [[NSMutableArray alloc] initWithCapacity:12];
        for (int i = HoroscopeTypeAries; i < HoroscopeTypeNil; i++)
        {
            NSMutableDictionary *horoItem = [[NSMutableDictionary alloc] init];
            [self.horoData insertObject:horoItem atIndex:i];
        }
    }
    return _horoData;
}

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (InfoClient *)shareClient
{
    static InfoClient *shareClient;
    if (!shareClient) {
        shareClient = [[InfoClient alloc] init];
    }
    return shareClient;
}

#pragma mark http methods

- (void)getHoroItemWithHoroType:(HoroscopeType)type
{
    NSString *fp = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/file.txt"];
    NSLog(@"%@",fp);
    NSDictionary *urlDictionary = [self getHoroLinkWithHoroType:type];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [self.horoData replaceObjectAtIndex:type withObject:[[NSMutableDictionary alloc] init]];
    
    for (NSString *urlKeyName in urlKeyArray)
    {
        NSString *url = [urlDictionary valueForKey:urlKeyName];
        NSString *path = [[NSBundle mainBundle] pathForResource:urlKeyName ofType:@"ihs"];
        NSString *script = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:queue
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             NSString *dataString = nil;
             if(dataString == nil)
                 dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             if(dataString == nil)
                 dataString = [[NSString alloc] initWithData:data encoding:NSGB18030StringEncoding];
             
             NSMutableDictionary *dataDictionary;
             dataDictionary = [InfoHunter huntWithString:dataString script:script];
             [dataDictionary writeToFile:fp atomically:YES];
             
             NSMutableDictionary *horoItem = [self.horoData objectAtIndex:type];
             [horoItem setValue:dataDictionary forKey:urlKeyName];
             
             NSLog(@"Load %@", urlKeyName);
         }];
    }
    
    [queue addOperationWithBlock:^{
        while ([[self.horoData objectAtIndex:type] count] != 3) {
            // busy waiting
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:GetHoroDataNotificationName object:nil];
    }];
}

- (NSDictionary *)getHoroLinkWithHoroType:(HoroscopeType)type
{
    NSMutableDictionary *horoLink = [[NSMutableDictionary alloc] init];
    for (NSString *urlKeyName in urlKeyArray)
        for (NSDictionary *urlDictionary in [self.link valueForKey:urlKeyName]) {
            NSLog(@"%@",urlDictionary);
            if ([InfoClient horoKeyFromChineseName:[urlDictionary valueForKey:@"horo"]] == type) {
                [horoLink setValue:[urlDictionary valueForKey:@"url"] forKey:urlKeyName];
            }
        }
    return horoLink;
}

- (void)getLinkFromWeb
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"url" ofType:@"ihs"];
    NSString *script = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSString *webAddress = LINK_ADDRESS;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:webAddress]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *dataString = nil;
    if(dataString==nil)
        dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if(dataString==nil)
        dataString = [[NSString alloc] initWithData:data encoding:NSGB18030StringEncoding];
    
    self.link = [InfoHunter huntWithString:dataString script:script];
    NSLog(@"%@",self.link);
    
}



+ (HoroscopeType)horoKeyFromChineseName:(NSString *)chineseName
{
    if ([chineseName isEqualToString:@"白羊座"]) {
        return HoroscopeTypeAries;
    } else if ([chineseName isEqualToString:@"金牛座"]) {
        return HoroscopeTypeTaurus;
    } else if ([chineseName isEqualToString:@"双子座"]) {
        return HoroscopeTypeGemini;
    } else if ([chineseName isEqualToString:@"巨蟹座"]) {
        return HoroscopeTypeCancer;
    } else if ([chineseName isEqualToString:@"狮子座"]) {
        return HoroscopeTypeLeo;
    } else if ([chineseName isEqualToString:@"处女座"]) {
        return HoroscopeTypeVirgo;
    } else if ([chineseName isEqualToString:@"天秤座"]) {
        return HoroscopeTypeLibra;
    } else if ([chineseName isEqualToString:@"天蝎座"]) {
        return HoroscopeTypeScoprio;
    } else if ([chineseName isEqualToString:@"射手座"]) {
        return HoroscopeTypeSagittarius;
    } else if ([chineseName isEqualToString:@"摩羯座"]) {
        return HoroscopeTypeCapricorn;
    } else if ([chineseName isEqualToString:@"水瓶座"]) {
        return HoroscopeTypeAquarius;
    } else if ([chineseName isEqualToString:@"双鱼座"]) {
        return HoroscopeTypePisces;
    }
    return HoroscopeTypeNil;
}

+ (NSString *)chineseFromHoroType:(HoroscopeType) type
{
    NSString *name = [[NSString alloc] init];
    switch (type) {
        case 0:
            name =  @"白羊座";
            break;
        case 1:
            name =  @"金牛座";
            break;
        case 2:
            name =  @"双子座";
            break;
        case 3:
            name =  @"巨蟹座";
            break;
        case 4:
            name =  @"狮子座";
            break;
        case 5:
            name =  @"处女座";
            break;
        case 6:
            name =  @"天秤座";
            break;
        case 7:
            name =  @"天蝎座";
            break;
        case 8:
            name =  @"射手座";
            break;
        case 9:
            name =  @"摩羯座";
            break;
        case 10:
            name =  @"水瓶座";
            break;
        case 11:
            name =  @"双鱼座";
            break;
        default:
            break;
    }
    return name;
}

@end