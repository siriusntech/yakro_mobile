import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class CategorieVtService extends GetConnect {
  final MainController mainController = Get.put(MainController());
  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    getAllCategorieVt();
    super.onInit();
  }

  //get All CategorieVt
  Future<Response<List<CategorieVtModel>>> getAllCategorieVt() =>
      get('/categories_vts',
          headers: mainController.getLoggedHeaders(),
          decoder: (data) => List<CategorieVtModel>.from(
              data['data'].map((x) => CategorieVtModel.fromJson(x))));
}
