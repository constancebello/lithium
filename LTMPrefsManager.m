#include "LTMPrefsManager.h"

@implementation LTMPrefsManager

@synthesize enabled = _enabled, script = _script, theme = _theme, batteryView = _batteryView, data = _data;
static LTMPrefsManager *sharedManager;

+ (instancetype)sharedManager {
	if(!sharedManager) {
		sharedManager = [[self alloc] init];
	}
	return sharedManager;
}

- (instancetype)init {
	self = [super init];
	NSDictionary *preferences = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/lithium.plist"];
	_enabled = ([preferences objectForKey:@"lithiumEnabled"] != nil) ? [[preferences objectForKey:@"lithiumEnabled"] boolValue] : YES;
	self.theme = [preferences objectForKey:@"lithiumTheme"] ?: @"Habesha";
	[preferences release];
	return self;
}

- (void)setTheme:(NSMutableString*)theme {
	_theme = theme;
	if(_enabled) {
		NSFileManager *fileManager = [NSFileManager defaultManager];
		NSString *fileLocation = [[NSString alloc] initWithFormat:@"/var/mobile/Lithium/%@.js", _theme];
		if(![fileManager fileExistsAtPath:fileLocation]) _enabled = NO;
		else _script = [[NSMutableString alloc] initWithContentsOfFile:fileLocation encoding:NSUTF8StringEncoding error:nil];
		[fileLocation release];
	}
}

- (void)dealloc {
	[_script release];
	[_batteryView release];
	[_theme release];
	[_data release];
	[super dealloc];
}

@end