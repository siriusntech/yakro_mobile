import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jaime_cocody/app/models/mise_a_jour_model.dart';
import 'package:jaime_cocody/app/models/entreprise.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';
import 'data/Env.dart';
import 'data/api_status.dart';


class MainServices {

  static final String apiUrl = baseUrl+'entreprise_infos';

  static Future<Object> getInfos() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(apiUrl);
      var response =  await http.get(url, headers: headers);
      // print('etse response '+ response.body.toString());
      if(response.statusCode == 200){
        var data = json.decode(response.body)['data'];
        return Success(response: Entreprise.fromJson(data));
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

  static Future<Object> checkUpdate(user_id) async {
    // print("update user_id "+ user_id.toString());
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+'check-mise-a-jour/$user_id');
      var response =  await http.get(url, headers: headers);
      // print('up response '+ response.body.toString());
      if(response.statusCode == 200){
        var data = json.decode(response.body)['data'];
        return Success(response: MiseAJourModel.fromJson(data));
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

  static makeUpdate(user_id) async {
    var headers = await AuthService.getLoggedHeaders();
    try{
      var url = Uri.parse(baseUrl+'make-mise-a-jour/$user_id');
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

  static Future<bool> checkUserIsExclude() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_contact = storage.getString('contact');
    // print(user_contact);
    const exclude_numbers = [
      '0171300914',
      '0767489000',
      '0789073909',
      '0779549937',
      '0506787411',
      '0777949870',
      '0153765253',
      '0707106603'
    ];
    if(exclude_numbers.contains(user_contact)){
       return true;
    }else{
      return false;
    }
  }

  static Future<Object> addVisiteCount(module, user_id) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+'add-visite-count/$module/$user_id');
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
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }
  }

  static Future<Object> setUserCloudMessagingToken(user_id, token) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+'set-user-cloud-messaging-token/$user_id/$token');
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
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }
  }

}