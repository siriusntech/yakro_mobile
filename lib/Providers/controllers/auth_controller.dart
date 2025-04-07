import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Debut/path_debut.dart';
import 'package:jaime_yakro/Screens/Widgets/path_widget.dart';
import 'package:jaime_yakro/routes/path_route.dart';
import 'package:quickalert/models/quickalert_type.dart';

class AuthController extends GetxController {
  final RxBool authLoading = false.obs;
  Rx<AuthModel?> authModel = Rx<AuthModel?>(null);

  final AuthService _authService = AuthService();

  final DebutScreeenController _debutScreeenController =
      Get.put(DebutScreeenController());
  final MainController _mainController = Get.put(MainController());
  final ModuleController _moduleController = Get.put(ModuleController());
  @override
  void onInit() {
    _mainController.onInit();
    _moduleController.onInit();
    _mainController.getAuthInfo();
    _authService.onInit();
    _debutScreeenController.onInit();
    _moduleController.getModules();
    checkDeviceId();
    // checkToken();
    // checkDeviceId();
    super.onInit();
  }

  //Login with device Id
  Future<void> loginWithDeviceId(BuildContext context) async {
    _moduleController.getModules();
    authLoading(true);
    quickAlertDialog(
      context,
      QuickAlertType.loading,
      color: ConstColors.vertColorFonce,
      message: "Veuillez patientez...",
      title: "Loading",
      onConfirmBtnTap: () => Navigator.pop(context),
    );

    try {
      var response = await _authService.loginWithDeviceId(
        deviceId: _debutScreeenController.deviceId.value,
        fcmToken: _debutScreeenController.fcmToken.value,
        deviceModel: _debutScreeenController.deviceModel.value,
      );
      _moduleController.getModules();
      authLoading.value = false;

      if (int.parse(response.statusCode.toString()) == 200 ||
          response.statusCode == 200) {
        authModel.value = response.body;
        update();
        _mainController.saveSharedPreference(
          deviceId: _debutScreeenController.deviceId.value,
          fcmToken: _debutScreeenController.fcmToken.value,
          userId: authModel.value!.userModel!.id.toString(),
          authToken: authModel.value!.token.toString(),
          deviceModel: _debutScreeenController.deviceModel.value,
        );

        authLoading(false);
        Get.back();
        quickAlertDialog(context, QuickAlertType.success,
            message: "Login Success",
            title: "Success",
            color: ConstColors.vertColorFonce,
            onConfirmBtnTap: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.homeScreen,
                  (route) => false,
                ));
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.homeScreen,
            (route) => false,
          );
        });
      } else {
        Get.back();
        quickAlertDialog(context, QuickAlertType.error,
            message: "Login failed",
            title: "Error",
            color: ConstColors.vertColorFonce,
            onConfirmBtnTap: () => Navigator.pop(context));
      }
    } catch (e) {
      Get.back();
      quickAlertDialog(
        context,
        QuickAlertType.error,
        color: ConstColors.vertColorFonce,
        message: e.toString(),
        title: "Error",
        onConfirmBtnTap: () => Navigator.pop(context),
      );
      authLoading(false);
    }
  }

  //Check Device Id
  Future<void> checkDeviceId() async {
    // print('======CHECK DEVICE ID WITH USER=======');
    // print(_mainController.deviceId);
    var response = await _authService.checkWithDeviceId(
      deviceId: _mainController.deviceId.value,
      deviceModel: _mainController.deviceModel.value,
    );
    // print(response.body);
    authModel.value = response.body;
    update();
  }

  Future<void> checkToken() async {
    // print('======CHECK TOKEN WITH USER=======');
    var response = await _authService.checkToken(
      token: _mainController.authToken.value,
    );
// print(response.body);
    if (response.body == true) {
      // print('=============REFRESH DEVICE ID WITH USER==============');
      refreshDevice();
    }
    update();
  }

  //Refresh Token Device
  Future<void> refreshDevice() async {
    // print('=========REFRESH DEVICE ID WITH USER==============');
    var response = await _authService.refreshDevice(
        deviceId: _mainController.deviceId.value,
        deviceModel: _mainController.deviceModel.value);
    if (int.parse(response.statusCode.toString()) == 200 ||
        response.statusCode == 200) {
      authModel.value = response.body;
      update();
      _mainController.saveSharedPreference(
        deviceId: _mainController.deviceId.value,
        fcmToken: _mainController.fcmToken.value,
        userId: authModel.value!.userModel!.id.toString(),
        authToken: authModel.value!.token.toString(),
        deviceModel: _mainController.deviceModel.value,
      );
    }
  }

  //Refresh FCM Token
  Future<void> refreshFcmToken() async {
    // print('============REFRESH FCM TOKEN==============');
    var response = await _debutScreeenController.refreshFcmToken();
    if(response != _mainController.fcmToken.value){
      _mainController.saveSharedPreferenceFcmToken(
          fcmToken: response);
      var response2 = await _authService.refreshFcmToken(
      fcmToken: response, deviceModel: _mainController.deviceModel.value, deviceId: _mainController.deviceId.value);
      if(response2.statusCode == 200){
        _mainController.fcmToken.value = _debutScreeenController.fcmToken.value;
        update();
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
