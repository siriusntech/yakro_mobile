import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCoursierScreenController extends GetxController{
  final Rx<Color> navigationBarColor = Colors.white.obs;
  Rx<Color> colorPrimary = const Color(0xFF0256BB).obs;
  final RxString title = 'Coursier Dashboard'.obs;
  @override
  void onInit() {super.onInit();
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