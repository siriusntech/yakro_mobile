import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repository/auth_service.dart';
import '../../data/repository/data/Env.dart';
import '../../data/repository/data/api_status.dart';
import 'job_model.dart';
import 'job_type_model.dart';


class JobServices {

  static final String apiUrl = baseUrl+'jobs';

  static Future<Object> getJobs() async {
    var headers = await AuthService.getLoggedHeaders();
    var url = Uri.parse(apiUrl);
    try{
      var response = await http.get(url, headers: headers);
      // print(response.statusCode.toString());
      // print(response.body.toString());
      if(response.statusCode == 200){
        return Success(response: jobModelFromJson(response.body));
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

  static Future<Object> getUnReadJobs() async {
    var headers = await AuthService.getLoggedHeaders();
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_id = storage.getInt('user_id') ?? null;
    var url = Uri.parse(baseUrl+'un_read_jobs/$user_id');
    try{
      var response = await http.get(url, headers: headers);

      if(response.statusCode == 200){
        return Success(response: jobModelFromJson(response.body));
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

  static getJobsByType(type) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+"jobs_by_type/${type.toString()}");
      var response =  await http.get(url, headers: headers);

      if(response.statusCode == 200){
        return Success(response: jobModelFromJson(response.body));
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
  static getJobsByNom(nom) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+"jobs_by_nom/$nom");
      var response =  await http.get(url, headers: headers);
      if(response.statusCode == 200){
        return Success(response: jobModelFromJson(response.body));
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
  static getJobById(String id) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(apiUrl+'/$id');
      final response = await http.get(url, headers: headers);
      JobModel _job = JobModel();

      if(response.statusCode == 200){
        _job = JobModel.fromJson(json.decode(response.body));
        return _job;
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
  static getJobtypes() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+"jobs_types");
      var response =  await http.get(url, headers: headers);
      // print('response com type '+response.body.toString());
      if(response.statusCode == 200){
        return Success(response: jobTypeModelFromJson(response.body));
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

  static Future<Object> makeJobsAsRead() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;

      var url = Uri.parse(baseUrl+'make_jobs_as_read/$user_id');
      var response = await http.post(url, headers: headers);
      // print('response job'+response.body.toString());
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
  static Future<Object> addJobVisite() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var module = "job";
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