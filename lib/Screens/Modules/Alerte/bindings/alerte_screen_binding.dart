import 'package:jaime_yakro/Screens/Modules/Alerte/path_alerte.dart';
import 'package:get/get.dart';

class AlerteScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlerteScreenController>(() => AlerteScreenController());
  }
}
