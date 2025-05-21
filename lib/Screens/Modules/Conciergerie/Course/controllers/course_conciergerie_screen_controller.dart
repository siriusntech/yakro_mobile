import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Course/path_course.dart';
import 'package:jaime_yakro/Screens/Widgets/path_widget.dart';
import 'package:quickalert/models/quickalert_type.dart';

import '../../../../../../Providers/path_providers.dart';

class CourseConciergerieScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool courseConciergerieLoading = false.obs;
  RxBool courseConciergerieEnAttenteLoading = false.obs;
  RxBool courseConciergerieEnCoursLoading = false.obs;
  RxBool courseConciergerieTerminerLoading = false.obs;
  RxBool updateTacheCourseConciergerieLoading = false.obs;
  RxBool acceptCourseConciergerieLoading = false.obs;

  // Reactive enum value
  Rx<Status>? selectedStatus = Status.en_cours.obs;

  RxBool createCourseConciergerieLoading = false.obs;
  Rx<Color> colorPrimary = const Color(0xff434242).obs;
  RxString title = "On s'en occupe".obs;
  RxMap datas = {}.obs;
  RxString amountCourse = ''.obs;
  Rx<UserBoutiqueModel?> userConcierge = Rx<UserBoutiqueModel?>(null);
  Rx<CourseConciergeModel?> courseConcierge = Rx<CourseConciergeModel?>(null);
  RxList<CourseConciergeModel> courseConciergerieList =
      <CourseConciergeModel>[].obs;
  RxList<CourseConciergeModel> courseConciergerieListByCoursier =
      <CourseConciergeModel>[].obs;
  RxList<CourseConciergeModel> courseConciergerieListEnAttenteByCoursier =
      <CourseConciergeModel>[].obs;
  RxList<CourseConciergeModel> courseConciergerieListEnCoursByCoursier =
      <CourseConciergeModel>[].obs;
  RxList<CourseConciergeModel> courseConciergerieListTerminerByCoursier =
      <CourseConciergeModel>[].obs;

  Rx<TextEditingController> descriptionController = TextEditingController().obs;

  RxString codeCourse = ''.obs;
  final MainController _mainController = Get.put(MainController());
  final CourseConciergerieService conciergerieService =
      CourseConciergerieService();

  final VisiteApiController _visiteApiController =
      Get.put(VisiteApiController());
  @override
  void onInit() {
    datas.clear();
    _mainController.onInit();
    conciergerieService.onInit();
    getCourseConciergerieListByUser();
    getCourseConciergerieListTerminerByCoursier();
    getCourseConciergerieListEnCoursByCoursier();
    getCourseConciergerieListEnAttenteByCoursier();
    _visiteApiController.addVisite('conciergerie');
    descriptionController.value.clear();
    AnalyticsService()
        .logScreenView('ConciergerieCourseScreen', 'ConciergerieCourseScreen', {
      'screen_name': 'ConciergerieCourseScreen',
      'user_id': _mainController.userId.value.toString(),
      'device_id': _mainController.deviceId.value.toString(),
    });
    super.onInit();
  }

  Future<void> createNewCourseConciergerie(BuildContext context) async {
    // print(data);
    createCourseConciergerieLoading.value = true;
    try {
      final response = await conciergerieService.createCourseConciergerie(
          datas, codeCourse.value);

      if (response.statusCode == 200) {
        courseConcierge.value = response.body;
        createCourseConciergerieLoading.value = false;
        // print(createCourseConciergerieLoading.value);
      }
      getCourseConciergerieListByUser();
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      createCourseConciergerieLoading.value = false;
    }
  }

  Future<void> parseTextEditindInputInMap(data) async {
    datas.clear();
    List<String> tache = [];
    for (int i = 0; i < data.length; i++) {
      tache.add(data[i].text);
    }

    if (data.length >= 1 && data.length <= 3) {
      amountCourse.value = '5.000';
    } else if (data.length > 3) {
      amountCourse.value = '10.000';
    }

    update();
    datas.addAll({
      'taches': tache,
      'code_course': codeCourse.value,
      'amount': amountCourse.value
    });
  }

  void changeUserConcierge(UserBoutiqueModel user) {
    userConcierge.value = user;
    update();
  }

  Future<void> getCourseConciergerieListByUser() async {
    courseConciergerieLoading.value = true;
    try {
      final response =
          await conciergerieService.getCourseConciergerieListByUser();
      if (response.statusCode == 200) {
        courseConciergerieList.value = response.body!;
        courseConciergerieLoading.value = false;
      } else {
        courseConciergerieLoading.value = false;
      }
    } catch (e) {
      courseConciergerieLoading.value = false;
    }
  }

  Future<void> getCourseConciergerieListByCoursier() async {
    courseConciergerieLoading.value = true;
    try {
      final response =
          await conciergerieService.getCourseConciergerieListByCoursier();
      if (response.statusCode == 200) {
        courseConciergerieListByCoursier.value = response.body!;
        courseConciergerieLoading.value = false;
      } else {
        courseConciergerieLoading.value = false;
      }
    } catch (e) {
      courseConciergerieLoading.value = false;
    }
  }

  //en attente
  Future<void> getCourseConciergerieListEnAttenteByCoursier() async {
    courseConciergerieEnAttenteLoading.value = true;
    try {
      final response = await conciergerieService
          .getCourseConciergerieListEnAttenteByCoursier();
      if (response.statusCode == 200) {
        courseConciergerieListEnAttenteByCoursier.value = response.body!;
        courseConciergerieEnAttenteLoading.value = false;
      } else {
        courseConciergerieEnAttenteLoading.value = false;
      }
    } catch (e) {
      courseConciergerieEnAttenteLoading.value = false;
    }
  }

  //en cours
  Future<void> getCourseConciergerieListEnCoursByCoursier() async {
    courseConciergerieEnCoursLoading.value = true;
    try {
      final response = await conciergerieService
          .getCourseConciergerieListEnCoursByCoursier();
      if (response.statusCode == 200) {
        courseConciergerieListEnCoursByCoursier.value = response.body!;
        courseConciergerieEnCoursLoading.value = false;
      } else {
        courseConciergerieEnCoursLoading.value = false;
      }
    } catch (e) {
      courseConciergerieEnCoursLoading.value = false;
    }
  }

  //terminer
  Future<void> getCourseConciergerieListTerminerByCoursier() async {
    courseConciergerieTerminerLoading.value = true;
    try {
      final response = await conciergerieService
          .getCourseConciergerieListTerminerByCoursier();
      if (response.statusCode == 200) {
        courseConciergerieListTerminerByCoursier.value = response.body!;
        courseConciergerieTerminerLoading.value = false;
      } else {
        courseConciergerieTerminerLoading.value = false;
      }
    } catch (e) {
      courseConciergerieTerminerLoading.value = false;
    }
  }

  //Update Tache
  Future<void> updateTacheEtatCourseConciergerie(
      dynamic dataTache, BuildContext context) async {
    updateTacheCourseConciergerieLoading.value = true;
    Get.back();

    quickAlertDialog(context, QuickAlertType.loading,
        color: const Color(0xff6CA0B6),
        message: 'Modification en cours',
        title: 'Modification');
    try {
      final response = await conciergerieService
          .updateTacheEtatCourseConciergerie(dataTache);
      if (response.statusCode == 200) {
        updateTacheCourseConciergerieLoading.value = false;
        getCourseConciergerieListEnAttenteByCoursier();
        getCourseConciergerieListEnCoursByCoursier();
        getCourseConciergerieListTerminerByCoursier();
        Get.back();
        Get.back();

        quickAlertDialog(context, QuickAlertType.success,
            message: 'Modification effectuée avec succès',
            title: 'Succès',
            color: const Color(0xff6CA0B6),
            onConfirmBtnTap: () => {Get.back()});
        Future.delayed(const Duration(seconds: 3), () {
          Get.back();
          Get.back();
        });
      } else {
        updateTacheCourseConciergerieLoading.value = false;
      }
    } catch (e) {
      updateTacheCourseConciergerieLoading.value = false;
    }
  }

  //add description
  Future<void> addDescriptionTacheCourseConciergerie(
      dynamic dataTache, BuildContext context) async {
    updateTacheCourseConciergerieLoading.value = true;
    Get.back();
    quickAlertDialog(context, QuickAlertType.loading,
        color: const Color(0xff6CA0B6),
        message: 'Modification en cours',
        title: 'Modification');
    try {
      Get.back();
      final response = await conciergerieService
          .addDescriptionTacheCourseConciergerie(dataTache);
      getCourseConciergerieListEnCoursByCoursier();
      response;
      updateTacheCourseConciergerieLoading.value = false;
      quickAlertDialog(context, QuickAlertType.success,
          color: const Color(0xff6CA0B6),
          message: 'Description ajoutée avec succès',
          title: 'Modification');

      Get.back();
    } catch (e) {
      updateTacheCourseConciergerieLoading.value = false;
    }
  }

  //Accept Course
  Future<void> acceptCourseConciergerie(
      dynamic dataTache, BuildContext context) async {
    acceptCourseConciergerieLoading.value = true;
    Get.back();
    quickAlertDialog(context, QuickAlertType.loading,
        color: const Color(0xff6CA0B6),
        message: 'Modification en cours',
        title: 'Modification');

    try {
      final response =
          await conciergerieService.acceptCourseConciergerie(dataTache);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        acceptCourseConciergerieLoading.value = false;
        getCourseConciergerieListEnAttenteByCoursier();
        getCourseConciergerieListEnCoursByCoursier();
        getCourseConciergerieListTerminerByCoursier();

        quickAlertDialog(context, QuickAlertType.success,
            message:
                'Course acceptée, vous allez être redirigé vers la liste des taches',
            title: 'Modification effectuée',
            color: const Color(0xff6CA0B6),
            onConfirmBtnTap: () => {
                  Get.back(),
                  showBottomSheet(
                      context: context,
                      builder: (_) => ListeTachesCourseComponent(
                            tacheConcierges: response.body!.tacheConcierges!,
                            courseConciergeModel: response.body,
                          ),
                      backgroundColor: Colors.transparent),
                });
      } else {
        acceptCourseConciergerieLoading.value = false;
      }
    } catch (e) {
      acceptCourseConciergerieLoading.value = false;
    }
  }

  // Convert enum value to a readable string
  String statusToString(Status status) {
    switch (status) {
      case Status.en_cours:
        return 'En Cours';
      case Status.en_attente:
        return 'En Attente';
      case Status.terminer:
        return 'Terminer';
      default:
        return '';
    }
  }

  String statusToStringPut(Status status) {
    switch (status) {
      case Status.en_cours:
        return 'en_cours';
      case Status.en_attente:
        return 'en_attente';
      case Status.terminer:
        return 'terminer';
      default:
        return '';
    }
  }

  Status stringToStatus(String status) {
    switch (status) {
      case 'en_cours':
        return Status.en_cours;
      case 'en_attente':
        return Status.en_attente;
      case 'terminer':
        return Status.terminer;
      default:
        return Status.en_cours;
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
  Rx<UserBoutiqueModel?> get userConciergeValue => userConcierge;
}

enum Status { en_cours, en_attente, terminer }
