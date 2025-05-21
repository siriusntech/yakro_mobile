import 'dart:io';

import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {
  final RxString deviceId = ''.obs;
  final RxString deviceModel = ''.obs;
  final RxString fcmToken = ''.obs;
  final RxString userId = ''.obs;
  final RxString authToken = ''.obs;
  final RxBool hotelEnable = false.obs;
  final RxBool boutiqueEnable = false.obs;
  final RxBool restaurantEnable = false.obs;
  final RxBool coursierEnable = false.obs;
  final RxBool conciergeEnable = false.obs;
  final RxBool pharmacieEnable = false.obs;
  final RxBool bonPlanEnable = false.obs;
  final RxBool tourismeEnable = false.obs;
  final RxBool coursierConciergeConnected = false.obs;
  final RxBool hotelReductionEnable = false.obs;
  final Rx<Rx<Map>> headers = Rx({}).obs;
  RxBool connectivity = false.obs;

  static late SharedPreferences _sharedPreferences;
  Future<SharedPreferences> initSharedPreference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences;
  }

  final NotificationController _notificationController =
      Get.put(NotificationController());

  @override
  void onInit() {
    initSharedPreference().then((value) {
      getDeviceIdShared();
      getFcmTokenShared();
      getUserIdShared();
      getDeviceModelShared();
      getAuthTokenShared();
      getCoursierConciergeConnected();
      getModulesInfo();
    });
    _notificationController.onInit();

    super.onInit();
  }

  void saveSharedPreference(
      {required String deviceId,
      required String fcmToken,
      required String userId,
      required String authToken,
      required String deviceModel}) {
    _sharedPreferences.setString('deviceId', deviceId);
    _sharedPreferences.setString('fcmToken', fcmToken);
    _sharedPreferences.setString('userId', userId);
    _sharedPreferences.setString('authToken', authToken);
    _sharedPreferences.setString('deviceModel', deviceModel.toString());
  }

  void saveSharedPreferenceFcmToken({required String fcmToken}) {
    _sharedPreferences.setString('fcmToken', fcmToken);
  }

  void saveSharedPreferenceModules(
      {required bool hotelEnable,
      required bool boutiqueEnable,
      required bool restaurantEnable,
      required bool conciergerieEnable,
      required bool pharmacieEnable,
      required bool bonPlanEnable,
      required bool tourismeEnable,
      required bool hotelReductionEnable}) {
    _sharedPreferences.setBool('hotelEnable', hotelEnable);
    _sharedPreferences.setBool('boutiqueEnable', boutiqueEnable);
    _sharedPreferences.setBool('restaurantEnable', restaurantEnable);
    _sharedPreferences.setBool('conciergeEnable', conciergerieEnable);
    _sharedPreferences.setBool('pharmacieEnable', pharmacieEnable);
    _sharedPreferences.setBool('bonPlanEnable', bonPlanEnable);
    _sharedPreferences.setBool('tourismeEnable', tourismeEnable);
    _sharedPreferences.setBool('hotelReductionEnable', hotelReductionEnable);
  }

  //get SharedPreference deviceId

  Future<String> getDeviceIdShared() {
    deviceId.value = _sharedPreferences.getString('deviceId') ?? '';
    setDeviceId(deviceId.value);
    update();
    return Future.value(deviceId.value);
  }

  //get SharedPreference deviceModel

  Future<String> getDeviceModelShared() {
    deviceModel.value = _sharedPreferences.getString('deviceModel') ?? '';
    update();
    return Future.value(deviceModel.value);
  }

  //get SharedPreference fcmToken
  Future<String> getFcmTokenShared() {
    fcmToken.value = _sharedPreferences.getString('fcmToken') ?? '';
    // print(fcmToken.value);
    update();
    return Future.value(fcmToken.value);
  }

  //get SharedPreference userId
  Future<String> getUserIdShared() {
    userId.value = _sharedPreferences.getString('userId') ?? '';
    update();
    return Future.value(userId.value);
  }

  //get SharedPreference authToken
  Future<String> getAuthTokenShared() {
    authToken.value = _sharedPreferences.getString('authToken') ?? '';
    // print('===========TOKEN SHARED PREF');
    // print(authToken.value);
    update();
    return Future.value(authToken.value);
  }

  //get Auth Info
  Future<void> getAuthInfo() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    authToken.value = _sharedPreferences.getString('authToken') ?? '';
    userId.value = _sharedPreferences.getString('userId') ?? '';
    deviceId.value = _sharedPreferences.getString('deviceId') ?? '';
    fcmToken.value = _sharedPreferences.getString('fcmToken') ?? '';
    deviceModel.value = _sharedPreferences.getString('deviceModel') ?? '';
    update();
  }

  Future<void> getModulesInfo() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    hotelEnable.value = _sharedPreferences.getBool('hotelEnable') ?? false;
    // print("hotelEnable : ${hotelEnable.value}");
    boutiqueEnable.value =
        _sharedPreferences.getBool('boutiqueEnable') ?? false;
    // print("boutiqueEnable : ${boutiqueEnable.value}");
    restaurantEnable.value =
        _sharedPreferences.getBool('restaurantEnable') ?? false;
    // print("restaurantEnable : ${restaurantEnable.value}");
    conciergeEnable.value =
        _sharedPreferences.getBool('conciergeEnable') ?? false;
    // print("conciergeEnable : ${conciergeEnable.value}");
    pharmacieEnable.value =
        _sharedPreferences.getBool('pharmacieEnable') ?? false;
    // print("pharmacieEnable : ${pharmacieEnable.value}");
    bonPlanEnable.value = _sharedPreferences.getBool('bonPlanEnable') ?? false;
    // print("bonPlanEnable : ${bonPlanEnable.value}");
    tourismeEnable.value =
        _sharedPreferences.getBool('tourismeEnable') ?? false;
    // print("tourismeEnable : ${tourismeEnable.value}");
    hotelReductionEnable.value =
        _sharedPreferences.getBool('hotelReductionEnable') ?? false;
    update();
  }

  void setModuleEnabled(
      {required bool hotelEnable,
      required bool boutiqueEnable,
      required bool restaurantEnable,
      required bool conciergerieEnable,
      required bool pharmacieEnable,
      required bool bonPlanEnable,
      required bool tourismeEnable,
      required bool hotelReductionEnable}) {
    this.hotelEnable.value = hotelEnable;
    this.boutiqueEnable.value = boutiqueEnable;
    this.restaurantEnable.value = restaurantEnable;
    this.conciergeEnable.value = conciergerieEnable;
    this.pharmacieEnable.value = pharmacieEnable;
    this.bonPlanEnable.value = bonPlanEnable;
    this.tourismeEnable.value = tourismeEnable;
    this.hotelReductionEnable.value = hotelReductionEnable;
    update();
  }

  getLoggedHeaders() {
    // print(authToken.value);
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authToken.value}',
      'Connection': 'keep-alive',
    };
  }

  Map<String, dynamic> getNotLoggedHeaders() {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  //check connectiviy
  Future<bool> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connectivity.value = true;
        return true;
      } else {
        connectivity.value = false;
        return false;
      }
    } on SocketException catch (_) {
      connectivity.value = false;
      return false;
    }
  }

  //SETTERS SHARED PREFERENCE
  void setCoursierConnected(bool coursierConcierge) => {
        _sharedPreferences.setBool(
            'coursier_concierge_connected', coursierConcierge),
        // print(getCoursierConciergeConnected())
      };

  //SETTERS
  void setDeviceId(String deviceId) => this.deviceId.value = deviceId;
  void setDeviceModel(String deviceModel) =>
      this.deviceModel.value = deviceModel;

//GETTERS
  String getDeviceId() => deviceId.value;
  String getDeviceModel() => deviceModel.value;
  bool getCoursierConciergeConnected() =>
      _sharedPreferences.getBool('coursier_concierge_connected') ?? false;
  bool getHotelEnable() => hotelEnable.value;
  bool getBoutiqueEnable() => boutiqueEnable.value;
  bool getRestaurantEnable() => restaurantEnable.value;
  bool getConciergeEnable() => conciergeEnable.value;
  bool getPharmacieEnable() => pharmacieEnable.value;
  bool getBonPlanEnable() => bonPlanEnable.value;
  bool getTourismeEnable() => tourismeEnable.value;
  bool getHotelReductionEnable() => hotelReductionEnable.value;
}
