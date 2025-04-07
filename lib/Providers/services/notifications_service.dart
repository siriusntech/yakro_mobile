import 'dart:io';
// import 'package:educ_info/Screens/notification_screen/notification_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/routes/path_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationServices {
  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      // handle interaction when app is active for android
      handleMessage(context, message);
    });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (kDebugMode) {
        // print("notifications title:${notification!.title}");
        // print("notifications body:${notification.body}");
        // print('count:${android!.count}');
        // print('data:${message.data.toString()}');
      }

      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        // print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        // print('user granted provisional permission');
      }
    } else {
      //appsetting.AppSettings.openNotificationSettings();
      if (kDebugMode) {
        // print('user denied permission');
      }
    }
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification'),
      enableLights: true,
      // ledColor: const Color.fromARGB(255, 255, 0, 0),
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
      sound: const RawResourceAndroidNotificationSound('notification'),
      enableLights: true,
      // ledColor: const Color.fromARGB(255, 255, 0, 0),
      icon: '@mipmap/ic_launcher',
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        // print('refresh');
      }
    });
  }

  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
print(message.data);
    if (message.data['type'] == '/hotels_index') {
      Get.toNamed(AppRoutes.hotelScreen);
    } else if (message.data['type'] == '/commerce') {
      Get.toNamed(AppRoutes.commerceScreen);
    } else if (message.data['type'] == '/home') {
      Get.toNamed(AppRoutes.homeScreen);
    } else if (message.data['type'] == '/pharmacie') {
      Get.toNamed(AppRoutes.pharmacieScreen);
    } else if (message.data['type'] == '/boutique') {
      Get.toNamed(AppRoutes.boutiqueScreen);
    } else if (message.data['type'] == '/diffusion') {
      Get.toNamed(AppRoutes.evenementScreen);
    } else if (message.data['type'] == '/vt_index') {
      Get.toNamed(AppRoutes.siteTouristiqueScreen);
    } else if (message.data['type'] == '/conciergerie_new_course') {
      Get.toNamed(AppRoutes.notificationCourseConciergerie,
          arguments: message.data);
    } else {
      Get.toNamed(AppRoutes.notificationScreen, arguments: message.data);
    }
  }

  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // function init
  void init(BuildContext context) {
    requestNotificationPermission();
    forgroundMessage();
    firebaseInit(context);
    setupInteractMessage(context);
    isTokenRefresh();

    getDeviceToken().then((value) async {
      if (kDebugMode) {
        // print('device token');
        // print(value);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('my_Token', value);
      }
    });
  }
}
