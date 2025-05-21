import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/controllers/path_controller.dart';
import 'package:jaime_yakro/Providers/models/path_mdels.dart';

class CourseConciergerieService extends GetConnect {
  final MainController mainController = Get.put(MainController());

  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    getCourseConciergerieListEnAttenteByCoursier();

    super.onInit();
  }

  Future<Response<CourseConciergeModel>> createCourseConciergerie(
      dynamic dataTache, String codeCourse) async {
    // print('======POST CREATE COURSE CONCIERGE=======');
    return post('/conciergerie/course/store', dataTache,
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // Get.snackbar('Enregistrement', data['message'],
      //     backgroundColor: ConstColors.alertSuccess, colorText: Colors.white);
      //  print(data);
      return CourseConciergeModel.fromJson(data['data']);
    });
  }

  Future<Response<List<CourseConciergeModel>>>
      getCourseConciergerieListByUser() async {
    // print('======GET COURSE CONCIERGE=======');
    return get('/conciergerie/course',
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data['data']);
      return List<CourseConciergeModel>.from(
          data['data'].map((x) => CourseConciergeModel.fromJson(x)));
    });
  }

  Future<Response<List<CourseConciergeModel>>>
      getCourseConciergerieListByCoursier() async {
    // print('======GET COURSE CONCIERGE=======');
    return get('/conciergerie/course/coursier',
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data['data']);
      return List<CourseConciergeModel>.from(
          data['data'].map((x) => CourseConciergeModel.fromJson(x)));
    });
  }

  //en attente
  Future<Response<List<CourseConciergeModel>>>
      getCourseConciergerieListEnAttenteByCoursier() async {
    // print('======GET COURSE CONCIERGE EN ATTENTE=======');
    return get('/conciergerie/course-en-attente/coursier',
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data['data']);
      return List<CourseConciergeModel>.from(
          data['data'].map((x) => CourseConciergeModel.fromJson(x)));
    });
  }

  //en cours
  Future<Response<List<CourseConciergeModel>>>
      getCourseConciergerieListEnCoursByCoursier() async {
    // print('======GET COURSE CONCIERGE EN COURS=======');
    return get('/conciergerie/course-encours/coursier',
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data['data']);
      return List<CourseConciergeModel>.from(
          data['data'].map((x) => CourseConciergeModel.fromJson(x)));
    });
  }

  //Terminer
  Future<Response<List<CourseConciergeModel>>>
      getCourseConciergerieListTerminerByCoursier() async {
    // print('======GET COURSE CONCIERGE TERMINER=======');
    return get('/conciergerie/course-terminer/coursier',
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data['data']);
      return List<CourseConciergeModel>.from(
          data['data'].map((x) => CourseConciergeModel.fromJson(x)));
    });
  }

  //update Tache
  Future<Response<TacheConciergeModel>> updateTacheEtatCourseConciergerie(
      dynamic dataTache) async {
    // print('======PUT UPDATE COURSE CONCIERGE=======');
    return put('/conciergerie/course/update-tache', dataTache,
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data);
      if (data['success'] == false) {
        Get.back();
        Get.snackbar('Tache non modifiée', data['data'],
            backgroundColor: ConstColors.alertWarnig,
            colorText: Colors.white,
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ));
        return null!;
      }
      Get.back();
      Get.snackbar('Modification', data['message'],
          backgroundColor: ConstColors.alertSuccess, colorText: Colors.white);
      return TacheConciergeModel.fromJson(data['data']);
    });
  }

  //add Description
  Future<Response<TacheConciergeModel>> addDescriptionTacheCourseConciergerie(
      dynamic dataTache) async {
    // print('======PUT UPDATE TACHE DESCRIPTION COURSE CONCIERGE=======');
    return put('/conciergerie/course/add-description-tache', dataTache,
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data);
      if (data['success'] == false) {
        Get.back();
        Get.snackbar('Tache non modifiée', data['data'],
            backgroundColor: ConstColors.alertWarnig,
            colorText: Colors.white,
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ));
        return null!;
      }
      Get.back();
      Get.snackbar('Modification', data['message'],
          backgroundColor: ConstColors.alertSuccess, colorText: Colors.white);
      return TacheConciergeModel.fromJson(data['data']);
    });
  }

  //Accept Course
  Future<Response<CourseConciergeModel>> acceptCourseConciergerie(
      int id) async {
    // print('======PUT ACCEPT COURSE CONCIERGE=======');
    return put('/conciergerie/course/accept', {'courseId': id},
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      // print(data);
      // print(CourseConciergeModel.fromJson(data['data']));
      Get.back();
      if (data['success'] == false) {
        // Get.back();
        Get.snackbar('Course non acceptée', data['data'],
            backgroundColor: ConstColors.alertWarnig,
            colorText: Colors.white,
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ));
        return null!;
      } else {
        Get.snackbar('Course acceptée', data['message'],
            backgroundColor: ConstColors.alertSuccess, colorText: Colors.white);
        return CourseConciergeModel.fromJson(data['data']);
      }
    });
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
