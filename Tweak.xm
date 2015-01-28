#include "LTMPrefsManager.m"
#include "UIImage+RenderBatteryImage.m"

@class UIStatusBarForegroundStyleAttributes, _UILegibilityView;

@interface UIStatusBarItemView : UIView

- (id)contentsImage;
- (id)foregroundStyle;
- (int)legibilityStyle;

@end

@class UIImage;

@interface _UILegibilityImageSet : NSObject

+ (id)imageFromImage:(id)arg1 withShadowImage:(id)arg2;

@end

@class NSMutableDictionary;

@interface UIStatusBarForegroundStyleAttributes : NSObject

- (id)textColorForStyle:(int)arg1;
- (float)height;

@end

%hook UIStatusBarBatteryItemView

- (BOOL)_needsAccessoryImage {
    if([LTMPrefsManager sharedManager].enabled) {
        return NO;
    }
    else {
        return %orig;
    }
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