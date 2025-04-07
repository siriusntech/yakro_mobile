import 'package:jaime_yakro/Screens/Modules/Evenement/path_evenement.dart';
import 'package:get/get.dart';

class EvenementSingleScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EvenementSingleScreenController());
  }
}
