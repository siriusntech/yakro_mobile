import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class BonPlanService extends GetConnect {
  final MainController _mainController = Get.put(MainController());
  @override
  void onInit() {
    _mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    getAllBonPlans();
    super.onInit();
  }

  //Get all Bon Plan
  Future<Response<List<BonPlanModel>>> getAllBonPlans() async {
    return get('/diffusions',
        headers: _mainController.getLoggedHeaders(),
        decoder: (data) => List<BonPlanModel>.from(
            data['data'].map((x) => BonPlanModel.fromJson(x))));
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
