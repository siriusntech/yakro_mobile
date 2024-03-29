import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/main_controller.dart';
import '../../modules/actualite/actualite_model.dart';
import '../../modules/actualite/actualite_type_model.dart';
import 'auth_service.dart';
import 'data/Env.dart';
import 'data/api_status.dart';
import 'package:get/get.dart';

class ActualiteServices {

  static MainController settingsCtrl = Get.put(MainController());

  // static final String apiUrl = baseUrl+'actualites';
  // static String apiUrl = settingsCtrl.baseUrl+'actualites';

  static Future<Object> getActualites() async {
    // print('settings base url  '+settingsCtrl.baseUrl.toString());
    var headers = await AuthService.getLoggedHeaders();
    try{
      final apiUrl = settingsCtrl.baseUrl+'actualites';
      var url = Uri.parse(apiUrl);
      // print('actaulités url  '+url.toString());
      var response = await http.get(url, headers: headers);
      // print('actualites response status code '+ response.statusCode.toString());
      // print('actualites response body '+ response.body.toString());
    if(response.statusCode == 200){
      return Success(response: actualiteFromJson(response.body));
    }
    return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    }
    on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Pas de connection internet");
    }
    on SocketException{
      return Failure(code: NO_INTERNET, errorResponse: "Pas de connection internet");
    }
    on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalid');
    }
    catch(e){
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }
  }


  static Future<Object> getUnReadActualites() async {
    var headers = await AuthService.getLoggedHeaders();
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_id = storage.getInt('user_id') ?? null;
    try{
      var url = Uri.parse(settingsCtrl.baseUrl+'un_read_actualites/$user_id');
      var response = await http.get(url, headers: headers);
      // print('actualites response '+ response.body.toString());
      if(response.statusCode == 200){
        return Success(response: actualiteFromJson(response.body));
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    }
    on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Pas de connection internet");
    }
    on SocketException{
      return Failure(code: NO_INTERNET, errorResponse: "Pas de connection internet");
    }
    on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalid');
    }
    catch(e){
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }

  }

  static getActualiteById(String id) async {
    var headers = await AuthService.getLoggedHeaders();
    Actualite actualite = Actualite();
    try{
      final apiUrl = settingsCtrl.baseUrl+'actualites';
      var url = Uri.parse(apiUrl+'/${int.parse(id)}');
      final response = await http.get(url, headers: headers);
      if(response.statusCode == 200){
        actualite = Actualite.fromJson(json.decode(response.body));
        return Success(response: actualite);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    }
    on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Pas de connection internet");
    }
    on SocketException{
      return Failure(code: NO_INTERNET, errorResponse: "Pas de connection internet");
    }
    on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalid');
    }
    catch(e){
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }
  }

  static Future<Object> getActualitesByType(type) async {
    var headers = await AuthService.getLoggedHeaders();
    try{
      var url = Uri.parse(settingsCtrl.baseUrl+'actualites_by_type/$type');
      var response = await http.get(url, headers: headers);
      if(response.statusCode == 200){
        return Success(response: actualiteFromJson(response.body));
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    }
    on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Pas de connection internet");
    }
    on SocketException{
      return Failure(code: NO_INTERNET, errorResponse: "Pas de connection internet");
    }
    on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalid');
    }
    catch(e){
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }

  }

  static Future<Object> getActualitesByWeek() async {
    var headers = await AuthService.getLoggedHeaders();
    try{
      var url = Uri.parse(settingsCtrl.baseUrl+'actualites_by_week');
      var response = await http.get(url, headers: headers);
      if(response.statusCode == 200){
        return Success(response: actualiteFromJson(response.body));
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    }
    on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Pas de connection internet");
    }
    on SocketException{
      return Failure(code: NO_INTERNET, errorResponse: "Pas de connection internet");
    }
    on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalid');
    }
    catch(e){
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }

  }

  static getActualitetypes() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(settingsCtrl.baseUrl+"actualites_types");
      var response =  await http.get(url, headers: headers);

      if(response.statusCode == 200){
        return Success(response: actualiteTypeFromJson(response.body));
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    }
    on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Pas de connection internet");
    }
    on SocketException{
      return Failure(code: NO_INTERNET, errorResponse: "Pas de connection internet");
    }
    on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalid');
    }
    catch(e){
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue '+e.toString());
    }
  }

  static Future<Object> makeActualitesAsRead() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var url = Uri.parse(settingsCtrl.baseUrl+'make_actualites_as_read/$user_id');
      var response = await http.post(url, headers: headers);
      if(response.statusCode == 200){
        return Success();
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    }
    on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Pas de connection internet");
    }
    on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalide');
    }
    catch(e){
      // print('Erreur inconnue '+ e.toString());
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }
  }


}