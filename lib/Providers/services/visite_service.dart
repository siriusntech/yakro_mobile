import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class VisiteService extends GetConnect {
  final MainController _mainController = Get.put(MainController());
  @override
  void onInit() {
    _mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    super.onInit();
  }

  //add visite
  Future<Response<bool>> addVisite(String module) async {
    // print("======POST ADD VISITE=======");
    return post('/add-visite-count/$module', {},
        headers: _mainController.getLoggedHeaders(),
        decoder: (data) => data['data']);
  }
}
