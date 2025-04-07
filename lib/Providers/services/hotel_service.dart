import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class HotelService extends GetConnect {
  final MainController mainController = Get.put(MainController());

  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    super.onInit();
  }

//Get All Hotels
  /// Gets all hotels from the API.
  ///
  /// Sends a GET request to <code>/hotelsIndex</code> with the logged in user's
  /// headers and decodes the response into a list of [HotelModel]s.
  ///
  /// Returns a [Response] containing the list of [HotelModel]s.
  Future<Response<List<HotelModel>>> getAllHotel() {
    // print(httpClient.baseUrl);
    return get('/hotelsIndex',
        headers: mainController.getLoggedHeaders(),
        decoder: (data) => List<HotelModel>.from(
            data['data'].map((x) => HotelModel.fromJson(x))));
  }

//Get All Hotels Pub
  /// Gets all hotels from the API.
  Future<Response<List<HotelModel>>> getAllHotelPub() {
    // print(httpClient.baseUrl);
    return get('/hotelsIndexPub',
        headers: mainController.getLoggedHeaders(),
        decoder: (data) => List<HotelModel>.from(
            data['data'].map((x) => HotelModel.fromJson(x))));
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
      '/like_dislike_hotels',
      {"user_id": userId, "hotel_id": hotelId, "status": status},
      headers: mainController.getLoggedHeaders(),
      decoder: (data) => data['data'],
    );
  }

  //add Rating
  Future<Response<Map<String, dynamic>>> postRatingHotel(
    String userId,
    String hotelId,
    int rating,
  ) {
    return post('/rating_hotels',
        {"user_id": userId, "hotel_id": hotelId, "rating_note": rating},
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data);
      return data['data'];
    });
  }

  //Filtre Hotel Par Type Hootel
  Future<Response<List<HotelModel>>> postFiltreParTypeHotel(
      String typeHotelId, String min, String max) {
    return post('/hotels/filtre_type_hotel',
        {"type_hotel_id": typeHotelId, "min": min, "max": max},
        headers: mainController.getLoggedHeaders(),
        decoder: (data) => List<HotelModel>.from(
            data['data'].map((x) => HotelModel.fromJson(x))));
  }

  //Filtre Par Prix
  Future<Response<List<HotelModel>>> postFiltreParPrix(String min, String max) {
    return post('/hotels/filtre_prix', {"min": min, "max": max},
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data);
      return List<HotelModel>.from(
          data['data'].map((x) => HotelModel.fromJson(x)));
    });
  }
}
