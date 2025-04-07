import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class SliderService extends GetConnect {
  final MainController mainController = Get.put(MainController());

  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    getAllSlider();
    super.onInit();
  }

  Future<Response<List<SliderModel>?>> getAllSlider() async {
    // print("==============GET ALL SLIDER==============");
    // print(mainController.getLoggedHeaders());
    return get('/slider_api_index', headers: mainController.getLoggedHeaders(),
        decoder: (data) {
      // print(data);
      if (data == null) return null;
      return List<SliderModel>.from(data.map((x) => SliderModel.fromJson(x)));
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
