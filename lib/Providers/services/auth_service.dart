import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Widgets/path_widget.dart';
import 'package:quickalert/models/quickalert_type.dart';

class AuthService extends GetConnect {
  final MainController mainController = Get.put(MainController());
  @override
  void onInit() {
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    super.onInit();
  }

  //Login with device Id
  Future<Response<AuthModel>> loginWithDeviceId(
          {String? deviceId, String? fcmToken, String? deviceModel}) =>
      post(
        '/login_device_id',
        {
          'device_id': deviceId,
          'cloud_messaging_token': fcmToken,
          'device_model': deviceModel
        },
        decoder: (auth) {
          // print(auth);
          return AuthModel.fromJson(auth['data']);
        },
      );

  //check with device Id
  Future<Response<AuthModel?>> checkWithDeviceId(
          {String? deviceId, String? deviceModel}) =>
      post('/check_deviceId', {
        'device_id': deviceId,
        'device_model': deviceModel
      }, decoder: (auth) {
        // print('======CHECK DEVICE ID WITH USER=======');
        // print({'device_id': deviceId, 'device_model': deviceModel});
        // print(auth);
        if (auth['success'] == false) return null;
        return AuthModel.fromJson(auth['data']);
      });

  //check Token is valid
  Future<Response> checkToken({String? token}) =>
      post('/check_token', {'token': token},
          headers: mainController.getLoggedHeaders(), decoder: (auth) {
        // print(auth);
        return auth['message'] == 'Unauthenticated.'
            ? true
            : auth['data']['is_expirate'];
      });

  //refresh Token With device Id
  Future<Response<AuthModel>> refreshDevice(
          {String? deviceId, String? deviceModel}) =>
      post('/refresh_token', {
        'device_id': deviceId,
        'device_model': deviceModel
      }, decoder: (auth) {
        // print(auth);
        return AuthModel.fromJson(auth['data']);
      });

  //refresh fcm Token
  Future <Response<Map<String, dynamic>>> refreshFcmToken({String? fcmToken, String? deviceId, String? deviceModel}) async =>post('/refresh_fcm_token', {
    'fcm_token': fcmToken,
    'device_id': deviceId,
    'device_model': deviceModel
  }, headers: mainController.getLoggedHeaders(), decoder: (auth) {
   // print(deviceModel);
   // print(deviceId);
   //  print('============REFRESH FCM TOKEN==============3');
   //  print(auth);
    return auth;
  });

}



// 
