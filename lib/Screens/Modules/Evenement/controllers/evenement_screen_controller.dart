import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class EvenementScreenController extends GetxController {
  Rx<Color> colorPrimary = const Color(0xFF673C0A).obs;
  var currentRangeValues = const RangeValues(0, 100000).obs;
  final RxString title = 'Bons Plans'.obs;
  RxBool isLoading = false.obs;
  Rx<DateTime> date = DateTime.now().obs;

  final BonPlanApiController _bonPlanApiController =
      Get.put(BonPlanApiController());

  @override
  void onInit() {
    // print("==============EVENEMENTS==============");
    _bonPlanApiController.onInit();
    AnalyticsService().logScreenView('BonPlanScreen', 'BonPlanScreen', {
      'screen_name': 'BonPlanScreen',
      'user_id': _bonPlanApiController.mainController.userId.value.toString(),
      'device_id':
      _bonPlanApiController.mainController.deviceId.value.toString(),
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
  BonPlanApiController get bonPlanApiControllerGetter => _bonPlanApiController;
}
