import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/main_controller.dart';
import '../../modules/agenda/agenda_model.dart';
import 'auth_service.dart';
import 'data/Env.dart';
import 'data/api_status.dart';
import 'package:get/get.dart';

class AgendaServices {

  static MainController settingsCtrl = Get.put(MainController());

  // static final String apiUrl = baseUrl+'actualites';
  // static final String apiUrl = settingsCtrl.baseUrl+'agendas';

  static Future<Object> getAgendas() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      final apiUrl = settingsCtrl.baseUrl+'agendas';
      var url = Uri.parse(apiUrl);
      var response =  await http.get(url, headers: headers);
      // print('agendas response '+ response.body.toString());
      if(response.statusCode == 200){
        return Success(response: agendaFromJson(response.body));
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

  static Future<Object> getUnReadAgendas() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var url = Uri.parse(settingsCtrl.baseUrl+'un_read_agendas/$user_id');
      var response =  await http.get(url, headers: headers);
      // print('agendas response '+ response.body.toString());
      if(response.statusCode == 200){
        return Success(response: agendaFromJson(response.body));
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

  static Future<Object> getAgendasByWeek() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(settingsCtrl.baseUrl+'agendas_by_week');
      var response =  await http.get(url, headers: headers);
      if(response.statusCode == 200){
        return Success(response: agendaFromJson(response.body));
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

  static getAgendaById(String id) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      final apiUrl = settingsCtrl.baseUrl+'agendas';
      var url = Uri.parse(apiUrl+'/$id');
      final response = await http.get(url, headers: headers);
      // print('agendas response '+ response.body.toString());
      if(response.statusCode == 200){
        return Agenda.fromJson(json.decode(response.body));
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
  static Future<Object> makeAgendasAsRead() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var url = Uri.parse(settingsCtrl.baseUrl+'make_agendas_as_read/$user_id');
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
  static Future<Object> addAgendaVisite() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var module = "agenda";
      var url = Uri.parse(settingsCtrl.baseUrl+'add-visite-count/$module');
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