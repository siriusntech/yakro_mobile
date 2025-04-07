import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Commerce/path_commerce.dart';

class CommerceScreenController extends GetxController {
  var currentRangeValues = const RangeValues(0, 100000).obs;
  RxBool isLoading = false.obs;
  Rx<Color> colorPrimary = const Color(0xffEEB446).obs;
  RxString title = "Restaurant / Bar".obs;
  final CommerceSingleScreenController commerceSingleScreenController =
      Get.put(CommerceSingleScreenController());
  final CommerceController commerceController = Get.put(CommerceController());
  final TypeCommerceController typeCommerceController =
      Get.put(TypeCommerceController());
  final SpecialiteCommerceController specialiteCommerceController =
      Get.put(SpecialiteCommerceController());
  final MainController _mainController = Get.put(MainController());
  @override
  void onInit() {
    commerceController.onInit();
    commerceSingleScreenController.onInit();
    typeCommerceController.onInit();
    specialiteCommerceController.onInit();
    AnalyticsService().logScreenView('RestoBarScreen', 'RestoBarScreen', {
      'screen_name': 'RestoBarScreen',
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
    super.onClose();
  }

  //Getters
  CommerceController get commerceControllerGetter => commerceController;

  CommerceSingleScreenController get commerceSingleScreenControllerGetter =>
      commerceSingleScreenController;

  TypeCommerceController get typeCommerceControllerGetter =>
      typeCommerceController;

  SpecialiteCommerceController get specialiteCommerceControllerGetter =>
      specialiteCommerceController;
  //Setters
}
