import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class CoursierConciergerieService extends GetConnect {
  final MainController mainController = Get.find<MainController>();

  @override
  void onInit() {
    mainController.getAuthInfo();
    httpClient.baseUrl = AppConfig.urlApi;
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 10);
    showCoursierConcierge();
    super.onInit();
  }

  Future<Response<CoursierConciergeModel>> addCoursierConcierge(
      Map<String, dynamic> data) async {
    //  print('======POST ADD COURSIER CONCIERGE=======');
    //   print(mainController.getLoggedHeaders());
    return post(
      '/conciergerie/coursier/store',
      data,
      headers: mainController.getLoggedHeaders(),
      decoder: (data) {
        // print(data);
        return CoursierConciergeModel.fromJson(data['data']);
      },
    );
  }

  Future<Response<CoursierConciergeModel>> updateProfilCoursier(
      Map<String, dynamic> data, String id) async {
    // print('======POST UPDATE COURSIER CONCIERGE=======');
    return put(
      '/conciergerie/coursier/update/$id',
      data,
      headers: mainController.getLoggedHeaders(),
      decoder: (data) {
        // print(data);
        // return null!;
        return CoursierConciergeModel.fromJson(data['data']);
      },
    );
  }

  Future<Response<CoursierConciergeModel>> loginCoursierConcierge(
      Map<String, dynamic> data) async {
    // print('======POST LOGIN COURSIER CONCIERGE=======');
    return post(
      '/conciergerie/coursier/login',
      data,
      headers: mainController.getLoggedHeaders(),
      decoder: (data) {
        if (data['success'] == false) {
          Get.snackbar('Echec', data['message'],
              backgroundColor: ConstColors.alertWarnig,
              colorText: Colors.white,
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ));
          return null!;
        }
        return CoursierConciergeModel.fromJson(data['data']);
      },
    );
  }

  Future<Response<CoursierConciergeModel?>?> showCoursierConcierge() async {
    return post(
        '/conciergerie/coursier/showCoursierByUserId',
        {
          'device_id': mainController.deviceId.value,
          'device_model': mainController.deviceModel.value
        },
        headers: mainController.getLoggedHeaders(), decoder: (data) {
      print(data);
      return data['data'] == null ? null : CoursierConciergeModel.fromJson(data['data']);
    });
  }

  Future<Response<Map<String, dynamic>>> createCoursierConciergeDocument(data) async {
    int statusCode = 200;
    data.forEach((key, value) async {
      File file = File(value.path);
      String fileName = basename(file.path);
      final request = http.MultipartRequest(
          'POST',
          Uri.parse(
              '${AppConfig.urlApi}/conciergerie/coursier/document/store'));
      request.headers['Authorization'] =
          'Bearer ${mainController.authToken.value}';
      request.files.add(await http.MultipartFile.fromPath(
          'documents', file.path,
          filename: fileName));
      final response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        // print(const JsonDecoder().convert(value));
      });

      statusCode = response.statusCode;
    });

    return statusCode == 200
        ? Response(
            statusCode: statusCode,
            body: {'message': 'Document ajouté avec succès'})
        : Response(
            statusCode: statusCode,
            body: {'message': 'Erreur veuillez réessayer plus tard'});
  }

  Future<Response<Map<String, dynamic>>> createCoursierConciergeProfileImg(
      XFile img) async {
    int statusCode = 200;
    // data.forEach((key, value) async {
    File file = File(img.path);
    String fileName = basename(file.path);
    final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${AppConfig.urlApi}/conciergerie/coursier/profileImg/store'));
    request.headers['Authorization'] =
        'Bearer ${mainController.authToken.value}';
    request.files.add(await http.MultipartFile.fromPath(
        'profile_img', file.path,
        filename: fileName));
    final response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      const JsonDecoder().convert(value);
    });

    statusCode = response.statusCode;

    // });

    return statusCode == 200
        ? Response(
            statusCode: statusCode,
            body: {'message': 'Image ajouté avec succès'})
        : Response(
            statusCode: statusCode,
            body: {'message': 'Erreur veuillez réessayer plus tard'});
  }

  Future<Response<Map<String, dynamic>>> sendOtp(String telephone) async {
    return post('/conciergerie/coursier/sendOtp', {'telephone': telephone},
        headers: mainController.getLoggedHeaders(), decoder: (data) => data);
  }

  Future<Response<Map<String, dynamic>>> verifyOtp(
      String otp, String telephone) async {
    return post('/conciergerie/coursier/verifyOtp',
        {'otp': otp, 'telephone': telephone},
        headers: mainController.getLoggedHeaders(), decoder: (data) => data);
  }

  Future<Response<Map<String, dynamic>>> changePassword(
      String password, String telephone) async {
    return post('/conciergerie/coursier/changePassword',
        {'new_password': password, 'telephone': telephone},
        headers: mainController.getLoggedHeaders(), decoder: (data) => data);
  }

  @override
  void onReady() {
    super.onReady();
  }
}
