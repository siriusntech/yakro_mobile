import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/app_routes.dart';
import '../../../controllers/main_controller.dart';
import '../../auth/controllers/auth_controller.dart';

class SplashController extends GetxController {


  final authCtrl = AuthController();
  final MainController mainCtrl = Get.put(MainController());

  void navigateToHome() async{
    SharedPreferences storage = await SharedPreferences.getInstance();

    authCtrl.loadAuthInfo();
    if(authCtrl.getUserId != 0 && authCtrl.getUserId != null){
      authCtrl.getUserInfo();
    }
    var token = storage.getString('token');
      print('token '+ token.toString());
    await Future.delayed(Duration(milliseconds: 2500), (){

    });
    if(token != null && token != ''){
      Get.offNamed(AppRoutes.HOME);
    } else if(token == '' || token == null){
      storage.clear();
       // Get.offNamed(AppRoutes.AUTH);
      Get.offNamed(AppRoutes.DEBUT);
    } else{
      storage.clear();
      // Get.offNamed(AppRoutes.AUTH);
      Get.offNamed(AppRoutes.DEBUT);
    }
  }

  checkAppName() async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    // var app_name = storage.getString("app_name");
    // if(app_name == null){
    //   storage.setString("app_name", "cocody");
    // }
    print("splash main ctrl");
    if(storage.getString("token") != null){
       mainCtrl.checkAppName();
    }
  }

  @override
  void onInit() {
    // print('token');
    super.onInit();
    // checkAppName();
  }

  @override
  void onReady() {
    // print('token');
    super.onReady();
  }

  @override
  void onClose() {}

}
