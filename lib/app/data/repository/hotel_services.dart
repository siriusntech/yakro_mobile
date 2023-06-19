import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jaime_cocody/app/data/repository/auth_service.dart';
import 'package:jaime_cocody/app/data/repository/data/Env.dart';
import 'package:jaime_cocody/app/data/repository/data/api_status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../controllers/main_controller.dart';
import '../../modules/hotel/hotel_model_model.dart';


class HotelServices {
  static MainController settingsCtrl = Get.put(MainController());
  static var client = http.Client();


  static Future<Object> getHotels() async {
    var headers = await AuthService.getLoggedHeaders();
    try {
      final apiUrl = settingsCtrl.baseUrl + 'hotelsIndex';
      var url = Uri.parse(apiUrl);
       print('Hotels url  '+url.toString());
      var response = await http.get(url, headers: headers);
       print('Hotels response status code '+ response.statusCode.toString());
       print('Hotels response body '+ response.body.toString());
      if (response.statusCode == 200) {
        return Success(response: HotelModel.fromJson(jsonDecode(response.body)).data);
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

  static Future<HotelModel?> fetchHotels() async {
    var response = await client.get(Uri.parse("https://sdyakro.siriusntech.digital/api/mobile/hotelsIndex"));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return HotelModel.fromJson(jsonMap);
    } else {
      print("Impossible de charger");
      return null;
    }
  }

  static Future<Object> getUnReadHotels() async {
    var headers = await AuthService.getLoggedHeaders();
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_id = storage.getInt('user_id') ?? null;
    try {
      var url = Uri.parse(settingsCtrl.baseUrl + 'un_read_actualites/$user_id');
      var response = await http.get(url, headers: headers);
      // print('actualites response '+ response.body.toString());
      if (response.statusCode == 200) {
        return Success(response: HotelModel.fromJson(json.decode(response.body)));
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

  static getHotelById(String id) async {
    var headers = await AuthService.getLoggedHeaders();
    HotelModel hotel = HotelModel();
    try {
      final apiUrl = settingsCtrl.baseUrl + '/hotelsIndex';
      var url = Uri.parse(apiUrl + '/${int.parse(id)}');
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        hotel = HotelModel.fromJson(json.decode(response.body));
        return Success(response: hotel);
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

  static Future<Object> getHotelsByType(type) async {
    var headers = await AuthService.getLoggedHeaders();
    try {
      var url = Uri.parse(settingsCtrl.baseUrl + 'actualites_by_type/$type');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return Success(response: HotelModel.fromJson(json.decode(response.body)));
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

  static Future<Object> getHotelsByWeek() async {
    var headers = await AuthService.getLoggedHeaders();
    try {
      var url = Uri.parse(settingsCtrl.baseUrl + 'actualites_by_week');
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return Success(response: HotelModel.fromJson(json.decode(response.body)));
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


  // }

  static Future<Object> makeHotelsAsRead() async {
    try {
      var headers = await AuthService.getLoggedHeaders();
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var url =
          Uri.parse(settingsCtrl.baseUrl + 'make_actualites_as_read/$user_id');
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






}