//
//  MemoryTestCommonDefine.h
//  MemoryTest
//
//  Created by JessieYong on 14-3-10.
//
//

typedef enum{
    HoroscopeTypeAries,
    HoroscopeTypeTaurus,
    HoroscopeTypeGemini,
    HoroscopeTypeCancer,
    HoroscopeTypeLeo,
    HoroscopeTypeVirgo,
    HoroscopeTypeLibra,
    HoroscopeTypeScoprio,
    HoroscopeTypeSagittarius,
    HoroscopeTypeCapricorn,
    HoroscopeTypeAquarius,
    HoroscopeTypePisces,
    HoroscopeTypeNil
} HoroscopeType;

// webAddress
#define LINK_ADDRESS @"http://astro.lady.qq.com"

// encoding
#define	NSGB18030StringEncoding		0x80000632
#define NSGBKStringEncoding			    0x80000631
#define NSWindowsSCStringEncoding	0x80000421
#define NSMacSCStringEncoding		    0x80000019
#define NSHZGB2312StringEncoding   	0x80000A05
#define NSEUCCNStringEncoding		    0x80000930

#define GetHoroDataNotificationName @"DidGetHoroData"
#define TitleCellHeight 70
#define urlKeyArray [[NSArray alloc] initWithObjects:@"today", @"week", @"month", nil]
#define horoEnglishNameArray [[NSArray alloc] initWithObjects:@"aries", @"taurus", @"gemini", @"cancer", @"leonis", @"virgo",@"libra", @"scorpius", @"sagittarius",@"capricornus", @"aquarius", @"pisces",nil]
#define horoChineseNameArray [[NSArray alloc] initWithObjects:@"白羊座", @"金牛座", @"双子座", @"巨蟹座", @"狮子座", @"处女座",@"天秤座", @"天蝎座", @"射手座",@"摩羯座", @"水瓶座", @"双鱼座",nil]
