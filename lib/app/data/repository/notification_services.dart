
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../widgets/alerte_widgets.dart';


class NotificationServices{

  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async{
      notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();

      AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('cocody_logo');

      var initialisationsettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async{}
      );
      var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initialisationsettingsIOS);

      await notificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {} );
  }

  notificationDetails(){

    return NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName', importance: Importance.max),
      iOS: DarwinNotificationDetails()
    );

  }

  Future showNotification({int id = 0, String? title, String? body, String? payload}) async{
    return notificationsPlugin.show(id, title, body, await notificationDetails());
  }

  // NOTIF WHEN APP IN BACKGROUND
  showNotificationInBackground(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showNotification(title: notification.title, body: notification.body, payload: message.data['click_action']);
      }
    });
  }
  // NOTIF WHEN APP OPENED
  showNotificationInAppOpened(){
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showNotificationSnackBar(message.notification!.title!, message.notification!.body!, message.data['click_action']);
      }
    });
  }

}