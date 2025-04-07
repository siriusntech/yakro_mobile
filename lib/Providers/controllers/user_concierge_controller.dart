import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Helpers/helpers.dart';
import 'package:jaime_yakro/Screens/Widgets/path_widget.dart';
import 'package:quickalert/models/quickalert_type.dart';

import '../path_providers.dart';

class UserConciergeController extends GetxController {
  final RxBool userConciergeLoading = false.obs;
  final RxList<UserBoutiqueModel> userConciergeList = <UserBoutiqueModel>[].obs;
  final Rx<UserBoutiqueModel?> userConcierge = Rx<UserBoutiqueModel?>(null);
  final UserConciergeService _userConciergeService = UserConciergeService();

  final MainController mainController = Get.find();
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> nomPrenomController =
      TextEditingController().obs;
  final Rx<TextEditingController> telephoneController =
      TextEditingController().obs;
  final Rx<TextEditingController> locationController =
      TextEditingController().obs;

  @override
  void onInit() {
    _userConciergeService.onInit();
    nomPrenomController.value.clear();
    telephoneController.value.clear();
    emailController.value.clear();
    locationController.value.clear();
    getUserConciergeWithDeviceId();
    super.onInit();
  }

  //create User Concierge
  Future<void> createUserConcierge(BuildContext context) async {
    Map<String, dynamic> data = {
      'email': emailController.value.text,
      'nom_prenoms': nomPrenomController.value.text,
      'telephone': telephoneController.value.text,
      'quartier': locationController.value.text,
      'pseudo': Helpers.generateRandomString(5),
      'device_id': mainController.deviceId.value,
      'device_model': mainController.deviceModel.value
    };
    print(data);
    userConciergeLoading.value = true;
    try {
      final response = await _userConciergeService.createUserConcierge(data);
      if (response.statusCode == 200) {
        Get.back();
        Navigator.pop(context);
        userConcierge.value = response.body!;
        userConciergeLoading.value = false;
        quickAlertDialog(context, QuickAlertType.success,
            message: "Enregistrement Effectué",
            title: "Success",
            color: const Color(0xff6CA0B6),
            onConfirmBtnTap: () => {
                  getUserConciergeWithDeviceId(),
                  Get.back(),
                  nomPrenomController.value.clear(),
                  telephoneController.value.clear(),
                  emailController.value.clear(),
                  locationController.value.clear()
                });
      } else {
        userConciergeLoading.value = false;
      }
    } catch (e) {
      userConciergeLoading.value = false;
    }
  }

  //get User Concierge with device id
  Future<void> getUserConciergeWithDeviceId() async {
    userConciergeLoading.value = true;
    try {
      final response = await _userConciergeService.getUserByDeviceId(
          mainController.deviceId.value, mainController.deviceModel.value);
      if (response.statusCode == 200) {
        userConciergeList.value = response.body!;
        userConciergeLoading.value = false;
      } else {
        userConciergeLoading.value = false;
      }
    } catch (e) {
      userConciergeLoading.value = false;
    }
  }
}
