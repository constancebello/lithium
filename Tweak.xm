#include "LTMPrefsManager.m"
#include "UIImage+RenderBatteryImage.m"

@interface NSUserDefaults (Lithium)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	if(![LTMPrefsManager sharedManager].batteryView) return;
	NSNumber *n = (NSNumber*)[[NSUserDefaults standardUserDefaults] objectForKey:@"lithiumEnabled" inDomain:@"lithium"];
	if(n) [LTMPrefsManager sharedManager].enabled = [n boolValue];
	NSString *theme = [[NSUserDefaults standardUserDefaults] objectForKey:@"lithiumTheme" inDomain:@"lithium"];
	if(theme) [LTMPrefsManager sharedManager].theme = (NSMutableString*)theme;/*
	SCD_Struct_UI69 *originalRawData = [[LTMPrefsManager sharedManager].data rawData];
	SCD_Struct_UI69 *newRawData = originalRawData;
	newRawData->batteryState = originalRawData->batteryState == 0 ? 1 : 0;
	UIStatusBarComposedData *composedData = [[%c(UIStatusBarComposedData) alloc] initWithRawData:newRawData];
	UIStatusBarComposedData *originalData = [LTMPrefsManager sharedManager].data;
	[[LTMPrefsManager sharedManager].batteryView updateForNewData:composedData actions:0];
	[[LTMPrefsManager sharedManager].batteryView updateForNewData:originalData actions:0];*/
}

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), nil, notificationCallback, (CFStringRef)@"lithium.prefs-changed", nil, CFNotificationSuspensionBehaviorCoalesce);
}

%hook UIStatusBarBatteryItemView

- (BOOL)updateForNewData:(UIStatusBarComposedData*)data actions:(int)actions {
	[LTMPrefsManager sharedManager].batteryView = self;
	[LTMPrefsManager sharedManager].data = data;
	return %orig;
}

- (BOOL)_needsAccessoryImage {
	return ([LTMPrefsManager sharedManager].enabled) ? NO : %orig;
}

- (id)contentsImage {
	if([LTMPrefsManager sharedManager].enabled) {
		int level = MSHookIvar<int>(self, "_capacity");
		int state = MSHookIvar<int>(self, "_state");
		CGFloat height = MSHookIvar<CGFloat>([self foregroundStyle], "_height") * [UIScreen mainScreen].scale;
		UIImage *image = [UIImage renderBatteryImageForJavaScript:[LTMPrefsManager sharedManager].script height:height percentage:level charging:state color:[[self foregroundStyle] textColorForStyle:[self legibilityStyle]]];
		return [%c(_UILegibilityImageSet) imageFromImage:image withShadowImage:image];
	}
	else {
		return %orig;
	}
}

%end