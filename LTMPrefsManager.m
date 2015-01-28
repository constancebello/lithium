#include "LTMPrefsManager.h"

@implementation LTMPrefsManager

@synthesize enabled = _enabled, script = _script;

static LTMPrefsManager *sharedManager;

+ (instancetype)sharedManager {
	if(!sharedManager) {
		sharedManager = [[self alloc] init];
	}
	return sharedManager;
}

- (void)resetManager {
	[sharedManager release];
}

- (instancetype)init {
	self = [super init];
	NSDictionary *preferences = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/lithium.plist"];
	_enabled = ([preferences objectForKey:@"lithiumEnabled"] != nil) ? [[preferences objectForKey:@"lithiumEnabled"] boolValue] : YES;
	NSLog(@"LITHIUM: Enabled: %@", _enabled ? @"Yes" : @"No");
	if(_enabled) {
		NSFileManager *fileManager = [NSFileManager defaultManager];
		NSString *theme = [preferences objectForKey:@"lithiumTheme"] ?: @"Habesha";
		NSLog(@"LITHIUM: Theme: %@", theme);
		NSString *fileLocation = [[NSString alloc] initWithFormat:@"/var/mobile/Lithium/%@.js", theme];
		if(![fileManager fileExistsAtPath:fileLocation]) {
			_enabled = NO;
		}
		else {
			_script = [[NSString alloc] initWithContentsOfFile:fileLocation encoding:NSUTF8StringEncoding error:nil];
		}
		NSLog(@"LITHIUM: %@, script: %@", _enabled ? @"Still enabled" : @"No longer enabled", _script);
		[fileLocation release];
		[theme release];
	}
	[preferences release];
	return self;
}

- (void) dealloc {
	[_script release];
	[super dealloc];
}

@end