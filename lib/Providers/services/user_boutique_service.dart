import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class UserBoutiqueService extends GetConnect {
  final MainController mainController = Get.put(MainController());
  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);

    getUserByDeviceId(
        mainController.deviceId.value, mainController.deviceModel.value);
  }

  //add user
  Future<Response<UserBoutiqueModel>> addUserBoutique(
      Map<String, dynamic> data) async {
    // print("======POST ADD USER BOUTIQUE=======");
    return post('/boutique/user/store', data,
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      Get.snackbar('Message', '${data['message']}');
      return UserBoutiqueModel.fromJson(data['data']);
    });
  }

  //update user
  Future<Response<UserBoutiqueModel>> updateUserBoutique(
      Map<String, dynamic> data) async {
    return post(
      '/boutique/user/update',
      data,
      decoder: (data) => UserBoutiqueModel.fromJson(data['data']),
    );
  }

  //get with device id
  Future<Response<List<UserBoutiqueModel>>> getUserByDeviceId(
      String deviceId, String deviceModel) async {
    return get(
      '/boutique/user/$deviceId/$deviceModel',
      headers: mainController.getLoggedHeaders(),
      decoder: (data) => List<UserBoutiqueModel>.from(
          data['data'].map((x) => UserBoutiqueModel.fromJson(x))),
    );
  }
}
