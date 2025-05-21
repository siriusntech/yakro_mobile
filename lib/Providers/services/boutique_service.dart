import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class BoutiqueService extends GetConnect {
  final MainController mainController = Get.put(MainController());
  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    getShippingByCurrentHour();
    super.onInit();
  }

  //get Shipping by current Hour
  Future<Response<ShippingBoutiqueModel>> getShippingByCurrentHour() async {
    // print('=============GET CURRENT SHIPPING ================');
    return get(
      '/boutique/get_shipping_by_hour',
      headers: mainController.getLoggedHeaders(),
      decoder: (data) => ShippingBoutiqueModel.fromJson(data['data']),
    );
  }

  Future<Response<ShippingBoutiqueModel>> getShippingById(int id) async {
    // print('=============GET CURRENT SHIPPING ================');
    return get(
      '/boutique/get_shipping/$id',
      headers: mainController.getLoggedHeaders(),
      decoder: (data) => ShippingBoutiqueModel.fromJson(data['data']),
    );
  }

  Future<Response<OrderBoutiqueModel>> validerCommande(
      Map<String, dynamic> data) async {
    // print('=============POST COMMANDE ================');
    // print(data);
    return post(
      '/boutique/order/store',
      data,
      headers: mainController.getLoggedHeaders(),
      decoder: (data) {
        // print(data);
        return OrderBoutiqueModel.fromJson(data['data']);
      },
    );
  }

  //get All Order With status
  Future<Response<List<OrderBoutiqueModel>>> getAllOrderWithStatus(
      String status) async {
    // print('=============GET ALL ORDER WITH STATUS ================');
    return get('/boutique/orders/$status',
        headers: mainController.getLoggedHeaders(),
        decoder: (data) => List<OrderBoutiqueModel>.from(
              data['data'].map((e) => OrderBoutiqueModel.fromJson(e)),
            ));
  }

  @override
  void onClose() {
    super.onClose();
  }
}
