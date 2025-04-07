import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Debut/path_debut.dart';
import 'package:get/get.dart';

class DebutScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DebutScreeenController>(() => DebutScreeenController());
    Get.lazyPut<ModuleController>(() => ModuleController());
  }
}
