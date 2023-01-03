import 'package:get/get.dart';

import '../controllers/historique_controller.dart';

class HistoriqueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoriqueController>(
      () => HistoriqueController(),
    );
  }
}
