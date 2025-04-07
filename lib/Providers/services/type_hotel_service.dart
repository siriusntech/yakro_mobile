import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class TypeHotelService extends GetConnect {
  final MainController mainController = Get.put(MainController());
  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    getAllTypeHotel();
    super.onInit();
  }

  //Get All type hotel
  Future<Response<List<TypeHotelModel>>> getAllTypeHotel() =>
      get('/type_hotels',
          headers: mainController.getLoggedHeaders(),
          decoder: (data) => List<TypeHotelModel>.from(
              data['data'].map((x) => TypeHotelModel.fromJson(x))));
}
