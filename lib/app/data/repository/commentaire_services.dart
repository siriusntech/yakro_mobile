import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/discussion/commentaire_model.dart';
import 'auth_service.dart';
import 'data/Env.dart';
import 'data/api_status.dart';


class CommentaireServices {

  static final String apiUrl = baseUrl+'commentaires';

  static Future<Object> getCommentaires() async {
    try{
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(apiUrl+'/$user_id');
      var response = await http.get(url, headers: headers);
      if(response.statusCode == 200){
          return Success(response: commentaireFromJson(response.body));
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

  static Future<Object> getMyCommentairesByType(type_id) async {
    try{
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+'my_commentaires_by_type/$type_id/$user_id');
      var response = await http.get(url, headers: headers);
      // print('response by type: '+response.body.toString());
      if(response.statusCode == 200){
        return Success(response: commentaireFromJson(response.body));
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
      // // print('Erreur inconnue '+ e.toString());
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }

  }

  static Future<Object> getAllCommentaires() async {
    try{
      final _commentaireList = [];
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+'commentaires_all/$user_id');
      var response = await http.get(url, headers: headers);
      // print('response all commentaires: '+jsonDecode(response.body).toString());
      if(response.statusCode == 200){
        return Success(response: commentaireFromJson(response.body));
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

  static Future<Object> getAllCommentairesByType(type_id) async {
    try{
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+'commentaires_all_by_type/$type_id/$user_id');
      var response = await http.get(url, headers: headers);
      // print('response by type: '+response.body.toString());
      if(response.statusCode == 200){
        return Success(response: commentaireFromJson(response.body));
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
      // // print('Erreur inconnue '+ e.toString());
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }

  }

  static getCommentaireById(String id) async {
    var headers = await AuthService.getLoggedHeaders();
    var url = Uri.parse(apiUrl+'/$id');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return Commentaire.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  static createCommentaire(data, user_id) async {
    var headers = await AuthService.getLoggedHeaders();
    // SharedPreferences storage = await SharedPreferences.getInstance();
    // var user_id = storage.getInt('user_id') ?? null;
    try{
      var url = Uri.parse(apiUrl);
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields['user_id'] = user_id.toString();
      // request.fields['date'] = data['date'];
      request.fields['texte'] = data['texte'];
      request.fields['discussion_id'] = data['discussion_id'];
      //create multipart using filepath, string or bytes
      // if(data['fileUrl'] != null && data['fileUrl'] != ''){
      //   request.fields['file_type'] = data['file_type'] ?? '';
      //   var pic = await http.MultipartFile.fromPath("fileUrl", data['fileUrl']);
      //   //add multipart to request
      //   request.files.add(pic);
      // }else{
      //   request.fields['file_type'] = 'image';
      // }
      final response = await request.send();
      // var responseData = await http.Response.fromStream(response);
      // print('response: '+ responseData.body.toString());
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var result = jsonDecode(responseData.body);
        return Success(response: Commentaire.fromJson(result));
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

  static updateCommentaire(commentaire_id, data, user_id) async {
    var headers = await AuthService.getLoggedHeaders();
    // SharedPreferences storage = await SharedPreferences.getInstance();
    // var user_id = storage.getInt('user_id') ?? null;
    try{
      var url = Uri.parse(apiUrl+'/$commentaire_id');
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields['user_id'] = user_id.toString();
      // request.fields['date'] = data['date'];
      request.fields['texte'] = data['texte'];
      //create multipart using filepath, string or bytes
      // if(data['fileUrl'] != null && data['fileUrl'] != ''){
      //   request.fields['file_type'] = data['file_type'] ?? '';
      //   var pic = await http.MultipartFile.fromPath("fileUrl", data['fileUrl']);
      //   //add multipart to request
      //   request.files.add(pic);
      // }else{
      //   request.fields['file_type'] = 'image';
      // }

      final response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var result = jsonDecode(responseData.body);
        return Success(response: Commentaire.fromJson(result));
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

  static deleteCommentaire(id) async {
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

  static likeCommentaire(commentaire_id, user_id) async {
    var headers = await AuthService.getLoggedHeaders();
    try{
      // SharedPreferences storage = await SharedPreferences.getInstance();
      // var user_id = storage.getInt('user_id') ?? null;
      var url = Uri.parse(baseUrl+'commentaire_liked/$user_id/$commentaire_id');
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

  static unLikeCommentaire(commentaire_id, user_id) async {
    var headers = await AuthService.getLoggedHeaders();
    try{
      // SharedPreferences storage = await SharedPreferences.getInstance();
      // var user_id = storage.getInt('user_id') ?? null;
      var url = Uri.parse(baseUrl+'commentaire_unliked/$user_id/$commentaire_id');
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


  static createReponse(data, user_id) async {
    var headers = await AuthService.getLoggedHeaders();
    // SharedPreferences storage = await SharedPreferences.getInstance();
    // var user_id = storage.getInt('user_id') ?? null;
    try{
      var url = Uri.parse(baseUrl+'commentaires_reponse');
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields['user_id'] = user_id.toString();
      request.fields['texte'] = data['texte'];
      request.fields['main_commentaire_id'] = data['main_commentaire_id'];
      final response = await request.send();
      // var responseData = await http.Response.fromStream(response);
      // print('response: '+ responseData.body.toString());
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var result = jsonDecode(responseData.body);
        return Success(response: Commentaire.fromJson(result));
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

  static Future<Object> getReponses(comment_id) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse(baseUrl+'/reponses/$comment_id');
      var response = await http.get(url, headers: headers);
      if(response.statusCode == 200){
        return Success(response: commentaireFromJson(response.body));
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