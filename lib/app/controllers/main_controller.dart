import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/auth_service.dart';
import '../data/repository/data/api_status.dart';
import '../modules/auth/user_model.dart';

class MainController extends GetxController {
  Color appbarColor = Color(0xFF51624F);
  Color appbarColorFromCode = '#fc9003'.toColor();
  Color secondaryColorFromCode = '#66ff76'.toColor();
  MaterialColor mainColor = createMaterialColor('#fc9003'.toColor());
  Color appbarTextColor = Colors.white;
  Color gris = Color(0xFFCCCCCC);
  Color menuColor = Color(0xFF51624F);
  Color vert_color_fonce = Color(0xFF51624F);

  var app_logo = "assets/images/logo/logo.png".obs;
  var isSettingProcessing = false.obs;
  var isCocody = true.obs;

  // var baseUrl = "https://sdcocody.siriusntech.digital/api/mobile/";
  // var siteUrl = "https://sdcocody.siriusntech.digital";
  var baseUrl = 'https://sdyakro.siriusntech.digital/api/mobile/';
  var siteUrl = 'https://sdyakro.siriusntech.digital';
  setToCocody() async {
    Get.back();
    isSettingProcessing(true);
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString("app_name", "cocody");
    app_logo.value = "assets/images/logo/logo.png";
    // baseUrl = "https://sdcocody.siriusntech.digital/api/mobile/";
    // siteUrl = "https://sdcocody.siriusntech.digital";
    var baseUrl = "https://sdyakro.siriusntech.digital/api/mobile/";
    var siteUrl = "https://sdyakro.siriusntech.digital";
    appbarColor = Color(0xFF51624F);
    ;
    appbarColorFromCode = '#fc9003'.toColor();
    secondaryColorFromCode = '#66ff76'.toColor();
    mainColor = createMaterialColor('#fc9003'.toColor());
    appbarTextColor = Colors.white;
    menuColor = Color(0xFF51624F);

    // Get.changeTheme(AppThemes.cocodyTheme);

    isCocody(true);
    await registerSwipeUser();

    Future.delayed(Duration(seconds: 3), () {
      isSettingProcessing(false);
      // homeCtrl.onInit();
    });
  }

  setToPlateau() async {
    Get.back();
    isSettingProcessing(true);
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString("app_name", "plateau");

    app_logo.value = "assets/images/logo_plateau/logo.png";
    baseUrl = 'http://sdplateau.siriusntech.digital/api/mobile/';
    siteUrl = 'http://sdplateau.siriusntech.digital';

    appbarColor = Colors.blueGrey;
    appbarColorFromCode = '#02205F'.toColor();
    secondaryColorFromCode = '#07aaf5'.toColor();
    mainColor = createMaterialColor('#02205F'.toColor());
    appbarTextColor = Colors.white;
    menuColor = Color(0xFFA2B4AC);


    // Get.changeTheme(AppThemes.plateauTheme);

    isCocody(false);
    await registerSwipeUser();

    Future.delayed(Duration(seconds: 3), () {
      isSettingProcessing(false);
      // homeCtrl.onInit();
    });
  }

  checkAppName() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var app_name = storage.getString("app_name");

    if (app_name != null && app_name != '') {
      if (app_name == "cocody") {
        await setToCocody();
        // await MainServices.reloadAllData();
        // Get.offNamed(AppRoutes.HOME);
      } else if (app_name == "plateau") {
        await setToPlateau();
        // await MainServices.reloadAllData();
        // Get.offNamed(AppRoutes.HOME);
      }
    } else {
      setToCocody();
    }
  }

  var userAuth = User();
  setUser(User puser) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    userAuth = puser;
    storage.setString("pseudo", userAuth.pseudo.toString());
    storage.setString("contact", userAuth.contact.toString());
    storage.setString("token", userAuth.token.toString());
    storage.setInt("user_id", userAuth.id!);
    storage.commit();
    // print('ps ID '+userAuth.id.toString());
    // print('ps '+userAuth.pseudo.toString());
    // print('ps token '+userAuth.token.toString());
    // print('ps contact '+userAuth.contact.toString());
  }

  registerSwipeUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var userAuthPseudo = storage.getString("pseudo");
    var userAuthContact = storage.getString("contact");
    var currentBaseUrl = isCocody.value == true
        // ? "https://sdcocody.siriusntech.digital/api/mobile/"
        ? "https://sdyakro.siriusntech.digital/api/mobile/"
        : 'http://sdplateau.siriusntech.digital/api/mobile/';
    // print('Coord: '+userAuthContact.toString()+' - '+userAuthPseudo.toString());
    // print('Base Url: '+currentBaseUrl.toString());
    try {
      var data = {"pseudo": userAuthPseudo, "contact": userAuthContact};
      var response = await AuthService.registerSwipeUser(data, currentBaseUrl);
      if (response is Success) {
        setUser(response.response as User);
      }
      if (response is Failure) {
        // print("Erreur "+response.errorResponse.toString());
      }
    } catch (ex) {
      // print("Exception  "+ex.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
