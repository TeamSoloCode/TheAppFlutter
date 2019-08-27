#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
  [GMSServices provideAPIKey:@"AIzaSyA7cqKOztKjY3jcal8BUxufEIhERMsHVN4"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
@end
