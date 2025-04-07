import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class PharmacieService extends GetConnect {
  final MainController _mainController = Get.put(MainController());
  @override
  void onInit() {
    _mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    getAllPharmacie();
    super.onInit();
  }

  //get all Pahrmacie
  Future<Response<List<PharmacieModel>>> getAllPharmacie() async {
    return get('/pharmacies', headers: _mainController.getLoggedHeaders(),
        decoder: (data) {
      // print(data['data']);
      return List<PharmacieModel>.from(
          data['data'].map((x) => PharmacieModel.fromJson(x)));
    });
  }

  //get all zone
  Future<Response<List<ZoneModel>>> getAllZone() async {
    return get('/m-get-zones',
        headers: _mainController.getLoggedHeaders(),
        decoder: (data) => List<ZoneModel>.from(
            data['data'].map((x) => ZoneModel.fromJson(x))));
  }

  //get all Pharmacie by zone
  Future<Response<List<PharmacieModel>>> getAllPharmacieByZone(
      int zoneId) async {
    return get('/pharmacies_by_zone/$zoneId',
        headers: _mainController.getLoggedHeaders(), decoder: (data) {
      // print(data['data']);
      return List<PharmacieModel>.from(
          data['data'].map((x) => PharmacieModel.fromJson(x)));
    });
  }

  @override
  void onReady() {
    getAllPharmacie();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
