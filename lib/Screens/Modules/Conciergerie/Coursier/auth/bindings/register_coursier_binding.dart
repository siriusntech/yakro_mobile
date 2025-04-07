import 'package:get/get.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Coursier/auth/path_auth_coursier.dart';

class RegisterCoursierBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterCoursierController>(() => RegisterCoursierController());
  }
}
