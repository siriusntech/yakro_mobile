import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Providers/services/notification_service.dart';
import 'package:jaime_yakro/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'routes/path_route.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services...
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService().init(); //
  await NotificationService().requestIOSPermissions(); //

  Get.put(MainController());
  Get.put(ModuleController());
  Get.put(SliderApiController());
  Get.put(ProduitBoutiqueController());
  Get.put(NotificationController());


  // INITIALISATION FIREBASE
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // INITIALISATION ANALYTICS
  AnalyticsService().getAnalytics().setAnalyticsCollectionEnabled(true);
  FirebaseAnalytics.instance.logEvent(name: 'open_app');
  // INITIALISATION DEVICE
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));

  // INITIALISATION THEME
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  // INITIALISATION DATE
  initializeDateFormatting('fr_FR', null).then((_) => runApp(const MyApp()));

  // INITIALISATION HTTP
  HttpOverrides.global = MyHttpOverrides();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Get.put(SliderApiController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: ConstColors.vert_colorFonce,
        fontFamily: 'Roboto',
        iconButtonTheme: const IconButtonThemeData(
            style:
                ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.white))),
        appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            elevation: 0,
            toolbarTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
        tabBarTheme: const TabBarTheme(
            labelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ),
      title: "J'aime Yakro",
      navigatorObservers: <NavigatorObserver>[
        AnalyticsService().getAnalyticsObserver(),
      ],
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
