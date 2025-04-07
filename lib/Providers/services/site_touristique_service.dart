import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class SiteTouristiqueService extends GetConnect {
  final MainController mainController = Get.put(MainController());

  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    getAllSiteTouristique();
    super.onInit();
  }

  //Get all Site Touristique
  Future<Response<List<SiteTouristiqueModel>>> getAllSiteTouristique() async {
    // print("==============GET ALL SITE TOURISTIQUE==============");
    // print(httpClient.baseUrl);
    return get('/vt_Index', headers: mainController.getLoggedHeaders(),
        decoder: (data) {
      // print(data['data']);
      return List<SiteTouristiqueModel>.from(
          data['data'].map((x) => SiteTouristiqueModel.fromJson(x)));
    });
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

  //Add Like and Dislike
  Future<Response<Map<String, dynamic>>> addLikeAndDislike(
    String userId,
    String hotelId,
    String status,
  ) {
    return post(
      '/like_dislike_sites_touristiques',
      {"user_id": userId, "hotel_id": hotelId, "status": status},
      headers: mainController.getLoggedHeaders(),
      decoder: (data) => data['data'],
    );
  }

  //add Rating
  Future<Response<Map<String, dynamic>>> postRatingHotel(
    String hotelId,
    int rating,
  ) {
    return post(
        '/rating_vt', {"site_touristique_id": hotelId, "rating_note": rating},
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data);
      return data['data'];
    });
  }

  //Filtre Par Prix
  Future<Response<List<SiteTouristiqueModel>>> postFiltreParPrix(
      String min, String max) {
    return post('/vt/filtre_prix', {"min": min, "max": max},
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data);
      return List<SiteTouristiqueModel>.from(
          data['data'].map((x) => SiteTouristiqueModel.fromJson(x)));
    });
  }

  //Filtre par Categorie
  Future<Response<List<SiteTouristiqueModel>>> postFiltreParCategorie(
      String categorieId, String min, String max) {
    return post('/vt/filtre_categorie',
        {"categorie_id": categorieId, "min": min, "max": max},
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data);
      return List<SiteTouristiqueModel>.from(
          data['data'].map((x) => SiteTouristiqueModel.fromJson(x)));
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
