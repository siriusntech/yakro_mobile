import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Helpers/helpers.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:quickalert/models/quickalert_type.dart';

import '../../Screens/Widgets/path_widget.dart';

class UserBoutiqueController extends GetxController {
  final RxBool userBouttiqueLoading = false.obs;
  final RxList<UserBoutiqueModel> userBoutiqueList = <UserBoutiqueModel>[].obs;
  final Rx<UserBoutiqueModel?> userBoutique = Rx<UserBoutiqueModel?>(null);
  final UserBoutiqueService _userBoutiqueService = UserBoutiqueService();
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
    _userBoutiqueService.onInit();
    nomPrenomController.value.clear();
    telephoneController.value.clear();
    emailController.value.clear();
    locationController.value.clear();
    super.onInit();
  }

  //add user boutique
  Future<void> addUserBoutique(BuildContext context) async {
    Map<String, dynamic> data = {
      'email': emailController.value.text,
      'nom_prenoms': nomPrenomController.value.text,
      'telephone': telephoneController.value.text,
      'quartier': locationController.value.text,
      'pseudo': Helpers.generateRandomString(5),
      'device_id': mainController.deviceId.value,
      'device_model': mainController.deviceModel.value
    };

    // print(data);
    userBouttiqueLoading.value = true;
    try {
      final response = await _userBoutiqueService.addUserBoutique(data);
      // print(response.body);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        userBoutique.value = response.body!;
        userBouttiqueLoading.value = false;
        getUserBoutiqueWithDeviceId();

        quickAlertDialog(context, QuickAlertType.success,
            message: "Nouvelle Adresse ajoutée",
            title: "Success",
            color: ConstColors.vertColorFonce,
            onConfirmBtnTap: () => {
                  Get.back(),
                  nomPrenomController.value.clear(),
                  telephoneController.value.clear(),
                  emailController.value.clear(),
                  locationController.value.clear()
                });
      } else {
        userBouttiqueLoading.value = false;
      }
    } catch (e) {
      userBouttiqueLoading.value = false;
    }
  }

  //get User Boutique with device id
  Future<void> getUserBoutiqueWithDeviceId() async {
    userBouttiqueLoading.value = true;
    try {
      final response = await _userBoutiqueService.getUserByDeviceId(
          mainController.deviceId.value, mainController.deviceModel.value);
      // print(response.body);
      if (response.statusCode == 200) {
        userBoutiqueList.value = response.body!;
        userBouttiqueLoading.value = false;
      } else {
        userBouttiqueLoading.value = false;
      }
    } catch (e) {
      userBouttiqueLoading.value = false;
    }
  }

  //edit user boutique
  Future<void> editUserBoutique(int userBoutiqueId) async {}

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
