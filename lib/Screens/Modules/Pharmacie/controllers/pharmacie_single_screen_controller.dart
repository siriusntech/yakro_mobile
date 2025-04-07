import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class PharmacieSingleScreenController extends GetxController {
  Rx<Color> colorPrimary = const Color(0xff2F536E).obs;
  Rx<PharmacieModel> pharmacieModel = PharmacieModel().obs;
  @override
  void onInit() {
    super.onInit();
  }

  void setPharmcieModel(PharmacieModel pharmacieModel) {
    this.pharmacieModel.value = pharmacieModel;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
