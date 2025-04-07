import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Coursier/path_coursier.dart';

class RegisterCoursierController extends GetxController {
  Rx<Color> colorPrimary = const Color(0xFF0256BB).obs;
  RxString title = 'Coursier'.obs;
  final RxList document = ['Recto', 'Verso'].obs;
  final RxBool coursierConciergeLoading = false.obs;
  final RxBool coursierConciergeDocUploading = false.obs;
  RxMap fileTypeDoc = {}.obs;
  Map dataDocument = {};
  Rx<XFile>? imagesFile = XFile('').obs;
  RxBool visiblePassword = true.obs;
  final HomeCoursierScreenController _homeCoursierScreenController =
      Get.put(HomeCoursierScreenController());

  Future<void> addImages(String type) async {
    final picker = ImagePicker();
    final XFile? images = await picker.pickImage(source: ImageSource.camera);

    if (images != null) {
      imagesFile = images.obs;
      fileTypeDoc.addAll({type: images});
      update();
    }
  }

  final CoursierConciergerieService _coursierConciergerieService =
      CoursierConciergerieService();
  Rx<CoursierConciergeModel?> coursierConciergeModel =
      CoursierConciergeModel().obs; //coursier concierge>
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> nomController = TextEditingController().obs;
  Rx<TextEditingController> prenomController = TextEditingController().obs;
  Rx<TextEditingController> telephoneController_1 = TextEditingController().obs;
  Rx<TextEditingController> telephoneController_2 = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  @override
  void onInit() {
    _coursierConciergerieService.onInit();
    _homeCoursierScreenController.onInit();
    showCoursierConcierge();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  //add coursier concierge
  Future<void> addCoursierConcierge() async {
    Map<String, dynamic> data = {
      'nom': nomController.value.text,
      'prenoms': prenomController.value.text,
      'email': emailController.value.text,
      'telephone_1': telephoneController_1.value.text,
      'telephone_2': telephoneController_2.value.text,
      'password': passwordController.value.text
    };

    coursierConciergeLoading.value = true;
    if (data['nom'] == '' ||
        data['prenoms'] == '' ||
        data['email'] == '' ||
        data['telephone_1'] == '' ||
        data['telephone_2'] == '' ||
        data['password'] == '') {
      Get.snackbar('Erreur', 'Veuillez remplir tous les champs',
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
          ),
          backgroundColor: ConstColors.alertWarnig,
          colorText: Colors.white);
      coursierConciergeLoading.value = false;
      return;
    }

    try {
      final response =
          await _coursierConciergerieService.addCoursierConcierge(data);
      // print(response.body);
      if (response.statusCode == 200) {
        showCoursierConcierge();
        Get.snackbar('Success', 'Coursier Concierge ajouté avec succès',
            icon: const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
            ),
            backgroundColor: ConstColors.alertSuccess,
            colorText: Colors.white);
        coursierConciergeLoading.value = false;
      } else {
        Get.snackbar('Erreur', 'Erreur veuillez réessayer plus tard',
            icon: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
            ),
            backgroundColor: ConstColors.alertWarnig,
            colorText: Colors.white);
        // Get.snackbar('Erreur', '${response.body['message']}');
        coursierConciergeLoading.value = false;
      }
    } catch (e) {
      coursierConciergeLoading.value = false;
    }
  }

  Future<void> showCoursierConcierge() async {
    coursierConciergeLoading.value = true;
    try {
      final response =
          await _coursierConciergerieService.showCoursierConcierge();
      // print(response!.body);
      coursierConciergeModel.value = response!.body;
      coursierConciergeLoading.value = false;
    } catch (e) {
      coursierConciergeLoading.value = false;
      // Get.snackbar('Erreur', e.toString(), icon: const Icon(Icons.close, color: Colors.white,), backgroundColor: ConstColors.alertDanger, colorText: Colors.white);
    }
  }

  Future<void> createCoursierConciergeDocument() async {
    try {
      coursierConciergeDocUploading.value = true;
      final response = await _coursierConciergerieService
          .createCoursierConciergeDocument(fileTypeDoc);

      if (response.statusCode == 200) {
        showCoursierConcierge();
        Get.snackbar('Success', 'Document ajouté avec succès',
            icon: const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
            ),
            backgroundColor: ConstColors.alertSuccess,
            colorText: Colors.white);
        Navigator.pop(Get.overlayContext!);
        coursierConciergeDocUploading.value = false;
      } else {
        Get.snackbar('Erreur', 'Erreur veuillez réessayer plus tard',
            icon: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
            ),
            backgroundColor: ConstColors.alertWarnig,
            colorText: Colors.white);
        coursierConciergeDocUploading.value = false;
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
      coursierConciergeDocUploading.value = false;
    }
  }

  //change visibility password
  void changeVisibilityPassword() {
    visiblePassword.value = !visiblePassword.value;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
