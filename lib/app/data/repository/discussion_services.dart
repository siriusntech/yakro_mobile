import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/discussion/discussion_model.dart';
import 'auth_service.dart';
import 'data/Env.dart';
import 'data/api_status.dart';


class DiscussionServices {

  static final String apiUrl = baseUrl+'discussions';

  static Future<Object> getDiscussions(user_id) async {
    // print('request sendind...');
    try{
      // SharedPreferences storage = await SharedPreferences.getInstance();
      // var user_id = storage.getInt('user_id') ?? null;
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(apiUrl+'/$user_id');
      var response = await http.get(url, headers: headers);
      // print('response discussions code: '+response.statusCode.toString());
      // print('response discussions: '+jsonDecode(response.body)['data'].toString());
      if(response.statusCode == 200){
          return Success(response: discussionFromJson(response.body));
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


  static Future<Object> getAllDiscussions(user_id) async {
    try{
      // SharedPreferences storage = await SharedPreferences.getInstance();
      // var user_id = storage.getInt('user_id') ?? null;
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+'discussions_all/$user_id');
      var response = await http.get(url, headers: headers);
      // print('response all discussions: '+jsonDecode(response.body).toString());
      if(response.statusCode == 200){
        return Success(response: discussionFromJson(response.body));
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


  static getDiscussionById(String id) async {
    var headers = await AuthService.getLoggedHeaders();
    var url = Uri.parse(apiUrl+'/$id');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return Discussion.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  static createDiscussion(data, user_id) async {
    var headers = await AuthService.getLoggedHeaders();
    // SharedPreferences storage = await SharedPreferences.getInstance();
    // var user_id = storage.getInt('user_id') ?? null;
    try{
      var url = Uri.parse(apiUrl);
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields['user_id'] = user_id.toString();
      // request.fields['date'] = data['date'];
      request.fields['sujet'] = data['sujet'];
      //create multipart using filepath, string or bytes
      if(data['fileUrl'] != null && data['fileUrl'] != ''){
        request.fields['file_type'] = data['file_type'] ?? '';
        var pic = await http.MultipartFile.fromPath("fileUrl", data['fileUrl']);
        //add multipart to request
        request.files.add(pic);
      }else{
        request.fields['file_type'] = 'image';
      }
      final response = await request.send();
      // var responseData = await http.Response.fromStream(response);
      // print('response code: '+ responseData.statusCode.toString());
      // print('response: '+ responseData.body.toString());
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        // print('response code: '+ responseData.statusCode.toString());
        // print('response: '+ responseData.body.toString());
        var result = jsonDecode(responseData.body);
        return Success(response: Discussion.fromJson(result));
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

  static updateDiscussion(discussion_id, data, user_id) async {
    var headers = await AuthService.getLoggedHeaders();
    // SharedPreferences storage = await SharedPreferences.getInstance();
    // var user_id = storage.getInt('user_id') ?? null;
    try{
      var url = Uri.parse(apiUrl+'/$discussion_id');
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields['user_id'] = user_id.toString();
      // request.fields['date'] = data['date'];
      request.fields['sujet'] = data['sujet'];
      //create multipart using filepath, string or bytes
      if(data['fileUrl'] != null && data['fileUrl'] != ''){
        request.fields['file_type'] = data['file_type'] ?? '';
        var pic = await http.MultipartFile.fromPath("fileUrl", data['fileUrl']);
        //add multipart to request
        request.files.add(pic);
      }else{
        request.fields['file_type'] = 'image';
      }
      // print(request);
      final response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var result = jsonDecode(responseData.body);
        return Success(response: Discussion.fromJson(result));
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

  static deleteDiscussion(id) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse('$apiUrl/$id');
      Response response = await http.delete(url, headers: headers);
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


  static likeDiscussion(discussion_id, user_id) async {
    var headers = await AuthService.getLoggedHeaders();
    try{
      // SharedPreferences storage = await SharedPreferences.getInstance();
      // var user_id = storage.getInt('user_id') ?? null;
      var url = Uri.parse(baseUrl+'discussion_liked/$user_id/$discussion_id');
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

  static unLikeDiscussion(discussion_id, user_id) async {
    var headers = await AuthService.getLoggedHeaders();
    try{
      // SharedPreferences storage = await SharedPreferences.getInstance();
      // var user_id = storage.getInt('user_id') ?? null;
      var url = Uri.parse(baseUrl+'discussion_unliked/$user_id/$discussion_id');
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
  static Future<Object> makeDiscussionsAsRead() async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var url = Uri.parse(baseUrl+'make_discussions_as_read/$user_id');
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