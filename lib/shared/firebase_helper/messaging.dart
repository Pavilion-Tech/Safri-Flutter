import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'notification.dart';

class Messaging {
  static Future<void> onNotificationReceived(RemoteMessage message) async {
      await Firebase.initializeApp();
    print('Handling a message ${message.messageId}');
  }

  static String? token;
  static initFCM() async {
    try {
      await FCM.initializeFCM(
        onNotificationPressed: (Map<String, dynamic> data) {
          if (data.isNotEmpty) {

            handlingFCMNavigator(data);
          }
        },
        onTokenChanged: (String? token) {
          Messaging.token = token;

        },
        icon: '@mipmap/launcher_icon',
        onNotificationReceived: onNotificationReceived,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  static void handlingFCMNavigator(Map<String,dynamic> data) {

    if (data['type'] == "msg") {
    // navigateTo(widget: const ChatList());

    }
    else {
      print("getting a new notification");
     // navigateTo(context: navigatorKey.currentContext,widget:  const SplashScreen());
    }

  }
}