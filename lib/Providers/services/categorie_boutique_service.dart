import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class CategorieBoutiqueService extends GetConnect {
  final MainController mainController = Get.put(MainController());

  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    getAllCategorieBoutique();
    super.onInit();
  }

  //Get All Categorie Boutique
  Future<Response<List<CategorieBoutiqueModel>>>
      getAllCategorieBoutique() async {
    return await get("/boutique/categories",
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      return List<CategorieBoutiqueModel>.from(
          data['data'].map((x) => CategorieBoutiqueModel.fromJson(x)));
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
