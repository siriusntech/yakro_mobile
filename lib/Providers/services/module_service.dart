import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class ModuleService extends GetConnect {
  final MainController _mainController = Get.put(MainController());
  @override
  void onInit() {
    _mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    getAllModules();
    super.onInit();
  }

  //Get all Bon Plan
  Future<Response<List<ModuleModel>>> getAllModules() async {
    // print('======GET ALL MODULES SERVICE=======');
    return get('/modules',
        headers: _mainController.getLoggedHeaders(),
        decoder: (data){
      return List<ModuleModel>.from(
          data['data'].map((x) => ModuleModel.fromJson(x))
      );
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
