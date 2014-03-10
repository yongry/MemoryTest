//
//  DescriptionCell.h
//  MemoryTest
//
//  Created by JessieYong on 13-11-24.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "PieChart.h"

@implementation PieComponent
@synthesize value, title, backgroundColor,color, textColor,startDeg, endDeg;

- (id)initWithTitle:(NSString*)_title value:(float)_value color:(UIColor *)_backgroundColor textColor:(UIColor *)_textColor
{
    self = [super init];
    if (self)
    {
        self.title = _title;
        self.value = _value;
        self.color = PCColorDefault;
        self.backgroundColor = _backgroundColor;
        self.textColor = _textColor;
    }
    return self;
}

+ (id)pieComponentWithTitle:(NSString*)_title value:(float)_value color:(UIColor *)_backgroundColor textColor:(UIColor *)_textColor
{
    return [[super alloc] initWithTitle:_title value:_value color: _backgroundColor textColor:(UIColor *)_textColor];
}

- (NSString*)description
{
  
    NSMutableString *text = [NSMutableString string];
    [text appendFormat:@"title: %@\n", self.title];
    [text appendFormat:@"value: %f\n", self.value];
    return text;
}

@end

@implementation PieChart
@synthesize  component;
@synthesize diameter;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];

		
	}
    return self;
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code
      NSLog(@"%f",[component value]);
    float margin = 15;
    if (self.diameter==0)
    {
        diameter = MIN(rect.size.width, rect.size.height) - 2*margin;
    }
    float x = (rect.size.width - diameter)/2;
    float y = (rect.size.height - diameter)/2;
    float inner_radius = diameter/2;
    float origin_x = x + diameter/2;
    float origin_y = y + diameter/2;
    
    
    

    //取得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //UIGraphicsPushContext(ctx);
    NSLog(@"%@",[component title]);
    CGContextSetFillColorWithColor(ctx, [component.color CGColor]);
    CGContextFillEllipseInRect(ctx, CGRectMake(x, y, diameter, diameter));  // a white filled circle with a diameter of 100 pixels, centered in (60, 60)
   // UIGraphicsPopContext();
    CGContextClosePath(ctx);
			
    float endDeg = 0;
	if([[component title] isEqualToString: @"all"])
        CGContextSetRGBFillColor(ctx, 227/255.0,173/255.0, 77/255.0, 1.0f); 
    else 
        CGContextSetRGBFillColor(ctx, 122/255.0,194/255.0, 219/255.0, 1.0f); 				
    endDeg = [component value] * 3.6;
	
    
    CGContextMoveToPoint(ctx, origin_x, origin_y);
    CGContextAddArc(ctx,  origin_x, origin_y, inner_radius, (0-90)*M_PI/180.0,(endDeg-90)*M_PI/180.0, 0);
    CGContextFillPath(ctx);
    CGContextClosePath(ctx);
   
	 CGContextSetFillColorWithColor(ctx,[component.backgroundColor CGColor]);	
     CGContextMoveToPoint(ctx,  origin_x, origin_y);
     CGContextAddArc(ctx, origin_x, origin_y, inner_radius/1.6 ,0,M_PI*2,0);
     CGContextFillPath(ctx);
     CGContextClosePath(ctx);

    CGContextSetFillColorWithColor(ctx,[[component textColor] CGColor]);	
   //CGContextSetStrokeColorWithColor(ctx, [[UIColor blackColor]CGColor]);
    UIFont * font = [UIFont fontWithName:@"Arial" size:13];  
    NSString *str = [[NSString alloc]initWithFormat:@"%d",(int)[component value]];
    str = [str stringByAppendingString:@"%"];
    [str drawAtPoint:CGPointMake(origin_x - 12, origin_y - 7) withFont:font]; 
   // CGContextStrokePath(ctx);
   CGContextClosePath(ctx);

	
}



@end
