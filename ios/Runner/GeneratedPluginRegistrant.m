//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<launchdarkly_flutter_client_sdk/LaunchdarklyFlutterClientSdkPlugin.h>)
#import <launchdarkly_flutter_client_sdk/LaunchdarklyFlutterClientSdkPlugin.h>
#else
@import launchdarkly_flutter_client_sdk;
#endif

#if __has_include(<path_provider_foundation/PathProviderPlugin.h>)
#import <path_provider_foundation/PathProviderPlugin.h>
#else
@import path_provider_foundation;
#endif

#if __has_include(<shared_preferences_foundation/SharedPreferencesPlugin.h>)
#import <shared_preferences_foundation/SharedPreferencesPlugin.h>
#else
@import shared_preferences_foundation;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [LaunchdarklyFlutterClientSdkPlugin registerWithRegistrar:[registry registrarForPlugin:@"LaunchdarklyFlutterClientSdkPlugin"]];
  [PathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"PathProviderPlugin"]];
  [SharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"SharedPreferencesPlugin"]];
}

@end
