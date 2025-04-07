import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActualiteSingleScreenController extends GetxController {
  Rx<Color> colorPrimary = const Color(0xff343E35).obs;

  Rx<Color> colorSecondary = const Color(0xFF42342C).obs;

  //form variable
  Rx<TextEditingController> commentController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
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
