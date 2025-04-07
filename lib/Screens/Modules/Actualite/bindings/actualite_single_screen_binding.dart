import 'package:jaime_yakro/Screens/Modules/Actualite/path_actualite.dart';
import 'package:get/get.dart';

class ActualiteSingleScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActualiteSingleScreenController>(
        () => ActualiteSingleScreenController());
  }
}
