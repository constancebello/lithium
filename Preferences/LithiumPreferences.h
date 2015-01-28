#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface LithiumListController : PSListController {
	NSMutableArray *themes;
}

@end

@interface LTMListItemsController : PSListItemsController

@end

@interface PSListController (SettingsKit)
- (UIView*)view;
- (UINavigationController*)navigationController;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (UINavigationController*)navigationController;
- (UINavigationItem*) navigationItem;
- (void)loadView;
- (id)tableView:(UITableView*)table cellForRowAtIndexPath:(NSIndexPath*)path;
- (void)tableView:(UITableView*)table didSelectRowAtIndexPath:(NSIndexPath*)path;
@end