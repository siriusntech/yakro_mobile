import 'dart:io';

import 'package:http/http.dart' as http;

import '../../controllers/main_controller.dart';
import '../../models/type_annuaire_model.dart';
import 'auth_service.dart';
import 'data/Env.dart';
import 'data/api_status.dart';
import 'package:get/get.dart';

class TypeAnnuaireServices {

  static MainController settingsCtrl = Get.put(MainController());


  // static final String apiUrl = settingsCtrl.baseUrl;

  static getTypesAnnuaire() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(settingsCtrl.baseUrl+"m-get-type_annuaires");
      var response =  await http.get(url, headers: headers);
      // print('response com type '+response.body.toString());
      if(response.statusCode == 200){
        return Success(response: typeAnnuaireFromJson(response.body));
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

}