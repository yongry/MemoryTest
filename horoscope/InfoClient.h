//
//  InfoClient.h
//  MemoryTest
//
//  Created by JessieYong on 02/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoClient : NSObject

@property (strong, nonatomic) NSMutableArray *horoData;

+ (InfoClient *)shareClient;
+ (HoroscopeType)horoKeyFromChineseName:(NSString *)chineseName;
+ (NSString *)chineseFromHoroType:(HoroscopeType) type;
- (void)getLinkFromWeb;
- (void)getHoroItemWithHoroType:(HoroscopeType)type;
- (NSDictionary *)getHoroLinkWithHoroType:(HoroscopeType)type;

@end
