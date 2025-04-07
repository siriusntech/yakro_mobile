import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class CommerceService extends GetConnect {
  final MainController mainController = Get.put(MainController());
  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    getAllCommerce();
    super.onInit();
  }

  //Get All Commerces
  Future<Response<List<CommerceModel>>> getAllCommerce() {
    return get('/commerces', headers: mainController.getLoggedHeaders(),
        decoder: (data) {
      return List<CommerceModel>.from(
          data['data'].map((x) => CommerceModel.fromJson(x)));
    });
  }

  //add Rating
  Future<Response<Map<String, dynamic>>> postRatingCommerce(
    String userId,
    String hotelId,
    int rating,
  ) {
    return post('/rating_commerces',
        {"user_id": userId, "commerce_id": hotelId, "rating_note": rating},
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data);
      return data['data'];
    });
  }

  //Filtre Commerce Par Type Commerce
  Future<Response<List<CommerceModel>>> postFiltreParTypeCommerce(
      String typeCommerceId) {
    return post(
        '/commerces/filtre_type_commerce', {"type_commerce_id": typeCommerceId},
        headers: mainController.getLoggedHeaders(),
        decoder: (data) => List<CommerceModel>.from(
            data['data'].map((x) => CommerceModel.fromJson(x))));
  }

  //Filtre Commerce Par Specialite
  Future<Response<List<CommerceModel>>> postFiltreParSpecialite(
      String specialiteId) {
    return post('/commerces/filtre_specialite', {"specialite_id": specialiteId},
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      return List<CommerceModel>.from(
          data['data'].map((x) => CommerceModel.fromJson(x)));
    });
  }

  //Filtre Specialité et Type Commerce
  Future<Response<List<CommerceModel>>> postFiltreParSpecialiteEtTypeCommerce(
      String specialiteId, String typeCommerceId) {
    return post(
        '/commerces/filtre_specialite_type_commerce',
        {
          "specialite_commerce_id": specialiteId,
          "type_commerce_id": typeCommerceId
        },
        headers: mainController.getLoggedHeaders(),
        decoder: (data) => List<CommerceModel>.from(
            data['data'].map((x) => CommerceModel.fromJson(x))));
  }

  //post favorite
  /// Sends a POST request to store a favorite item with the specified category type and ID.
  ///
  /// The request is sent to the '/store_favoris_with_type_categorie/:userId' endpoint with
  /// the provided `typeCategorie`, `typeCategorieId`, `userId`, and `favoris` status.
  ///
  /// Parameters:
  /// - `typeCategorie`: The category type of the item to be favorited.
  /// - `typeCategorieId`: The ID of the category type.
  /// - `userId`: The ID of the user making the request.
  /// - `favoris`: A boolean indicating whether the item is a favorite.
  ///
  /// Returns a `Future` that resolves to a `Response` containing a `FavorisModel` object.
  Future<Response<FavorisModel>> postFavorite(
      {required String typeCategorie,
      required String typeCategorieId,
      required String userId,
      required bool favoris}) {
    return post(
        '/store_favoris_with_type_categorie/$userId',
        {
          "type_categorie": typeCategorie,
          "type_categorie_id": typeCategorieId,
          "favoris": favoris == true ? "1" : "0"
        },
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data);
      return FavorisModel.fromJson(data['data']);
    });
  }
}
