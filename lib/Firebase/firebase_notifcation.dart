
 //firebase_core: ^1.7.0
//  firebase_messaging: ^11.0.0


import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {

  Future<void> onInit() async {
    // for notification request  in ios
    await enableIOSNotifications();

    await setFirebasePushNotification();

    await registerNotificationListeners();

    RemoteMessage? initialMessage =  await FirebaseMessaging.instance.getInitialMessage();
    final firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then((value) => print('Token: $value'));

    if (initialMessage != null) {
      //  Utils.successSnackBar(initialMessage.notification!.title);
      print('// App received a notification when it was killed');
    }
  }

  setFirebasePushNotification() async {
    AndroidNotificationChannel channel = androidNotificationChannel();

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var androidSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSSettings = const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      print("onMessageOpenedApp");
      // Get.toNamed(Routes.SPLASH);
    });
    //FirebaseMessaging.instance.ge

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      if (message!.data["type"] == 'profile_update') {
      } else if (message.data['type'] == 'refer_and_earn') {
      } else if (message.data['type'] == 'order_request') {
      } else if (message.data['type'] == 'email_verify') {
      }
      print("on massage calling");
      if (message != null) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        print("Message type ==>${message.data['type']}");
        flutterLocalNotificationsPlugin.show(
            0,
            message.data['title'],
            message.data['message'],
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: android!.smallIcon,
                playSound: true,
              ),
            ),
            payload: message.data['type']);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {

    });

    var initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) => {
        print(details.notificationResponseType),
        print(details.payload),
        if (details.payload == 'profile_update')
        else if (details.payload == 'refer_and_earn'){

        }
        else if (details.payload == 'order_request'){

        }
        else if (details.payload == 'email_verify'){

        }
        else{

        }
      },
    );
  }


  enableIOSNotifications() async {
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.requestPermission(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
    }
  }

  androidNotificationChannel() {
    return const AndroidNotificationChannel(
      'Your Project Name', // title
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      playSound: true,
      importance: Importance.max,
    );
  }
}