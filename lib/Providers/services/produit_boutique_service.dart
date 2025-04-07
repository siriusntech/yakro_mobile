import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class ProduitBoutiqueService extends GetConnect {
  final MainController mainController = Get.put(MainController());
  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    getAllProduitBoutique();
    getAllProduitBoutiqueByPub();
    super.onInit();
  }

  //Get All Produit Boutique
  Future<Response<List<ProduitBoutiqueModel>>> getAllProduitBoutique() async {
    return await get('/boutique/produits',
        headers: mainController.getLoggedHeaders(),
        decoder: (data) => List<ProduitBoutiqueModel>.from(
            data['data'].map((x) => ProduitBoutiqueModel.fromJson(x))));
  }

  //Get All Produit Boutique By Categorie Boutique
  Future<Response<List<ProduitBoutiqueModel>>>
      getAllProduitByCategorieBoutiqueId(int id) async {
    // print('======GET ALL PRODUIT BOUTIQUE BY CATEGORIE BOUTIQUE=======');
    return await get("/boutique/categorie/$id/produits",
        headers: mainController.getLoggedHeaders(),
        decoder: (data) => List<ProduitBoutiqueModel>.from(
            data['data'].map((x) => ProduitBoutiqueModel.fromJson(x))));
  }

  //Get Produit by Pub
  Future<Response<List<ProduitBoutiqueModel>>>
      getAllProduitBoutiqueByPub() async {
    // print('======GET ALL PRODUIT BOUTIQUE BY PUB=======');
    return await get("/boutique/produit/pub",
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data);
      return List<ProduitBoutiqueModel>.from(
          data['data'].map((x) => ProduitBoutiqueModel.fromJson(x)));
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
