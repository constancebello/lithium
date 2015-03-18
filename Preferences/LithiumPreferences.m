#import "LithiumPreferences.h"
#import "../UIImage+RenderBatteryImage.m"
#import <tgmath.h>

static LithiumListController *listController;
static CGFloat largestWidth;

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
	images = [[NSMutableDictionary alloc] init];
	NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/Lithium/" error:nil];
	for(NSString *file in contents) {
		if([file hasSuffix:@".js"]) {
			[themes addObject:[file substringToIndex:(file.length - 3)]];
			UIImage *image = [UIImage renderBatteryImageForJavaScript:[NSString stringWithContentsOfFile:[NSString stringWithFormat:@"/var/mobile/Lithium/%@", file] encoding:NSUTF8StringEncoding error:nil] height:20*[UIScreen mainScreen].scale percentage:66 charging:0 color:[UIColor blackColor]];
			[images setObject:image forKey:[file substringToIndex:(file.length - 3)]];
			largestWidth = fmax(largestWidth, image.size.width);
		}
	}
	listController = self;
}

- (NSArray *)themeTitles:(id)target {
	return themes;
}

- (NSArray *)themeValues:(id)target {
	return themes;
}

- (NSDictionary *)images {
	return images;
}

- (void)dealloc {
	[themes release];
	[images release];
	[super dealloc];
}

@end

@implementation LTMListItemsController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
	cell.imageView.image = [[listController images] objectForKey:cell.textLabel.text];
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(largestWidth, 20), NO, [UIScreen mainScreen].scale);
	[cell.imageView.image drawInRect:CGRectMake(floor((largestWidth - cell.imageView.image.size.width) / 2), floor((20 - cell.imageView.image.size.height) / 2), cell.imageView.image.size.width, cell.imageView.image.size.height)];
	cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("lithium.prefs-changed"), nil, nil, NO);
}

@end