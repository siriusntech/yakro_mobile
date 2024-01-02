import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jaime_yakro/app/data/repository/auth_service.dart';
import 'package:jaime_yakro/app/data/repository/data/Env.dart';
import 'package:jaime_yakro/app/data/repository/data/api_status.dart';
import 'package:jaime_yakro/app/models/CommentaireNote.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../controllers/main_controller.dart';
import '../../models/AffichageHotelRestaurant.dart';
import '../../models/hotelAll.dart';
import '../../models/typeHotel.dart';

class HotelServices {
  static MainController settingsCtrl = Get.put(MainController());
  static var client = http.Client();

  static Future<List<HotelModel>> getHotelsFiltragePrix(
      var type_hotel, var prix1, var prix2) async {
    var headers = await AuthService.getLoggedHeaders();
    final apiUrl =
         '${settingsCtrl.baseUrl}filtrage_hotel${"?type_hotel=$type_hotel"}${prix1.isNotEmpty ?"&prix1=${int.parse(prix1)}":""}${prix2.isNotEmpty ? "&prix2=${int.parse(prix2)}" : ""}';
    // '${settingsCtrl.baseUrl}filtrage_hotel''?type_hotel=$type_hotel''${"&prix1=${int.parse(prix1)}"}''${prix2.isNotEmpty ? "&prix2=${int.parse(prix2)}" : ""}';

    var url = Uri.parse(apiUrl);

    // print('getHotelsFiltragePrix url: ' + url.toString());
    // print('getHotelsFiltragePrix url: ' + url.toString());
    // print('getHotelsFiltragePrix prix1: ' + prix1);
    // print('getHotelsFiltragePrix prix2: ' + prix2);
    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((items) => HotelModel.fromJson(items)).toList();
    } else {
      return [];
    }
  }

  static Future<List<TypeHotelByHotels>> getButtonTypeHotel() async {
    var headers = await AuthService.getLoggedHeaders();
    // try {
    final apiUrl = settingsCtrl.baseUrl + 'filtrage_hotel_type';
    var url = Uri.parse(apiUrl);
    // print('getButtonTypeHotel url' + url.toString());
    var response = await http.get(url, headers: headers);

    // print('getButtonTypeHotel response status code ' +
    //     response.statusCode.toString());
    // print('getButtonTypeHotel response body ' + response.body.toString());

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((items) => TypeHotelByHotels.fromJson(items)).toList();
    } else {
      return [];
    }
  }

  static Future<Object> makeHotelsAsRead() async {
    try {
      var headers = await AuthService.getLoggedHeaders();
      SharedPreferences storage = await SharedPreferences.getInstance();
      var user_id = storage.getInt('user_id') ?? null;
      var url =
          Uri.parse(settingsCtrl.baseUrl + 'make_hotels_as_read/$user_id');
      var response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        return Success();
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connection internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalide');
    } catch (e) {
      // print('Erreur inconnue '+ e.toString());
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }
  }

  static Future<Object> getUnReadHotels() async {
    var headers = await AuthService.getLoggedHeaders();
    SharedPreferences storage = await SharedPreferences.getInstance();
    var user_id = storage.getInt('user_id') ?? null;
    try {
      var url = Uri.parse(settingsCtrl.baseUrl + 'un_read_hotels/$user_id');
      var response = await http.get(url, headers: headers);
      // print('actualites response '+ response.body.toString());
      if (response.statusCode == 200) {
        return Success(
            response: HotelModel.fromJson(json.decode(response.body)));
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connection internet");
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connection internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalid');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }
  }

  static Future<bool> examen(CommentaireNote noteModel) async {
    final apiUrl = '${settingsCtrl.baseUrl}ajoutNoteCommentaireHotel';
    var url = Uri.parse(apiUrl);
    var headers = await AuthService.getLoggedHeaders();
    // print('url: '+url.toString());
    // print(jsonEncode(noteModel.toMap()));

    var response =
        await http.post(url, headers: headers, body:jsonEncode(noteModel.toMap()));
    // print('*********************');
    // print('voir: '+response.body.toString());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

// static Future<List<CommentaireNote>> afficheNoteCommentaire(hotel_id) async {
//     if (hotel_id == null) {
//     // Gérer le cas où hotel_id est null, par exemple, en lançant une exception ou en renvoyant une liste vide.
//     throw Exception("hotel_id ne peut pas être null");
//   }

//   final apiUrl = '${settingsCtrl.baseUrl}lireNoteCommentaireHotel/$hotel_id';
//   var url = Uri.parse(apiUrl);
//   var headers = await AuthService.getLoggedHeaders();

//    try {
//     var response = await http.get(url, headers: headers);

//     if (response.statusCode == 200) {
    
//       // Analysez la réponse JSON (si c'est un tableau de données)
//       List<dynamic> data = json.decode(response.body);
//       // Créez une liste d'objets AffichageNoteCommenatire à partir des données
//       List<CommentaireNote> noteCommentaires = data.map((item) {
//         return CommentaireNote.fromMap(item);
//       }).toList();
//      print('je print oh: '+noteCommentaires.toString());
//       return noteCommentaires;
//     } else {
//       // Gérer l'erreur, par exemple en lançant une exception
//       throw Exception("Erreur de récupération des données");
//     }
//    }
//    catch (e) {
   
//     // Gérer les erreurs lors de l'appel HTTP
//     print("Erreur de requête HTTP: $e");
//     throw Exception("Erreur de requête HTTP: $e");
  
//   }
// }

static Future<List<AffichageHotelRestaurant>> afficheNoteCommentaire(int hotel_id) async {
  // print('Je veux hotel_id*******: ' + hotel_id.toString());
  final apiUrl = '${settingsCtrl.baseUrl}lireNoteCommentaireHotel/$hotel_id';
  var url = Uri.parse(apiUrl);
  var headers = await AuthService.getLoggedHeaders();

  try {
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // Analysez la réponse JSON (si c'est un tableau de données)
      List<dynamic> data = json.decode(response.body);

      // Créez une liste d'objets AffichageHotelRestaurant à partir des données
      List<AffichageHotelRestaurant> noteCommentaires = data.map((item) {
        // Ajoutez des vérifications pour éviter les valeurs null
        return AffichageHotelRestaurant.fromJson(item ?? {});
      }).toList();

      // print('Je print oh: ' + noteCommentaires.toString());
      return noteCommentaires;
    } else {
      // Gérer l'erreur, par exemple en lançant une exception
      throw Exception("Erreur de récupération des données");
    }
  } catch (e) {
    // Gérer les erreurs lors de l'appel HTTP
    print("Erreur de requête HTTP: $e");
    throw Exception("Erreur de requête HTTP: $e");
  }
}



}
