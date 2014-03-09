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
#define urlKeyArray [[NSArray alloc] initWithObjects:@"today", @"week", @"month", nil]