import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/SiteTourisme/path_tourisme.dart';

class SiteTourismeScreenController extends GetxController {
  final RxString title = 'Site Touristique'.obs;
  final RxBool isLoading = false.obs;
  final Rx<Color> colorPrimary = const Color(0xff2E2E0F).obs;
  final Rx<Color> colorSecondary = Colors.amber.obs;
  final SiteTouristiqueApiController _siteTouristiqueApiController =
      Get.put(SiteTouristiqueApiController());
  final CategorieVtApiController _categorieVtApiController =
      Get.put(CategorieVtApiController());
  final SiteTourismeSingleScreenController siteTourismeSingleScreenController =
      Get.put(SiteTourismeSingleScreenController());
  final MainController _mainController = Get.put(MainController());
  @override
  void onInit() {
    _mainController.onInit();
    _siteTouristiqueApiController.onInit();
    _categorieVtApiController.onInit();
    AnalyticsService()
        .logScreenView('SiteTourismeScreen', 'SiteTourismeScreen', {
      'screen_name': 'SiteTourismeScreen',
      'user_id': _mainController.userId.value.toString(),
      'device_id': _mainController.deviceId.value.toString(),
    });
    super.onInit();
  }

  @override
  void onReady() {
    _categorieVtApiController.onReady();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //Getters
  SiteTouristiqueApiController get siteTouristiqueApiControllerGetter =>
      _siteTouristiqueApiController;

  SiteTourismeSingleScreenController
      get siteTourismeSingleScreenControllerGetter =>
          siteTourismeSingleScreenController;
  CategorieVtApiController get categorieVtApiControllerGetter =>
      _categorieVtApiController;
}
