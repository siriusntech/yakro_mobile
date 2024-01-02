import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jaime_yakro/app/models/AffichageHotelRestaurant.dart';
import 'package:jaime_yakro/app/models/restaurant_type_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/main_controller.dart';
import '../../data/repository/auth_service.dart';
import '../../data/repository/data/Env.dart';
import '../../data/repository/data/api_status.dart';
import '../../models/CommentaireNote.dart';
import '../../models/restaurant_model.dart';
import 'package:get/get.dart';

class RestaurantServices {
  static MainController settingsCtrl = Get.put(MainController());

  // static final String apiUrl = settingsCtrl.baseUrl+'commerces';

  static Future<Object> getCommerces() async {
    var headers = await AuthService.getLoggedHeaders();
    final apiUrl = settingsCtrl.baseUrl + 'commerces';
    var url = Uri.parse(apiUrl);
    print(url);
    try {
      var response = await http.get(url, headers: headers);
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        print('voir getRestaurant: ' + response.body.toString());
        return Success(response: restaurantFromJson(response.body));
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connection internet");
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connection internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalid');
    } catch (e) {
      return Failure(
          code: UNKNOWN_ERROR,
          errorResponse: 'Erreur inconnue ' + e.toString());
    }
  }

  static Future<Object> getUnReadCommerces() async {
    var headers = await AuthService.getLoggedHeaders();
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_id = storage.getInt('user_id') ?? null;
    var url = Uri.parse(settingsCtrl.baseUrl + 'un_read_commerces/$user_id');
    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return Success(response: restaurantFromJson(response.body));
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connection internet");
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connection internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalid');
    } catch (e) {
      return Failure(
          code: UNKNOWN_ERROR,
          errorResponse: 'Erreur inconnue ' + e.toString());
    }
  }

  static getCommercesByType(type) async {
    try {
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(
          settingsCtrl.baseUrl + "commerces_by_type/${type.toString()}");
      var response = await http.get(url, headers: headers);
      print('getCommercesByType: '+response.body.toString());
      if (response.statusCode == 200) {
        return Success(response: restaurantFromJson(response.body));

      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connection internet");
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connection internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalid');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }
  }

  static getCommercesByNom(nom) async {
    try {
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(settingsCtrl.baseUrl + "commerces_by_nom/$nom");
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return Success(response: restaurantFromJson(response.body));
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connection internet");
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connection internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalid');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }
  }

  static getCommerceById(String id) async {
    try {
      final apiUrl = settingsCtrl.baseUrl + 'commerces';
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(apiUrl + '/$id');
      final response = await http.get(url, headers: headers);
      Restaurant _commerce = Restaurant();

      if (response.statusCode == 200) {
        _commerce = Restaurant.fromJson(json.decode(response.body));
        return _commerce;
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connection internet");
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connection internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalid');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }
  }

  static getCommercetypes() async {
    try {
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(settingsCtrl.baseUrl + "commerces_types");
      var response = await http.get(url, headers: headers);
      print('response getCommercetypes:' + response.body.toString());
      if (response.statusCode == 200) {
        return Success(response: restaurantTypeFromJson(response.body));
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connection internet");
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connection internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalid');
    } catch (e) {
      return Failure(
          code: UNKNOWN_ERROR,
          errorResponse: 'Erreur inconnue ' + e.toString());
    }
  }

  static Future<Object> makeCommercesAsRead() async {
    try {
      var headers = await AuthService.getLoggedHeaders();
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var url =
          Uri.parse(settingsCtrl.baseUrl + 'make_commerces_as_read/$user_id');
      var response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        return Success();
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connection internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalide');
    } catch (e) {
      // print('Erreur inconnue '+ e.toString());
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }
  }

  static Future<bool> examen(CommentaireNote noteModel) async {
    final apiUrl = '${settingsCtrl.baseUrl}ajoutNoteCommentaireRestaurant';
    var url = Uri.parse(apiUrl);
    var headers = await AuthService.getLoggedHeaders();
    print('url: ' + url.toString());
    print(jsonEncode(noteModel.toMap()));

    var response = await http.post(url,
        headers: headers, body: jsonEncode(noteModel.toMap()));
    print('*********************');
    print('voir: ' + response.body.toString());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<AffichageHotelRestaurant>> afficheNoteCommentaire(
      restaurant_id) async {
    //  print('je veux hotel_idtt*******: '+hotel_id.toString());
    final apiUrl =
        '${settingsCtrl.baseUrl}lireNoteCommentaireRestaurant/$restaurant_id';
    var url = Uri.parse(apiUrl);
    var headers = await AuthService.getLoggedHeaders();

    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        // Analysez la réponse JSON (si c'est un tableau de données)
        List<dynamic> data = json.decode(response.body);
        // Créez une liste d'objets AffichageNoteCommenatire à partir des données
        print('je teste restaurant: ' + data.toString());
        List<AffichageHotelRestaurant> noteCommentaires = data.map((item) {
          return AffichageHotelRestaurant.fromJson(item);
        }).toList();
        return noteCommentaires;
      } else {
        // Gérer l'erreur, par exemple en lançant une exception
        throw Exception("Erreur de récupération des données");
      }
    } catch (e) {
      // Gérer les erreurs lors de l'appel HTTP
      print("Erreur de requête HTTP: $e");
      throw Exception("Erreur de requête HTTP: $e");
    }
  }
}
