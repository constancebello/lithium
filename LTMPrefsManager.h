@interface LTMPrefsManager : NSObject

@property(nonatomic, readonly, retain) NSString *script;
@property(nonatomic, readonly) BOOL enabled;

+ (instancetype)sharedManager;
- (void)resetManager;

@end