import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Pharmacie/path_pharmacie.dart';

class PharmacieScreenController extends GetxController {
  Rx<Color> colorPrimary = const Color(0xff2F536E).obs;
  Rx<Color> colorSecondary = Colors.amber.obs;
  final RxString title = 'Pharmacie de Garde'.obs;
  final MainController _mainController = Get.put(MainController());
  final PharmacieApiController _pharmacieApiController =
      Get.put(PharmacieApiController());
  final PharmacieSingleScreenController _pharmacieSingleScreenController =
      Get.put(PharmacieSingleScreenController());

  RxBool pharmacieLoading = false.obs;

  @override
  void onInit() {
    _mainController.onInit();
    _pharmacieApiController.onInit();
    _pharmacieSingleScreenController.onInit();
    AnalyticsService().logScreenView('PharmacieScreen', 'PharmacieScreen', {
      'screen_name': 'PharmacieScreen',
      'user_id': _mainController.userId.value.toString(),
      'device_id': _mainController.deviceId.value.toString(),
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // _pharmacieApiController.onClose();
    // _pharmacieSingleScreenController.onClose();
    super.onClose();
  }

  //Getters
  PharmacieApiController get pharmacieApiControllerGetter =>
      _pharmacieApiController;
  PharmacieSingleScreenController get pharmacieSingleScreenControllerGetter =>
      _pharmacieSingleScreenController;
}
