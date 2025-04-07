import 'package:get/get.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Coursier/auth/path_auth_coursier.dart';

class ProfilCoursierBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilCoursierController>(() => ProfilCoursierController());
  }
}
