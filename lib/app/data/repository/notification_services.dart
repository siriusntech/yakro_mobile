
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jaime_yakro/app/data/repository/main_services.dart';
import 'package:jaime_yakro/app/modules/auth/controllers/auth_controller.dart';

import '../../widgets/alerte_widgets.dart';


class NotificationServices{
AuthController authController = AuthController();

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


  showNotificationDetected(){
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      // si le token se met a jour
            authController.initCloudMessaging();
            int user_id = authController.user_id.value;
          MainServices.setUserCloudMessagingToken(user_id, event);
    });
  }


 




  }