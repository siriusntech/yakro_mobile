import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/main_controller.dart';
import '../../modules/historique/historique_model.dart';
import 'auth_service.dart';
import 'data/Env.dart';
import 'data/api_status.dart';
import 'package:get/get.dart';

class HistoriqueServices {

  static MainController settingsCtrl = Get.put(MainController());


  // static final String apiUrl = baseUrl+'actualites';
  // static final String apiUrl = settingsCtrl.baseUrl+'historiques';

  static Future<Object> getHistoriques(user_id) async {
    try{
      final apiUrl = settingsCtrl.baseUrl+'historiques';
      // print('user id: '+user_id.toString());
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(apiUrl+'/$user_id');
      var response = await http.get(url, headers: headers);
      // print('response hist: '+response.body.toString());
      if(response.statusCode == 200){
          return Success(response: historiqueFromJson(response.body));
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

  static Future<Object> getMyHistoriquesByType(type_id, user_id) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(settingsCtrl.baseUrl+'my_historiques_by_type/$type_id/$user_id');
      var response = await http.get(url, headers: headers);
      // print('response by type: '+response.body.toString());
      if(response.statusCode == 200){
        return Success(response: historiqueFromJson(response.body));
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
      // // print('Erreur inconnue '+ e.toString());
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }

  }

  static Future<Object> getAllHistoriques(user_id) async {
    try{
      final _historiqueList = [];
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(settingsCtrl.baseUrl+'historiques_all/$user_id');
      var response = await http.get(url, headers: headers);
      // print('response all historiques: '+jsonDecode(response.body).toString());
      if(response.statusCode == 200){
        return Success(response: historiqueFromJson(response.body));
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
      print('Erreur inconnue '+ e.toString());
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }

  }

  static Future<Object> getAllHistoriquesByType(type_id, user_id) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(settingsCtrl.baseUrl+'historiques_all_by_type/$type_id/$user_id');
      var response = await http.get(url, headers: headers);
      // print('response by type: '+response.body.toString());
      if(response.statusCode == 200){
        return Success(response: historiqueFromJson(response.body));
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
      // // print('Erreur inconnue '+ e.toString());
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }

  }

  static getHistoriqueById(String id) async {
    final apiUrl = settingsCtrl.baseUrl+'historiques';
    var headers = await AuthService.getLoggedHeaders();
    var url = Uri.parse(apiUrl+'/$id');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return Historique.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  static makeHistoriqueIsRead(historique_id, user_id) async{
    var headers = await AuthService.getLoggedHeaders();
    try{
      var url = Uri.parse(settingsCtrl.baseUrl+'make_historique_is_read/$user_id/$historique_id');
      var response = await http.post(url, headers: headers);
      // print("response like "+response.body.toString());
      // print("response like status "+response.statusCode.toString());
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
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }
  }

  static makeInformationIsRead(information_id, user_id) async{
    var headers = await AuthService.getLoggedHeaders();
    try{
      var url = Uri.parse(settingsCtrl.baseUrl+'make_information_is_read/$user_id/$information_id');
      var response = await http.post(url, headers: headers);
      // print("response like "+response.body.toString());
      // print("response like status "+response.statusCode.toString());
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
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }
  }

  static likeHistorique(historique_id, user_id) async {
    var headers = await AuthService.getLoggedHeaders();
    try{
      var url = Uri.parse(settingsCtrl.baseUrl+'historique_liked/$user_id/$historique_id');
      var response = await http.post(url, headers: headers);
      // print("response like "+response.body.toString());
      // print("response like status "+response.statusCode.toString());
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
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }
  }

  static unLikeHistorique(historique_id, user_id) async {
    var headers = await AuthService.getLoggedHeaders();
    try{
      var url = Uri.parse(settingsCtrl.baseUrl+'historique_unliked/$user_id/$historique_id');
      var response = await http.post(url, headers: headers);
      // print("response unlike "+response.body.toString());
      // print("response unlike status "+response.statusCode.toString());
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
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }
  }
  static Future<Object> makeHistoriquesAsRead() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      // print('user id $user_id');
      var url = Uri.parse(settingsCtrl.baseUrl+'make_all_historiques_as_read/$user_id');
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