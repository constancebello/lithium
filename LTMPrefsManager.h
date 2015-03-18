typedef struct {
	BOOL itemIsEnabled[25];
	char timeString[64];
	int gsmSignalStrengthRaw;
	int gsmSignalStrengthBars;
	char serviceString[100];
	char serviceCrossfadeString[100];
	char serviceImages[2][100];
	char operatorDirectory[1024];
	unsigned serviceContentType;
	int wifiSignalStrengthRaw;
	int wifiSignalStrengthBars;
	unsigned dataNetworkType;
	int batteryCapacity;
	unsigned batteryState;
	char batteryDetailString[150];
	int bluetoothBatteryCapacity;
	int thermalColor;
	unsigned thermalSunlightMode : 1;
	unsigned slowActivity : 1;
	unsigned syncActivity : 1;
	char activityDisplayId[256];
	unsigned bluetoothConnected : 1;
	unsigned displayRawGSMSignal : 1;
	unsigned displayRawWifiSignal : 1;
	unsigned locationIconType : 1;
	unsigned quietModeInactive : 1;
	unsigned tetheringConnectionCount;
} SCD_Struct_UI69;

@class UIStatusBarForegroundStyleAttributes, _UILegibilityView;

@interface UIStatusBarComposedData : NSObject
- (SCD_Struct_UI69*)rawData;
- (id)initWithRawData:(const SCD_Struct_UI69*)data;
@end

@interface UIStatusBarItemView : UIView

- (id)contentsImage;
- (id)foregroundStyle;
- (int)legibilityStyle;

@end

@interface UIStatusBarBatteryItemView : UIStatusBarItemView
- (bool)updateForNewData:(UIStatusBarComposedData*)data actions:(int)actions;
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

@interface LTMPrefsManager : NSObject

@property(nonatomic, retain) NSMutableString *script;
@property(nonatomic) BOOL enabled;
@property(nonatomic, retain) NSMutableString *theme;
@property(nonatomic, retain) UIStatusBarBatteryItemView *batteryView;
@property(nonatomic, retain) UIStatusBarComposedData *data;

+ (instancetype)sharedManager;

@end