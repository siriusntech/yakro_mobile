// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlerteAddScreenController extends GetxController {
  // Variable Global
  Rx<Color> colorPrimary = const Color(0xff9A241A).obs;
  Rx<Color> colorSecondary = Colors.orangeAccent.obs;
  Rx<bool> isShowBottomSheet = false.obs;
  // Form Variable
  Rx<DateTime> date = DateTime.now().obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> lieuController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;

// Selected Date

  Future selectDate(BuildContext context) async => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget? widget) => Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(primary: Colors.orangeAccent),
            datePickerTheme: const DatePickerThemeData(
              backgroundColor: Colors.white,
              dividerColor: Colors.orangeAccent,
              headerBackgroundColor: Colors.orangeAccent,
              headerForegroundColor: Colors.white,
            ),
          ),
          child: widget!,
        ),
      ).then((DateTime? selected) {
        if (selected != null && selected != date.value) {
          date.value = selected;
          dateController.value.text =
              "${selected.day}/${selected.month}/${selected.year}";
          update();
        }
      });

// Selected Image
  Future selectImage(BuildContext context) async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles(
    //   allowMultiple: true,
    //   type: FileType.custom,
    //   allowedExtensions: ['jpg', 'pdf', 'doc'],
    // );
    // return result;
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
