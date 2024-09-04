# RN-Example

## First step import the sdk

Add the react-native-iu-library to your project using the follow command line:

```bash

npm add <folder>\react-native-iu-library
```

or 

```bash
yarn add <folder>\react-native-iu-library
```

<aside>📖
Note: The SDK is located in an external folder called "library". In this example, the SDK is only used for demonstration purposes.
</aside>

Then, run the following commands: 

```bash
npm install 
cd ios
pod install 
```

## Second step integrate sdk into your project

Go to the main target and add the following capability.

![Captura_de_pantalla_2024-09-03_a_la(s)_10 34 33_p _m](https://github.com/user-attachments/assets/51e10bf0-5537-4c79-97c5-a5cbdc3557f1)

Remember to also add the App Group to your info.plist.

![Captura_de_pantalla_2024-09-03_a_la(s)_10 36 15_p _m](https://github.com/user-attachments/assets/9de65aa2-b954-4864-8a27-2b346e321e95)

<aside> 📖
Note: You need to attach your own App Group. For more information, see → How to Create App Groups
</aside>

Now, add the following methods to your AppDelegate:

```objectivec
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
```

<aside> ⛔
Note: If you encounter issues when importing into your AppDelegate, it may be necessary to include the following flags in your Build Settings:

 - Other C Flags: -fmodules
 - Other C++ Flags: -fcxx-modules
</aside>

Example:

![image](https://github.com/user-attachments/assets/453d5526-34aa-4982-8c78-f12e76f99123)

![Captura_de_pantalla_2024-09-03_a_la(s)_10 48 45_p _m](https://github.com/user-attachments/assets/471e97b7-1b41-4ea1-b727-d60530043b7c)

Add your own local configuration to your Xcode project and ensure the project runs properly.

![image 1](https://github.com/user-attachments/assets/87847152-3a38-4aa4-8aaa-0db11308ca96)

## Third step add notification service extension

Go to your main target, and below the target, you'll see the plus and minus symbols. To add the Notification Service Extension, click the plus button, search for Notification Service Extension, and add it to your project.

![Captura_de_pantalla_2024-09-03_a_la(s)_11 34 10_p _m](https://github.com/user-attachments/assets/cc92b8be-3450-49c7-976b-6dd8801a6d18)

<aside> 📖
Note: You must also add the App Groups to this target and update the info.plist of the Rich Notification. The library needs to be added manually.

</aside>

![Captura_de_pantalla_2024-09-03_a_la(s)_11 35 58_p _m](https://github.com/user-attachments/assets/4d6230d6-d6e9-4425-9d92-96d6270e1417)

![Captura_de_pantalla_2024-09-04_a_la(s)_1 52 37_p _m](https://github.com/user-attachments/assets/f8337247-d8bf-4e38-bbfe-fbec8e2a2c88)

Now, add the following line of code in your NotificationService.swift:

```swift
 let drAd: Bool = request.content.userInfo["adAvailable"] as? Bool ?? false
    if(drAd){
      print("RichNotification NotificationService drAd")
      DigitalReef.includeMediaAttachment(request: request, mutableContent: bestAttemptContent!, contentHandler: contentHandler)
    }
```
Finally, verify that the project runs properly.
