#import "PlatformFileUrlPlugin.h"
#if __has_include(<platform_file_url/platform_file_url-Swift.h>)
#import <platform_file_url/platform_file_url-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "platform_file_url-Swift.h"
#endif

@implementation PlatformFileUrlPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPlatformFileUrlPlugin registerWithRegistrar:registrar];
}
@end
