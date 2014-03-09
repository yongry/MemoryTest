/**
 * 
 * @author 		Ruoyi Yong
 * @copyright	2013
 * @version
 * 
 */

#import <UIKit/UIKit.h>

@interface PieComponent : NSObject
{
    float value, startDeg, endDeg;
    NSString *title;
    UIColor *colour;
    UIColor *backgroundColor;
}
@property (nonatomic, assign) float value, startDeg, endDeg;
@property (nonatomic, retain) UIColor *colour;
@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) NSString *title;


- (id)initWithTitle:(NSString*)_title value:(float)_value color:(UIColor *)_backgroundColor textColor:(UIColor *)_textColor;
+ (id)pieComponentWithTitle:(NSString*)_title value:(float)_value color:(UIColor *)_backgroundColor textColor:(UIColor *)_textColor;
@end

#define PCColorDefault [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1]
#define PCColorOrange [UIColor colorWithRed:212/255.0 green:219/255.0 blue:212   /255.0 alpha:1.0] 

@interface PieChart : UIView {
    PieComponent *component;
    int diameter;
}
@property (nonatomic, assign) int diameter;
@property (nonatomic, retain) PieComponent *component;

@end
