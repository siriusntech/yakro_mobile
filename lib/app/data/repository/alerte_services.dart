import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/main_controller.dart';
import '../../modules/alerte/alerte_model.dart';
import '../../modules/alerte/alerte_type_model.dart';
import 'auth_service.dart';
import 'data/Env.dart';
import 'data/api_status.dart';
import 'package:get/get.dart';

class AlerteServices {

  static MainController settingsCtrl = Get.put(MainController());


  // static final String apiUrl = baseUrl+'actualites';
  // static final String apiUrl = settingsCtrl.baseUrl+'alertes';

  static Future<Object> getAlertes() async {
    try{
      final apiUrl = settingsCtrl.baseUrl+'alertes';
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(apiUrl+'/$user_id');
      var response = await http.get(url, headers: headers);
      // print('response alertes: '+response.body.toString());
      if(response.statusCode == 200){
          return Success(response: alerteFromJson(response.body));
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

  static Future<Object> getMyAlertesByType(type_id) async {
    try{
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(settingsCtrl.baseUrl+'my_alertes_by_type/$type_id/$user_id');
      var response = await http.get(url, headers: headers);
      // print('response by type: '+response.body.toString());
      if(response.statusCode == 200){
        return Success(response: alerteFromJson(response.body));
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

  static Future<Object> getAllAlertes() async {
    try{
      final _alerteList = [];
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(settingsCtrl.baseUrl+'alertes_all/$user_id');
      var response = await http.get(url, headers: headers);
      // print('response all alertes: '+jsonDecode(response.body).toString());
      if(response.statusCode == 200){
        return Success(response: alerteFromJson(response.body));
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

  static Future<Object> getAllAlertesByType(type_id) async {
    try{
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(settingsCtrl.baseUrl+'alertes_all_by_type/$type_id/$user_id');
      var response = await http.get(url, headers: headers);
      // print('response by type: '+response.body.toString());
      if(response.statusCode == 200){
        return Success(response: alerteFromJson(response.body));
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

  static getAlerteById(String id) async {
    final apiUrl = settingsCtrl.baseUrl+'alertes';
    var headers = await AuthService.getLoggedHeaders();
    var url = Uri.parse(apiUrl+'/$id');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return Alerte.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  static createAlerte(data) async {
    final apiUrl = settingsCtrl.baseUrl+'alertes';
    var headers = await AuthService.getLoggedHeaders();
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_id = storage.getInt('user_id') ?? null;
    try{
      var url = Uri.parse(apiUrl);
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields['user_id'] = user_id.toString();
      request.fields['type'] = data['type'];
      request.fields['localisation'] = data['localisation'];
      request.fields['date'] = data['date'];
      request.fields['description'] = data['description'];
      request.fields['nom'] = data['nom'] ?? '';
      request.fields['prenom'] = data['prenom'] ?? '';
      request.fields['email'] = data['email'] ?? '';
      request.fields['contact'] = data['contact'] ?? '';
      //create multipart using filepath, string or bytes
      if(data['fileUrl'] != null && data['fileUrl'] != ''){
        request.fields['file_type'] = data['file_type'] ?? '';
        var pic = await http.MultipartFile.fromPath("fileUrl", data['fileUrl']);
        //add multipart to request
        request.files.add(pic);
      }else{
        request.fields['file_type'] = 'image';
      }
      final response = await request.send();
      // var responseData = await http.Response.fromStream(response);
      // print('response: '+ responseData.body.toString());
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var result = jsonDecode(responseData.body);
        return Success(response: Alerte.fromJson(result));
      } else {
        return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
      }
    }
    on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Pas de connection internet");
    }
    on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalide');
    }
    catch(e){
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue '+e.toString());
    }

  }

  static updateAlerte(alerte_id, data) async {
    final apiUrl = settingsCtrl.baseUrl+'alertes';
    var headers = await AuthService.getLoggedHeaders();
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_id = storage.getInt('user_id') ?? null;
    try{
      var url = Uri.parse(apiUrl+'/$alerte_id');
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields['user_id'] = user_id.toString();
      request.fields['localisation'] = data['localisation'];
      request.fields['date'] = data['date'];
      request.fields['description'] = data['description'];
      request.fields['nom'] = data['nom'] ?? '';
      request.fields['prenom'] = data['prenom'] ?? '';
      request.fields['email'] = data['email'] ?? '';
      request.fields['contact'] = data['contact'] ?? '';
      //create multipart using filepath, string or bytes
      if(data['fileUrl'] != null && data['fileUrl'] != ''){
        request.fields['file_type'] = data['file_type'] ?? '';
        var pic = await http.MultipartFile.fromPath("fileUrl", data['fileUrl']);
        //add multipart to request
        request.files.add(pic);
      }else{
        request.fields['file_type'] = 'image';
      }
      print(request);
      final response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var result = jsonDecode(responseData.body);
        return Success(response: Alerte.fromJson(result));
      } else {
        return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
      }
    }
    on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Pas de connection internet");
    }
    on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalide');
    }
    catch(e){
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue '+e.toString());
    }
  }

  static deleteAlerte(id) async {
    try{
      final apiUrl = settingsCtrl.baseUrl+'alertes';
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse('$apiUrl/$id');
      var response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        return Success();
      } else {
        return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
      }
    }
    on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Pas de connection internet");
    }
    on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalide');
    }
    catch(e){
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue '+e.toString());
    }
  }

  static getTypeAlertes() async {
    final String apiUrl = baseUrl+'type_alertes';
    var headers = await AuthService.getLoggedHeaders();
    try{
      var url = Uri.parse(apiUrl);
      var response = await http.get(url, headers: headers);
      // print('response: '+ response.body.toString());
      if(response.statusCode == 200){
        return Success(response: alerteTypeFromJson(response.body));
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

  static likeAlerte(alerte_id) async {
    var headers = await AuthService.getLoggedHeaders();
    try{
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var url = Uri.parse(settingsCtrl.baseUrl+'alerte_liked/$user_id/$alerte_id');
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

  static unLikeAlerte(alerte_id) async {
    var headers = await AuthService.getLoggedHeaders();
    try{
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var url = Uri.parse(settingsCtrl.baseUrl+'alerte_unliked/$user_id/$alerte_id');
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
  static Future<Object> makeAlertesAsRead() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var url = Uri.parse(settingsCtrl.baseUrl+'make_alertes_as_read/$user_id');
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