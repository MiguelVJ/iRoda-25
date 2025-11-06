#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The resource bundle ID.
static NSString * const ACBundleID AC_SWIFT_PRIVATE = @"com.luastudio.vjtech";

/// The "BackgroundColor" asset catalog color resource.
static NSString * const ACColorNameBackgroundColor AC_SWIFT_PRIVATE = @"BackgroundColor";

/// The "SplashScreenBackgroundColor" asset catalog color resource.
static NSString * const ACColorNameSplashScreenBackgroundColor AC_SWIFT_PRIVATE = @"SplashScreenBackgroundColor";

/// The "LaunchStoryboard" asset catalog image resource.
static NSString * const ACImageNameLaunchStoryboard AC_SWIFT_PRIVATE = @"LaunchStoryboard";

#undef AC_SWIFT_PRIVATE
