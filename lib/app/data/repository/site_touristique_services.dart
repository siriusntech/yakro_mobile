import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jaime_yakro/app/data/repository/auth_service.dart';
import 'package:jaime_yakro/app/data/repository/data/Env.dart';
import 'package:jaime_yakro/app/data/repository/data/api_status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../controllers/main_controller.dart';
import '../../models/site_touristique.dart';



class VisiteTouristiqueServices {
  static MainController settingsCtrl = Get.put(MainController());
  static var client = http.Client();


  static Future<Object> getVisitesTouristique() async {
    var headers = await AuthService.getLoggedHeaders();
    try {
      final apiUrl = settingsCtrl.baseUrl + 'vt_Index';
      var url = Uri.parse(apiUrl);
       print('Visites url  '+url.toString());
      var response = await http.get(url, headers: headers);
       print('Visite Touristique Response status code '+ response.statusCode.toString());
       print('Visite Touristique Response body '+ response.body.toString());
      if (response.statusCode == 200) {
        return Success(response: VisiteTouristique.fromJson(jsonDecode(response.body)).data);
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

  static Future<VisiteTouristique?> fetchHotels() async {
    var response = await client.get(Uri.parse("https://sdyakro.siriusntech.digital/api/mobile/hotelsIndex"));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return VisiteTouristique.fromJson(jsonMap);
    } else {
      print("Impossible de charger");
      return null;
    }
  }

  static getHotelById(String id) async {
    var headers = await AuthService.getLoggedHeaders();
    List<VisiteTouristique> hotel =  <VisiteTouristique>[];
    try {
      final apiUrl = settingsCtrl.baseUrl + '/hotelsIndex';
      var url = Uri.parse(apiUrl + '/${int.parse(id)}');
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        hotel = VisiteTouristique.fromJson(json.decode(response.body)) as List<VisiteTouristique>;
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
        return Success(response: VisiteTouristique.fromJson(json.decode(response.body)));
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
        return Success(response: VisiteTouristique.fromJson(json.decode(response.body)));
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

  static Future<Object> makeVisiteTouristiqueAsRead() async {
    try {
      var headers = await AuthService.getLoggedHeaders();
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var url =
          Uri.parse(settingsCtrl.baseUrl + 'make_vt_as_read/$user_id');
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

  
  static Future<Object> getUnReadVisiteTouristique() async {
    var headers = await AuthService.getLoggedHeaders();
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_id = storage.getInt('user_id') ?? null;
    try {
      var url = Uri.parse(settingsCtrl.baseUrl + 'un_read_vt/$user_id');
      var response = await http.get(url, headers: headers);
      // print('actualites response '+ response.body.toString());
      if (response.statusCode == 200) {
        return Success(response: VisiteTouristique.fromJson(json.decode(response.body)));
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





}
