import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repository/auth_service.dart';
import '../../data/repository/data/Env.dart';
import '../../data/repository/data/api_status.dart';
import 'commerce_model.dart';
import 'commerce_type_model.dart';


class CommerceServices {

  static final String apiUrl = baseUrl+'commerces';

  static Future<Object> getCommerces() async {
    var headers = await AuthService.getLoggedHeaders();
    var url = Uri.parse(apiUrl);
    try{
      var response = await http.get(url, headers: headers);
      // print(response.statusCode.toString());
      if(response.statusCode == 200){
        return Success(response: commerceFromJson(response.body));
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

  static Future<Object> getUnReadCommerces() async {
    var headers = await AuthService.getLoggedHeaders();
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_id = storage.getInt('user_id') ?? null;
    var url = Uri.parse(baseUrl+'un_read_commerces/$user_id');
    try{
      var response = await http.get(url, headers: headers);

      if(response.statusCode == 200){
        return Success(response: commerceFromJson(response.body));
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

  static getCommercesByType(type) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+"commerces_by_type/${type.toString()}");
      var response =  await http.get(url, headers: headers);

      if(response.statusCode == 200){
        return Success(response: commerceFromJson(response.body));
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
  static getCommercesByNom(nom) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+"commerces_by_nom/$nom");
      var response =  await http.get(url, headers: headers);
      if(response.statusCode == 200){
        return Success(response: commerceFromJson(response.body));
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
  static getCommerceById(String id) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(apiUrl+'/$id');
      final response = await http.get(url, headers: headers);
      Commerce _commerce = Commerce();

      if(response.statusCode == 200){
        _commerce = Commerce.fromJson(json.decode(response.body));
        return _commerce;
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
  static getCommercetypes() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+"commerces_types");
      var response =  await http.get(url, headers: headers);
      // print('response com type '+response.body.toString());
      if(response.statusCode == 200){
        return Success(response: commerceTypeFromJson(response.body));
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

  static Future<Object> makeCommercesAsRead() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var url = Uri.parse(baseUrl+'make_commerces_as_read/$user_id');
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