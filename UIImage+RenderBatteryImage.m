#include <UIImage+RenderBatteryImage.h>

@implementation UIImage (RenderBatteryImage)

+ (UIImage *) renderBatteryImageForJavaScript:(NSString *)javascript height:(CGFloat)height percentage:(int)percentage charging:(int)charging color:(UIColor *)color {
	int low;
	if([(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
		if(percentage <= 10) {
			low = 0;
		}
		else {
			low = 1;
		}
	}
	else {
		if(percentage <= 20) {
			low = 0;
		}
		else {
			low = 1;
		}
	}
	CGFloat r, g, b;
	[color getRed:&r green:&g blue:&b alpha:nil];
	int rI = (int)(r * 255);
	int gI = (int)(g * 255);
	int bI = (int)(b * 255);
	UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
	[webView loadHTMLString:nil baseURL:nil];
	NSString *finalJS = [[NSString alloc] initWithFormat:@"(function%@)(%0.0f,%i,!!%i,!%i,[%i,%i,%i])", javascript, height, percentage, charging, low, rI, gI, bI];
	UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[webView stringByEvaluatingJavaScriptFromString:finalJS]]] scale:[UIScreen mainScreen].scale];
	[webView release];
	[finalJS release];
	return image;
}

@end