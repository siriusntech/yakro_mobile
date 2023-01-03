import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/auth/user_model.dart';
import 'data/Env.dart';
import 'data/api_status.dart';


class AuthService {

  static final String apiUrl = baseUrl+'users';

  static Future<Object> getUsers() async {
    var headers = await AuthService.getNotLoggedHeaders();
    try{
      var url = Uri.parse(apiUrl);
      var response = await http.get(url, headers: headers);
      // print('response body '+response.body.toString());
      if(response.statusCode == 200){
        return Success(response: userFromJson(response.body));
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
  static Future<Object> getUser(int id) async {
    try{
      // SharedPreferences storage = await SharedPreferences.getInstance();
      final user_id = id;
      final endPoint = Uri.parse(baseUrl+'user_info/$user_id');
      final headers = await getLoggedHeaders();

      var response = await http.get(endPoint, headers: headers);
      // print('get user info response body '+ response.body.toString());
      // print('get user info response code '+ response.statusCode.toString());
      if (response.statusCode == 200) {
        var info = jsonDecode(response.body)['data'];
        // print("info after decode: "+ info.toString());
        var user = User.fromJson(info);
        return Success(response: user);
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

   static register(data) async {
     try{
         var endPoint = Uri.parse(baseUrl+'register');
         var body = json.encode(data);
         Map <String, String> headers = {
           'Content-type': 'application/json; charset=UTF-8',
         };
         var response = await http.post(endPoint, body: body, headers: headers);
         // print('response ' + response.body.toString());
         // print('response ' + response.statusCode.toString());
         if (response.statusCode == 200) {
           var info = jsonDecode(response.body)['data'];
           var user = User.fromJson(info);
           return Success(response: user);
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
       // print('Erreur inconnue '+e.toString());
       return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue '+e.toString());
     }

   }
   static confirm(data) async{
     try{
       print(data);
       var url = Uri.parse(baseUrl+'confirm');
       var body = json.encode(data);
       Map <String, String> headers = {
         'Content-type': 'application/json; charset=UTF-8'
       };
       var response = await http.post(url, body: body, headers: headers);
       // print('confirm response code: '+response.statusCode.toString());
       // print('confirm response body: '+response.body.toString());
       if (response.statusCode == 200) {
         var info = jsonDecode(response.body)['data'];
         var user = User.fromJson(info);
         return Success(response: user);
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
       print('Erreur inconnue '+e.toString());
       return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue '+e.toString());
     }
   }
   static logout() async{


   }

   static getNotLoggedHeaders() async {
     var headers = {
       'Content-Type': 'application/json; charset=UTF-8',
     };
     return headers;
   }
   static getLoggedHeaders() async {
     SharedPreferences storage = await SharedPreferences.getInstance();
     var token = storage.getString('token');
     var headers = {
       'Content-Type': 'application/json; charset=UTF-8',
       'Authorization': 'Bearer $token',
       "Connection": "Keep-Alive",
     };
     return headers;
   }
}