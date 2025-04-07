import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Screens/Modules/Alerte/path_alerte.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAlertScreen extends GetView<AlerteAddScreenController> {
  const AddAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajouter une alerte',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(AppConfig.paddingBody),
        height: height,
        width: width,
        decoration: const BoxDecoration(),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
              // height: height / 10,
              width: width,
              decoration: BoxDecoration(
                  // color: controller.colorPrimary.value.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(AppConfig.borderRadius)),
              child: Column(
                children: [
                  Text(
                    "Lieu de l'incident ?",
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: GoogleFonts.nunito().fontFamily,
                        color: controller.colorPrimary.value),
                  ),
                  TextFormField(
                    controller: controller.lieuController.value,
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: controller.colorPrimary.value)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: controller.colorPrimary.value),
                          borderRadius:
                              BorderRadius.circular(AppConfig.borderRadius)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppConfig.borderRadius,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
              // height: height / 10,
              width: width,
              decoration: BoxDecoration(
                  // color: controller.colorPrimary.value.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(AppConfig.borderRadius)),
              child: Column(
                children: [
                  Text(
                    "La Date",
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: GoogleFonts.nunito().fontFamily,
                        color: controller.colorPrimary.value),
                  ),
                  TextFormField(
                    controller: controller.dateController.value,
                    cursorColor: Colors.black,
                    readOnly: true,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: controller.colorPrimary.value)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppConfig.borderRadius),
                        borderSide:
                            BorderSide(color: controller.colorPrimary.value),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () => controller.selectDate(context),
                          icon: Icon(Icons.date_range,
                              color: controller.colorPrimary.value)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
              // height: height / 10,
              width: width,
              decoration: BoxDecoration(
                  // color: controller.colorPrimary.value.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(AppConfig.borderRadius)),
              child: Column(
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: GoogleFonts.nunito().fontFamily,
                        color: controller.colorPrimary.value),
                  ),
                  TextFormField(
                    controller: controller.descriptionController.value,
                    minLines: 5,
                    maxLines: 50,
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        focusColor: Colors.black,
                        fillColor: Colors.black,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: controller.colorPrimary.value)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: controller.colorPrimary.value),
                            borderRadius:
                                BorderRadius.circular(AppConfig.borderRadius))),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
              // height: height / 10,
              width: width,
              decoration: BoxDecoration(
                  // color: controller.colorPrimary.value.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(AppConfig.borderRadius)),
              child: Column(children: [
                Text(
                  "Image",
                  style: TextStyle(
                      fontSize: 19,
                      fontFamily: GoogleFonts.nunito().fontFamily,
                      color: controller.colorPrimary.value),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: height / 17,
                  width: width,
                  decoration: BoxDecoration(
                    color: controller.colorPrimary.value.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(AppConfig.borderRadius),
                  ),
                  child: OutlinedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                      side: BorderSide(
                          color: controller.colorSecondary.value,
                          style: BorderStyle.solid),
                      borderRadius:
                          BorderRadius.circular(AppConfig.borderRadius),
                    ))),
                    onPressed: () => controller.selectImage(context),
                    child: Text("Ajouter une image",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontFamily: GoogleFonts.nunito().fontFamily)),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: height / 15,
              width: width,
              decoration: const BoxDecoration(),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        controller.colorSecondary.value),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConfig.borderRadius),
                    ))),
                onPressed: () {},
                child: Text("Valider",
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontFamily: GoogleFonts.nunito().fontFamily)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
