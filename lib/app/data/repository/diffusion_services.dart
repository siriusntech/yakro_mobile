import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/main_controller.dart';
import '../../modules/diffusion/diffusion_model.dart';
import 'auth_service.dart';
import 'data/Env.dart';
import 'data/api_status.dart';
import 'package:get/get.dart';

class DiffusionServices {

  static MainController settingsCtrl = Get.put(MainController());


  // static final String apiUrl = baseUrl+'actualites';
  // static final String apiUrl = settingsCtrl.baseUrl+'diffusions';

  static Future<Object> getDiffusions() async {
    try{
      final apiUrl = settingsCtrl.baseUrl+'diffusions';
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(apiUrl+'/$user_id');
      var response = await http.get(url, headers: headers);
      // print('response diff: '+response.body.toString());
      if(response.statusCode == 200){
          return Success(response: diffusionFromJson(response.body));
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

  static Future<Object> getUnReadDiffusions() async {
    try{
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(settingsCtrl.baseUrl+'unread_diffusions'+'/$user_id');
      var response = await http.get(url, headers: headers);
      // print('response unread: '+response.body.toString());
      if(response.statusCode == 200){
        return Success(response: diffusionFromJson(response.body));
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

  static Future<Object> makeDiffusionAsRead(int diffusion_id) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(settingsCtrl.baseUrl+'make_diffusion_as_read'+'/$diffusion_id');
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

  static deleteDiffusion(String id) async {
    try{
      final apiUrl = settingsCtrl.baseUrl+'diffusions';
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse('$apiUrl/${int.parse(id)}');
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
}