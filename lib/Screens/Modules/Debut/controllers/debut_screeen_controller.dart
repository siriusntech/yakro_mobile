import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
// import 'package:jaime_yakro/Providers/controllers/main_controller.dart';

class DebutScreeenController extends GetxController {
  var activePage = 0.obs;
  RxBool isAcceptCondition = false.obs;
  RxString deviceId = "".obs;
  RxString deviceModel = "".obs;
  RxString fcmToken = "".obs;
  var conditionofuse =
      """J'aime Yakro est une application communautaire qui permet de mieux connaitre la commune à travers son histoire et être informé de toutes les actualités la concernant.
  Vous pouvez aussi trouver tous les espaces importants de la commune tels que les pharmacies de garde, commerces, restaurants et autres.
   Il est interdits d'utiliser les mots inappropriés comme les injures et propos haineux sous peine de voir son compte bloqué.
  """
          .obs;

  var politique =
      """Aucune authentification n'est neccessaire pour utiliser l'application."""
          .obs;
  final MainController mainController = Get.put(MainController());



  //FIREBASE CLOUD MESSAGING CONFIG
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  initCloudMessaging() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    settings;
    await _firebaseMessaging.getToken().then((token) {
      fcmToken.value = token.toString();
      update();
    });
  }

  Future<String>refreshFcmToken() async {
    // print('==============REFRESH FCM TOKEN==============');
    await _firebaseMessaging.getToken().then((token) {
      // print(token);
      fcmToken.value = token.toString();
      update();
    });
    // print(fcmToken.value);
    return fcmToken.value;
  }

  void acceptCondition(bool value) {
    isAcceptCondition.value = !isAcceptCondition.value;
    refreshFcmToken();
    _getDeviceId();
    _getDeviceModel();
  }

  //GET DEVICE ID
  Future<String?> _getDeviceId() async {
    // print('==============GET DEVICE ID==============');
    var deviceInfo = DeviceInfoPlugin();
    if (GetPlatform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (GetPlatform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      // print(androidDeviceInfo.id);
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  //GET DEVICE MODEL
  Future<String?> _getDeviceModel() async {
    // print('==============GET DEVICE MODEL==============');
    var deviceInfo = DeviceInfoPlugin();
    if (GetPlatform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.model; // unique ID on iOS
    } else if (GetPlatform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      // print(androidDeviceInfo.model);
      return androidDeviceInfo.model; // unique ID on Android
    }
    return null;
  }

  @override
  void onInit() async {
    isAcceptCondition.value = false;

    //Get Device ID
    String? deviceid = await _getDeviceId();
    deviceId.value = deviceid.toString();
    //Get Device Model
    String? devicemodel = await _getDeviceModel();
    deviceModel.value = devicemodel.toString();

    update();
    await initCloudMessaging();
    refreshFcmToken();
    //Get Put Service
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
