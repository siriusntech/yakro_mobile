import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';

class SplashController extends GetxController {


  final authCtrl = AuthController();

  void navigateToHome() async{
    SharedPreferences storage = await SharedPreferences.getInstance();

    authCtrl.loadAuthInfo();
    if(authCtrl.getUserId != 0 && authCtrl.getUserId != null){
      authCtrl.getUserInfo();
    }
    var token = storage.getString('token');
     // print('token '+ token.toString());
    await Future.delayed(Duration(milliseconds: 2000), (){});
    if(token != null && token != '' && authCtrl.getUserIsActif != 0){
      Get.offNamed(AppRoutes.HOME);
    } else if(authCtrl.token == ''){
      storage.clear();
      // Get.offNamed(AppRoutes.AUTH);
      Get.offNamed(AppRoutes.DEBUT);
    } else if(authCtrl.getUserIsActif == 0 ){
      storage.clear();
      // Get.offNamed(AppRoutes.AUTH);
      Get.offNamed(AppRoutes.AUTH);
    }else{
      storage.clear();
      // Get.offNamed(AppRoutes.AUTH);
      Get.offNamed(AppRoutes.DEBUT);
    }
  }


  @override
  void onInit() {
    // print('token');
    super.onInit();
  }

  @override
  void onReady() {
    // print('token');
    super.onReady();
  }

  @override
  void onClose() {}

}
