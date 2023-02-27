import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repository/auth_service.dart';
import '../../data/repository/data/Env.dart';
import '../../data/repository/data/api_status.dart';
import '../../models/pharmacie_model.dart';


class PharmacieServices {

  static final String apiUrl = baseUrl+'pharmacies';

  static Future<Object> getPharmacies() async {
    var headers = await AuthService.getLoggedHeaders();
    var url = Uri.parse(apiUrl);
    try{
      var response = await http.get(url, headers: headers);
      // print(response.statusCode.toString());
      // print(response.body.toString());
      if(response.statusCode == 200){
        return Success(response: pharmacieFromJson(response.body));
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

  static getPharmaciesByNom(nom) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+"pharmacies_by_nom/$nom");
      var response =  await http.get(url, headers: headers);
      if(response.statusCode == 200){
        return Success(response: pharmacieFromJson(response.body));
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
  static getPharmaciesByZone(zone_id) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+"pharmacies_by_zone/$zone_id");
      var response =  await http.get(url, headers: headers);
      // print('response phm type '+response.body.toString());
      if(response.statusCode == 200){
        return Success(response: pharmacieFromJson(response.body));
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
  static getPharmacieById(String id) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(apiUrl+'/$id');
      final response = await http.get(url, headers: headers);
      Pharmacie _pharmacie = Pharmacie();

      if(response.statusCode == 200){
        _pharmacie = Pharmacie.fromJson(json.decode(response.body));
        return _pharmacie;
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
  static Future<Object> addPharmacieVisite() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var module = "pharmacie";
      var url = Uri.parse(baseUrl+'add-visite-count/$module');
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