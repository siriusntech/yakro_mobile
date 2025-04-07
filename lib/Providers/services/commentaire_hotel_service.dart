import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class CommentaireService extends GetConnect {
  final MainController mainController = Get.put(MainController());

  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    super.onInit();
  }

  //Add Commentaire Hotel
  Future<Response<CommentaireModel>> addCommentaireHotel(
      String? commentaire, String? userId, String? hotelId) {
    // print("======POST ADD COMMENTAIRE HOTEL=======");
    return post('/commentaires_hotels',
        {"texte": commentaire, "user_id": userId, "hotel_id": hotelId},
        headers: mainController.getLoggedHeaders(),
        decoder: (data) => CommentaireModel.fromJson(data['data']));
  }

  //Get All Commentaire Hotel
  /// Gets all commentaires from the API for a given hotel id.
  ///
  /// Sends a GET request to <code>/commentaires_hotels/:hotelId</code> with the
  /// logged in user's headers and decodes the response into a list of
  /// [CommentaireModel]s.
  ///
  /// Returns a [Response] containing the list of [CommentaireModel]s.
  Future<Response<List<CommentaireModel>>> getAllCommentaireHotel(int hotelId) {
    // print(
    //     "================GET ALL COMMENTAIRE HOTEL $hotelId ======================");
    return get('/commentaires_hotels/$hotelId',
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data);
      return List<CommentaireModel>.from(
          data['data'].map((x) => CommentaireModel.fromJson(x)));
    });
  }

  // Add Commentaire Commerce
  Future<Response<CommentaireModel>> addCommentaireCommerce(
      String? commentaire, String? userId, String? commerceId) {
    // print("======POST ADD COMMENTAIRE COMMERCE=======");
    return post('/commentaires_commerces',
        {"texte": commentaire, "user_id": userId, "commerce_id": commerceId},
        headers: mainController.getLoggedHeaders(),
        decoder: (data) => CommentaireModel.fromJson(data['data']));
  }

  //Get All Commentaire Commerce
  /// Gets all commentaires from the API for a given commerce id.
  ///
  /// Sends a GET request to <code>/commentaires_commerces/:commerceId</code> with the
  /// logged in user's headers and decodes the response into a list of
  /// [CommentaireModel]s.
  ///
  /// Returns a [Response] containing the list of [CommentaireHotelModel]s.
  Future<Response<List<CommentaireModel>>> getAllCommentaireCommerce(
      int commerceId) {
    // print(
    //     "================GET ALL COMMENTAIRE COMMERCE $commerceId ======================");
    return get('/commentaires_commerces/$commerceId',
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data);
      return List<CommentaireModel>.from(
          data['data'].map((x) => CommentaireModel.fromJson(x)));
    });
  }
}
