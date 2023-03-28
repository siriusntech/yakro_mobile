import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/Utils/app_themes.dart';
import 'package:jaime_cocody/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {

  Color appbarColor = Colors.orange;
  Color appbarColorFromCode = '#fc9003'.toColor();
  Color secondaryColorFromCode = '#66ff76'.toColor();
  MaterialColor mainColor = createMaterialColor('#fc9003'.toColor());
  Color appbarTextColor = Colors.white;
  Color menuColor = Colors.orange;
  Color chip_color = Color(0xFFeeeeee);

  var app_logo = "".obs;
  var isSettingProcessing = false.obs;
  var isCocody = false.obs;

  var baseUrl = "";
  var siteUrl = "";


  setToCocody() async{
    Get.back();
    isSettingProcessing(true);
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString("app_name", "cocody");
    app_logo.value = "assets/images/logo/logo.png";
    baseUrl = "https://sdcocody.siriusntech.digital/api/mobile/";
    siteUrl = "https://sdcocody.siriusntech.digital";

    appbarColor = Colors.orange;
    appbarColorFromCode = '#fc9003'.toColor();
    secondaryColorFromCode = '#66ff76'.toColor();
    mainColor = createMaterialColor('#fc9003'.toColor());
    appbarTextColor = Colors.white;
    menuColor = Colors.orange;
    chip_color = Color(0xFFeeeeee);

    // Get.changeTheme(AppThemes.cocodyTheme);

    isCocody(true);
    Future.delayed(Duration(seconds: 3), (){
       isSettingProcessing(false);
    });
  }

  setToPlateau() async{
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
    menuColor = Colors.lightBlue;
    chip_color = Color(0xFFeeeeee);

    // Get.changeTheme(AppThemes.plateauTheme);

    isCocody(false);
    Future.delayed(Duration(seconds: 2), (){
      isSettingProcessing(false);
    });
  }

  checkAppName() async{
    SharedPreferences storage = await SharedPreferences.getInstance();
    var app_name = storage.getString("app_name");

    if(app_name != ''){
      if(app_name =="cocody"){
        setToCocody();
      }else if(app_name =="plateau"){
        setToPlateau();
      }
    }else{
      setToCocody();
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
