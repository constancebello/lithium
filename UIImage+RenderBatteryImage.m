#include "UIImage+RenderBatteryImage.h"

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
	NSString *stringData = [[NSString alloc] initWithString:[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"(function%@)(%0.0f,%i,!!%i,!%i,[%i,%i,%i])", javascript, height, percentage, charging, low, rI, gI, bI]]];
	NSData *base64Data = [[NSData alloc] initWithBase64EncodedString:[stringData substringFromIndex:([stringData rangeOfString:@"base64,"].location+7)] options:0];
	[stringData release];
	UIImage *image = [UIImage imageWithData:base64Data scale:[UIScreen mainScreen].scale];
	[base64Data release];
	[webView release];
	return image;
}

@end
