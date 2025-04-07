import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlerteSingleScreenController extends GetxController {
  Rx<Color> colorPrimary = const Color(0xff9A241A).obs;
  Rx<Color> colorSecondary = Colors.orangeAccent.obs;

  //form variable
  Rx<TextEditingController> commentController = TextEditingController().obs;

  int getNumberOfLines() {
    return commentController.value.text.split('\n').length;
  }

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
