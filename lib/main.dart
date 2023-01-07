import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app/Utils/app_constantes.dart';
import 'app/routes/app_pages.dart';
import 'app/widgets/alerte_widgets.dart';

// ECOUTE DES MESSAGES EN ARRIERE PLAN
Future<void> _messageHandler(RemoteMessage message) async {
  // print("msg "+message.toString());
  showNotificationSnackBar(message.notification!.title!, message.notification!.body!, message.data['click_action']);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INITIALISATION FIREBASE
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  // WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: mainColor,
        fontFamily: 'Roboto',
      ),
      title: "mon plateau",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
