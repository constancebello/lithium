#include <UIKit/UIKit.h>
#include <CoreGraphics/CoreGraphics.h>

@interface UIImage (RenderBatteryImage)

+ (UIImage *) renderBatteryImageForJavaScript:(NSString *)javascript height:(CGFloat)height percentage:(int)percentage charging:(int)charging color:(UIColor *)color;

@end