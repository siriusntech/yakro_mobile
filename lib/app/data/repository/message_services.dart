import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/message/message_model.dart';
import '../../modules/message/message_type_model.dart';
import 'auth_service.dart';
import 'data/Env.dart';
import 'data/api_status.dart';


class MessageServices {

  static final String apiUrl = baseUrl+'messages';

  static getMessages() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_id = storage.getInt('user_id') ?? null;
    var headers = await AuthService.getLoggedHeaders();
    try{
      var url = Uri.parse(apiUrl+'/$user_id');
      var response = await http.get(url, headers: headers);
      if(response.statusCode == 200){
        return Success(response: messageFromJson(response.body));
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

  static getMyMessagesByType(type_id) async {
    var headers = await AuthService.getLoggedHeaders();
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_id = storage.getInt('user_id') ?? null;
    try{
      var url = Uri.parse(baseUrl+'my_messages_by_type/$type_id/$user_id');
      var response = await http.get(url, headers: headers);
      // print('msg by type response '+ response.body.toString());
      if(response.statusCode == 200){
        return Success(response: messageFromJson(response.body));
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

  static getAllMessages() async {
    var headers = await AuthService.getLoggedHeaders();
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_id = storage.getInt('user_id') ?? null;
    try{
      var url = Uri.parse(baseUrl+'all_messages/$user_id');
      var response = await http.get(url, headers: headers);
      if(response.statusCode == 200){
        return Success(response: messageFromJson(response.body));
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

  static getMessagesByType(type_id) async {
    var headers = await AuthService.getLoggedHeaders();
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_id = storage.getInt('user_id') ?? null;
    try{
      var url = Uri.parse(baseUrl+'messages_by_type/$type_id/$user_id');
      var response = await http.get(url, headers: headers);
      // print('msg by type response '+ response.body.toString());
      if(response.statusCode == 200){
        return Success(response: messageFromJson(response.body));
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

  static getMessageById(String id) async {
    var headers = await AuthService.getLoggedHeaders();
    var url = Uri.parse(apiUrl+'/$id');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return Message.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  static getMessageTypes() async {
    final String apiUrl = baseUrl+'type_messages';
    var headers = await AuthService.getLoggedHeaders();
    try{
      var url = Uri.parse(apiUrl);
      var response = await http.get(url, headers: headers);
      if(response.statusCode == 200){
        return Success(response: messageTypeFromJson(response.body));
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

  static createMessage(data) async {
    var headers = await AuthService.getLoggedHeaders();
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_id = storage.getInt('user_id') ?? null;
    try{
      var url = Uri.parse(apiUrl);
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields['user_id'] = user_id.toString();
      request.fields['type_id'] = data['type_id'].toString();
      request.fields['libelle'] = data['libelle'];
      request.fields['description'] = data['description'];
      request.fields['nom'] = data['nom'];
      request.fields['prenom'] = data['prenom'];
      request.fields['email'] = data['email'];
      request.fields['contact'] = data['contact'];
      //create multipart using filepath, string or bytes
      if(data['fileUrl'] != null && data['fileUrl'] != ''){
        request.fields['file_type'] = data['file_type'] ?? '';
        var pic = await http.MultipartFile.fromPath("fileUrl", data['fileUrl']);
        //add multipart to request
        request.files.add(pic);
      }else{
        request.fields['file_type'] = 'image';
      }
      // print('message request: '+request.toString());
      final response = await request.send();
      // var resp = await http.Response.fromStream(response);
      // print('message response: '+resp.body.toString());
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        // print(responseData.body);
        var result = jsonDecode(responseData.body);
        return Success(response: Message.fromJson(result));
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

  static updateMessage(msg_id, data) async {
    var headers = await AuthService.getLoggedHeaders();
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_id = storage.getInt('user_id') ?? null;
    try{
      var url = Uri.parse(apiUrl+'/$msg_id');
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields['user_id'] = user_id.toString();
      request.fields['libelle'] = data['libelle'];
      request.fields['description'] = data['description'];
      request.fields['nom'] = data['nom'] ?? '';
      request.fields['prenom'] = data['prenom'] ?? '';
      request.fields['email'] = data['email'] ?? '';
      request.fields['contact'] = data['contact'] ?? '';
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
      // var resp = await http.Response.fromStream(response);
      // print('message response: '+resp.body.toString());
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var result = jsonDecode(responseData.body);
        return Success(response: Message.fromJson(result));
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

  static deleteMessage(id) async {
    try{
      var headers = await AuthService.getLoggedHeaders();
      var url = Uri.parse('$apiUrl/$id');
      var response = await http.delete(url, headers: headers);
      // print('response '+ response.body.toString());
      // print('response status code '+ response.statusCode.toString());
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

  static likeMessage(message_id) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var headers = await AuthService.getLoggedHeaders();
    var user_id = storage.getInt('user_id') ?? null;
    // data['user_id'] = user_id;
    try{
      // var body = jsonEncode(data);
      var url = Uri.parse(baseUrl+'message_liked/$message_id/$user_id');
      var response = await http.post(url, headers: headers);
      print(response.body.toString());
      if (response.statusCode == 200) {
        // print(response.body.toString());
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

  static unLikeMessage(message_id) async {
    var headers = await AuthService.getLoggedHeaders();
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_id = storage.getInt('user_id') ?? null;
    try{
      // var body = jsonEncode(data);
      var url = Uri.parse(baseUrl+'message_unliked/$message_id/$user_id');
      var response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        // print(response.body.toString());
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
