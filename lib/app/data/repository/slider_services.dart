import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jaime_yakro/app/data/repository/auth_service.dart';
import 'package:jaime_yakro/app/data/repository/data/Env.dart';
import 'package:jaime_yakro/app/data/repository/data/api_status.dart';
import 'package:get/get.dart';
import '../../controllers/main_controller.dart';
import '../../models/slider.dart';
import '../../modules/hotel/hotel_model_model.dart';


class SliderServices {
  static MainController settingsCtrl = Get.put(MainController());
  static var client = http.Client();


  static Future<Object> getSliders() async {
    var headers = await AuthService.getLoggedHeaders();
    try {
      final apiUrl = settingsCtrl.baseUrl + 'slider_api_index';
      var url = Uri.parse(apiUrl);
      print('Slider Url: ' + url.toString());
      var response = await http.get(url, headers: headers);
      print('Slider response status code: ' + response.statusCode.toString());
      print('Slider response body: ' + response.body.toString());
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<SliderModel> sliders = [];
        for (var json in jsonResponse) {
          sliders.add(SliderModel.fromJson(json));
        }
        return sliders;
      }

      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Réponse invalide');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connexion internet");
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: "Pas de connexion internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Format invalide');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Erreur inconnue');
    }
  }


  static Future<HotelModel?> fetchHotels() async {
    var response = await client.get(Uri.parse("https://sdyakro.siriusntech.digital/api/mobile/hotelsIndex"));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return HotelModel.fromJson(jsonMap);
    } else {
      print("Impossible de charger");
      return null;
    }
  }


}
