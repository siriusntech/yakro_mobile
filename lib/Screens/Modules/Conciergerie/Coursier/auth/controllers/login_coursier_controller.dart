import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/routes/path_route.dart';

class LoginCoursierController extends GetxController {
  Rx<Color> colorPrimary = const Color(0xFF0256BB).obs;
  RxString title = 'Coursier Login'.obs;
  RxBool coursierConciergeLoading = false.obs;
  RxBool visiblePassword = true.obs;
  final MainController _mainController = Get.find();
  final CoursierConciergerieService _coursierConciergerieService =
      CoursierConciergerieService();
  Rx<TextEditingController> telephoneController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<CoursierConciergeModel?> coursierConciergeModel =
      CoursierConciergeModel().obs; //coursier concierge>

  @override
  void onInit() {
    _mainController.onInit();
    _coursierConciergerieService.onInit();
    super.onInit();
  }

  //login Coursier Concierge
  Future<void> loginCoursierConcierge() async {
    coursierConciergeLoading.value = true;
    try {
      Map<String, dynamic> data = {
        'telephone': telephoneController.value.text,
        'password': passwordController.value.text,
      };
      // print(data);return ;
      final response =
          await _coursierConciergerieService.loginCoursierConcierge(data);
      coursierConciergeModel.value = response.body;
      // print(coursierConciergeModel.value!.nom);
      if (coursierConciergeModel.value!.nom != null) {
        _mainController.setCoursierConnected(true);
        Get.offNamed(AppRoutes.homeCoursierScreen);
      }
      coursierConciergeLoading.value = false;
    } catch (e) {
      coursierConciergeLoading.value = false;
      // Get.snackbar('Erreur', e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  //change visibility password
  void changeVisibilityPassword() {
    visiblePassword.value = !visiblePassword.value;
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
