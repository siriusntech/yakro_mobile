import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/controllers/path_controller.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/routes/path_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  final MainController _mainController = Get.put(MainController());
  final AuthController _tokenController = Get.put(AuthController());
  final tokenController = Get.put(TokenController());
  final ModuleController moduleController = Get.put(ModuleController());
  final SliderApiController sliderApiController =
  Get.put(SliderApiController());
  void navigateToHome() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    _mainController.getAuthInfo();

    storage;
    // print("==================VEIRIFYING USER==================");
    // print(_mainController.authToken.value);
    await Future.delayed(const Duration(seconds: 5), () {});
    if (_mainController.authToken.value == "") {
      // print("==================NO USER==================");
      Get.offAllNamed(AppRoutes.debutScreen);
    } else if (_mainController.authToken.value != "") {
      // print("==================USER FOUND==================");
      // print(_mainController.authToken.value);
      tokenController.checkDeviceId();
      tokenController.checkToken();
      Get.offAllNamed(AppRoutes.homeScreen);
    }
    // Get.offAllNamed(AppRoutes.homeScreen);
  }

  @override
  void onInit() {
    _mainController.onInit();
    _tokenController.onInit();
    AnalyticsService()
        .logScreenView('SplashScreen', 'SplashScreen', {
      'screen_name': 'SplashScreen',
      'user_id': _mainController.userId.value.toString(),
      'device_id': _mainController.deviceId.value.toString(),
    });

    _tokenController.refreshFcmToken();
    sliderApiController.onInit();
    moduleController.onInit();
    moduleController.getModules();
    sliderApiController.getAllSlider();
    navigateToHome();
    super.onInit();
  }

  @override
  void onReady() {
    sliderApiController.onInit();
    moduleController.onInit();
    moduleController.getModules();
    sliderApiController.getAllSlider();
    super.onReady();
  }

  @override
  void onClose() {
    sliderApiController.onInit();
    moduleController.onInit();
    moduleController.getModules();
    sliderApiController.getAllSlider();
    super.onClose();
  }
}
