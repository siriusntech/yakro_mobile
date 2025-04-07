import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class VisiteApiController extends GetxController {
  final VisiteService _visiteService = VisiteService();
  @override
  void onInit() {
    _visiteService.onInit();
    super.onInit();
  }

  //add Visite
  Future<void> addVisite(String module) async {
    // print('======POST ADD VISITE $module=======');
    try {
      final response = await _visiteService.addVisite(module);
      if (response.statusCode == 200) {
        // print(response.body);
      } else {
        // print(response.body);
      }
    } catch (e) {
      print(e);
    }
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
