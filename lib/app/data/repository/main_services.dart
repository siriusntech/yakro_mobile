import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mon_plateau/app/models/entreprise.dart';

import '../../modules/agenda/agenda_model.dart';
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

}