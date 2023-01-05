import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../models/annuaire.dart';
import 'auth_service.dart';
import 'data/Env.dart';
import 'data/api_status.dart';


class AnnuaireServices {

  static final String apiUrl = baseUrl+'annuaires';

  static Future<Object> getAnnuaires() async {
    var headers = await AuthService.getLoggedHeaders();
    try{
      var url = Uri.parse(apiUrl);
      var response = await http.get(url, headers: headers);
      if(response.statusCode == 200){
        return Success(response: annuaireFromJson(response.body));
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

  static getAnnuairesByType(type_id) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+"annuaires_by_type/$type_id");
      var response =  await http.get(url, headers: headers);
      // print('response an type '+response.body.toString());
      if(response.statusCode == 200){
        return Success(response: annuaireFromJson(response.body));
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

  static getAnnuaireById(String id) async {
    var headers = await AuthService.getLoggedHeaders();
    Annuaire annuaire = Annuaire();
    try{
      var url = Uri.parse(apiUrl+'/${int.parse(id)}');
      final response = await http.get(url, headers: headers);
      if(response.statusCode == 200){
        annuaire = Annuaire.fromJson(json.decode(response.body));
        return Success(response: annuaire);
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