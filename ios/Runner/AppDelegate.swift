
import UIKit
import Flutter
import Firebase
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {
override func application(
    _ application: UIApplication,
didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
 FirebaseApp.configure()
 Messaging.messaging().delegate = self
 GeneratedPluginRegistrant.register(with: self)
 GMSServices.provideAPIKey("AIzaSyDJ6CkQRzsMy46WwMOqO7YAMMb6ZTPO_9I")
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    // Handle the registration token here
    // You can access the token using the `fcmToken` parameter
  }
  if #available(iOS 10.0, *) {
    // For iOS 10 display notification (sent via APNS)
    UNUserNotificationCenter.current().delegate = self
    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
    UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
} else {
    let settings: UIUserNotificationSettings =
    UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
    application.registerUserNotificationSettings(settings)
}
application.registerForRemoteNotifications()
return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
   }