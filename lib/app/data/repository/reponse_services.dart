import 'dart:io';

import 'package:http/http.dart' as http;

import '../../controllers/main_controller.dart';
import 'auth_service.dart';
import 'data/Env.dart';
import 'data/api_status.dart';
import 'package:get/get.dart';

class ReponseServices {

  static MainController settingsCtrl = Get.put(MainController());

  static likeReponse(reponse_id) async {
    var headers = await AuthService.getLoggedHeaders();
    try{
      // SharedPreferences storage = await SharedPreferences.getInstance();
      // var user_id = storage.getInt('user_id') ?? null;
      var url = Uri.parse(settingsCtrl.baseUrl+'like_reponse/$reponse_id');
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

  static unLikeReponse(reponse_id) async {
    var headers = await AuthService.getLoggedHeaders();
    try{
      // SharedPreferences storage = await SharedPreferences.getInstance();
      // var user_id = storage.getInt('user_id') ?? null;
      var url = Uri.parse(settingsCtrl.baseUrl+'un_like_reponse/$reponse_id');
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
}