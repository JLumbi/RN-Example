#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>
#import <DigitalReefSDK/DigitalReefSDK.h>

@interface AppDelegate ()
@property (nonatomic, strong) DigitalReef *digitalReef;
@end

@implementation AppDelegate

- (instancetype)init{
    self = [super init];
    if(self){
        self.digitalReef = DigitalReef.shared;
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.moduleName = @"exampleApp";
  // You can add your custom initial props in the dictionary below.
  // They will be passed down to the ViewController used by React Native.
  self.initialProps = @{};
  
  [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
  [application registerForRemoteNotifications];
  [DigitalReef requestPushPermission];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  return [self getBundleURL];
}

- (NSURL *)getBundleURL
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

//MARK: notification methods
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    BOOL drAd = userInfo[@"adAvailable"];
    if(drAd == YES){
        NSLog(@"DR SDK");
        [self.digitalReef didReceiveRemoteNotificationWithApplication:application userInfo:userInfo fetchCompletionHandler:completionHandler];
    }else{
        NSLog(@"Other SDK");
    }
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [self.digitalReef didRegisterForRemoteNotificationsWithDeviceToken:application deviceToken:deviceToken];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    BOOL drAd = notification.request.content.userInfo[@"adAvailable"];
    if(drAd == YES){
        NSLog(@"DR SDK");
        [self.digitalReef willPresentNotificationWithCenter:center willPresent:notification withCompletionHandler:completionHandler];
    }else{
        NSLog(@"Other SDK");
    }
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    BOOL drAd = response.notification.request.content.userInfo[@"adAvailable"];
    if(drAd == YES){
        NSLog(@"DR SDK");
        [self.digitalReef didReceiveNotificationResponseWithCenter:center didReceive:response withCompletionHandler:completionHandler];
    }else{
        NSLog(@"Other SDK");
    }
    
}

@end
