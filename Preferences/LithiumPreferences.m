#import "LithiumPreferences.h"

@implementation LithiumListController

- (id)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"LithiumPreferences" target:self] retain];
	}
	return _specifiers;
}

- (void)loadView {
	[super loadView];
	themes = [[NSMutableArray alloc] init];
	NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/Lithium/" error:nil];
	for(NSString *file in contents) {
		if([file hasSuffix:@".js"]) {
			[themes addObject:[file substringToIndex:(file.length - 3)]];
		}
	}
}

- (NSArray *)themeTitles:(id)target {
	return themes;
}

- (NSArray *)themeValues:(id)target {
	return themes;
}

- (void)dealloc {
	[themes release];
	[super dealloc];
}

@end

@implementation LTMListItemsController

- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2 {
	[super tableView:arg1 didSelectRowAtIndexPath:arg2];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("lithium.prefs-changed"), nil, nil, NO);
}

@end