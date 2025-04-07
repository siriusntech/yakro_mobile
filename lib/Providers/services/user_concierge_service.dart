import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class UserConciergeService extends GetConnect {
  final MainController mainController = Get.put(MainController());

  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    super.onInit();
  }

  //create User Concierge
  Future<Response<UserBoutiqueModel>> createUserConcierge(
      Map<String, dynamic> data) async {
    return post('/conciergerie/user/store', data,
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      print(data['message']);
      // Get.snackbar('Erreur', '${data['message']}');
      return UserBoutiqueModel.fromJson(data['data']);
    });
  }

  Future<Response<List<UserBoutiqueModel>>> getUserByDeviceId(
      String deviceId, String deviceModel) async {
    return get(
      '/conciergerie/user/$deviceId/$deviceModel',
      headers: mainController.getLoggedHeaders(),
      decoder: (data) {
        return List<UserBoutiqueModel>.from(
            data['data'].map((x) => UserBoutiqueModel.fromJson(x)));
      },
    );
  }
}
