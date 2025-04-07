import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class TokenController extends GetxController {
  final RxBool tokenLoading = false.obs;
  Rx<AuthModel?> authModel = Rx<AuthModel?>(null);

  final MainController _mainController = Get.find();
  final AuthService _authService = AuthService();

  @override
  void onInit() {
    _mainController.onInit();
    _mainController.getAuthInfo();
    _authService.onInit();
    super.onInit();
  }

  //Check Device Id
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
}
