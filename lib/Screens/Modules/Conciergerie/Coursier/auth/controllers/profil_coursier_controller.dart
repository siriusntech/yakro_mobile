import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Widgets/path_widget.dart';
import 'package:jaime_yakro/routes/path_route.dart';
import 'package:quickalert/models/quickalert_type.dart';

class ProfilCoursierController extends GetxController {
  Rx<Color> colorPrimary = const Color(0xFF0256BB).obs;
  final RxString title = 'Coursier Profile'.obs;

  final CoursierConciergerieService _coursierConciergerieService =
      CoursierConciergerieService();
  final MainController mainController = Get.find<MainController>();
  Rx<CoursierConciergeModel?> coursierConciergeModel =
      CoursierConciergeModel().obs; //coursier concierge>
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> nomController = TextEditingController().obs;
  Rx<TextEditingController> prenomController = TextEditingController().obs;
  Rx<TextEditingController> telephoneController_1 = TextEditingController().obs;
  Rx<TextEditingController> telephoneController_2 = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  Rx<TextEditingController> verifTelephoneController =
      TextEditingController().obs;
  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<TextEditingController> newOtpController = TextEditingController().obs;
  RxBool showInputOtp = false.obs;
  RxBool showInputNewPassword = false.obs;
  RxBool resetPassword = false.obs;

  RxBool visiblePassword = true.obs;
  final RxBool coursierConciergeLoading = false.obs;
  Rx<CoursierConciergeModel?> coursierConciergeModelUpdate =
      CoursierConciergeModel().obs;
  CoursierConciergerieController coursierConciergerieController =
      Get.find<CoursierConciergerieController>();
  Rx<XFile>? imagesFile;
  RxMap fileTypeDoc = {}.obs;

  @override
  void onInit() {
    _coursierConciergerieService.onInit();
    coursierConciergerieController.onInit();
    mainController.onInit();
    coursierConciergeModel =
        coursierConciergerieController.coursierConciergeModel;
    nomController.value = TextEditingController(
        text: coursierConciergerieController.coursierConciergeModel.value!.nom);
    prenomController.value = TextEditingController(
        text: coursierConciergerieController
            .coursierConciergeModel.value!.prenoms);
    emailController.value = TextEditingController(
        text:
            coursierConciergerieController.coursierConciergeModel.value!.email);
    telephoneController_1.value = TextEditingController(
        text: coursierConciergerieController
            .coursierConciergeModel.value!.telephone1);
    telephoneController_2.value = TextEditingController(
        text: coursierConciergerieController
            .coursierConciergeModel.value!.telephone2);

    // verifTelephoneController.tex;
    // resetPassword.value = false;
    // showInputOtp.value = false;
    // showInputNewPassword.value = false;
    // newPasswordController.close();
    // newOtpController.close();
    super.onInit();
  }

  Future<void> addImages() async {
    final picker = ImagePicker();
    final XFile? images = await picker.pickImage(source: ImageSource.camera);

    if (images != null) {
      imagesFile = images.obs;
      // fileTypeDoc.addAll({type: images});
      update();
    }
  }

  //update Profil Coursier
  Future<void> updateProfilCoursier() async {
    coursierConciergeLoading.value = true;
    if (imagesFile != null) {
      final response = await _coursierConciergerieService
          .createCoursierConciergeProfileImg(imagesFile!.value);
    }

    Map<String, dynamic> data = {
      'nom': nomController.value.text,
      'prenoms': prenomController.value.text,
      'email': emailController.value.text,
      // 'telephone_1':telephoneController_1.value.text,
      'telephone_2': telephoneController_2.value.text,
    };
    try {
      final response = await _coursierConciergerieService.updateProfilCoursier(
          data,
          coursierConciergerieController.coursierConciergeModel.value!.id
              .toString());
      if (response.statusCode == 200) {
        coursierConciergeLoading.value = false;
        coursierConciergerieController.showCoursierConcierge();
        quickAlertDialog(Get.context!, QuickAlertType.success,
            color: ConstColors.alertSuccess,
            title: 'Succès',
            message: 'Profil mis à jour avec succès');
      }
    } catch (e) {
      // print(e);
      Get.snackbar('Erreur', e.toString(),
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          backgroundColor: ConstColors.alertDanger,
          colorText: Colors.white);
      coursierConciergeLoading.value = false;
    }
  }

  Future<void> sendOtp() async {
    resetPassword.value = true;
    try {
      final response = await _coursierConciergerieService
          .sendOtp(verifTelephoneController.value.text);
      // print(response.body);
      if (response.statusCode == 200) {
        showInputOtp.value = true;
        resetPassword.value = false;
      } else {
        resetPassword.value = false;
        Get.snackbar('Erreur', response.body!['message'],
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            backgroundColor: ConstColors.alertDanger,
            colorText: Colors.white);
      }
    } catch (e) {
      // print(e);
      Get.snackbar('Erreur', e.toString(),
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          backgroundColor: ConstColors.alertDanger,
          colorText: Colors.white);
      resetPassword.value = false;
    }
  }

  Future<void> verifyOtp() async {
    resetPassword.value = true;
    try {
      final response = await _coursierConciergerieService.verifyOtp(
          newOtpController.value.text, verifTelephoneController.value.text);
      // print(response.body);

      if (response.statusCode == 200) {
        showInputNewPassword.value = true;
        showInputOtp.value = false;
        resetPassword.value = false;
      } else {
        resetPassword.value = false;
        Get.snackbar('Erreur', response.body!['message'],
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            backgroundColor: ConstColors.alertDanger,
            colorText: Colors.white);
      }
    } catch (e) {
      (e);
      Get.snackbar('Erreur', e.toString(),
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          backgroundColor: ConstColors.alertDanger,
          colorText: Colors.white);
      resetPassword.value = false;
    }
  }

  Future<void> changePassword() async {
    resetPassword.value = true;
    try {
      final response = await _coursierConciergerieService.changePassword(
          newPasswordController.value.text,
          verifTelephoneController.value.text);
      // print(response.body);
      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar('Succès', response.body!['message'],
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ),
            backgroundColor: ConstColors.alertSuccess,
            colorText: Colors.white);
        showInputNewPassword.value = false;
        resetPassword.value = false;
        showInputOtp.value = false;
        newPasswordController.value.clear();
        newOtpController.value.clear();
        verifTelephoneController.value.clear();
        mainController.setCoursierConnected(false);

        Get.offNamed(AppRoutes.homeScreen);
      } else {
        resetPassword.value = false;
        Get.snackbar('Erreur', response.body!['message'],
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            backgroundColor: ConstColors.alertDanger,
            colorText: Colors.white);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Erreur', e.toString(),
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          backgroundColor: ConstColors.alertDanger,
          colorText: Colors.white);
      resetPassword.value = false;
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

  //Getters
}
