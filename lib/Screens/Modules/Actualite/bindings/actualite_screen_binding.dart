import 'package:jaime_yakro/Screens/Modules/Actualite/path_actualite.dart';
import 'package:get/get.dart';

class ActualiteScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActualiteScreenController>(() => ActualiteScreenController());
  }
}
