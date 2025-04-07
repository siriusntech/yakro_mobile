import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class TypeCommerceService extends GetConnect {
  final MainController mainController = Get.put(MainController());

  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    super.onInit();
  }

  Future<Response<List<TypeCommerceModel>>> getAllTypeCommerce() => get(
        '/type_commerces',
        headers: mainController.getLoggedHeaders(),
        decoder: (data) => List<TypeCommerceModel>.from(
            data['data'].map((x) => TypeCommerceModel.fromJson(x))),
      );
}
