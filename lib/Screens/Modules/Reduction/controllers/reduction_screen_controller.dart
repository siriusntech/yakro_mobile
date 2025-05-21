import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Providers/services/reduction_service.dart';
import 'package:quickalert/models/quickalert_type.dart';

import '../../../Widgets/alert_dialog_windget.dart';

class ReductionScreenController extends GetxController {
  Rx<Color> colorPrimary = const Color(0xFF0D5CCC).obs;
  final ReductionService _reductionervice = ReductionService();
  RxBool reductionLoading = false.obs;
  RxMap reductionModel = {}.obs;
  Rx<HotelModel> hotelModel = HotelModel().obs;

  @override
  void onInit() {
    _reductionervice.onInit();
    super.onInit();
  }

  Future<void> addReduction(Map<String, dynamic> data) async {
    reductionLoading.value = true;
    try {
      final response = await _reductionervice.addReduction(data);
      reductionModel.value = response.body!;
      if (response.statusCode == 200) {
        Get.back();
        quickAlertDialog(Get.context!, QuickAlertType.success,
            color: ConstColors.vertColorFonce,
            message: "Réservation Effectuée",
            title: "Success",
            onConfirmBtnTap: () => Get.back());
      } else {
        quickAlertDialog(Get.context!, QuickAlertType.error,
            color: ConstColors.alertDanger,
            message: "Réservation Echouée",
            title: "Erreur",
            onConfirmBtnTap: () => Get.back());
      }
      reductionLoading.value = false;
    } catch (e) {
      reductionLoading.value = false;
    }
  }

  Future<void> checkHotel(String hotelCode) async {
    reductionLoading.value = true;
    try {
      final response = await _reductionervice.checkHotel(hotelCode);
      hotelModel.value = response.body!;

      if (response.statusCode != 200) {
        Get.back();
        Get.back();
        quickAlertDialog(Get.context!, QuickAlertType.error,
            color: ConstColors.alertDanger,
            message: "Réservation Echoué",
            title: "Erreur",
            onConfirmBtnTap: () => Get.back());
      }

      reductionLoading.value = false;
    } catch (e) {
      reductionLoading.value = false;
    }
  }

  Future<void> changeReservations(String hotelCode) async {
    reductionLoading.value = true;
    try {
      final response = await _reductionervice.changeReservations(hotelCode);
      if (response.statusCode == 200) {
        Get.back();
        quickAlertDialog(Get.context!, QuickAlertType.success,
            color: ConstColors.vertColorFonce,
            message: "Reduction Effectué",
            title: "Success",
            onConfirmBtnTap: () => Get.back());
      } else {
        quickAlertDialog(Get.context!, QuickAlertType.error,
            color: ConstColors.alertDanger,
            message: "Reduction Echoué",
            title: "Erreur",
            onConfirmBtnTap: () => Get.back());
      }

      reductionLoading.value = false;
    } catch (e) {
      reductionLoading.value = false;
    }
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
