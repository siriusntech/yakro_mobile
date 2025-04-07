import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class SpecialiteCommerceService extends GetConnect {
  final MainController mainController = Get.put(MainController());
  @override
  void onInit() {
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    getAllSpecialite();
    super.onInit();
  }

  //Get All Specialite
  Future<Response<List<SpecialiteCommerceModel>>> getAllSpecialite() async {
    return await get("/specialites",
        headers: mainController.getLoggedHeaders(),
        decoder: (data) => List<SpecialiteCommerceModel>.from(
            data['data'].map((x) => SpecialiteCommerceModel.fromJson(x))));
  }
}
