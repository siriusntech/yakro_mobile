import 'package:flutter/material.dart';
import 'package:jaime_yakro/Screens/Modules/Alerte/path_alerte.dart';
import 'package:jaime_yakro/routes/path_route.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AlerteScreen extends GetView<AlerteScreenController> {
  const AlerteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AlerteAddScreenController alerteAddScreenController =
        Get.put(AlerteAddScreenController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.homeScreen);
            },
            icon: const Icon(Icons.chevron_left)),
        backgroundColor: controller.colorPrimary.value,
        title: Text('${Get.arguments['title']} Yakro',
            style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.taprom().fontFamily)),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //       onPressed: () async {
        //         await showSearch(
        //           context: context,
        //           delegate: EvenementSearchComponent(),
        //         );
        //       },
        //       icon: const Icon(Icons.search))
        // ],
      ),
      floatingActionButton:
          Obx(() => alerteAddScreenController.isShowBottomSheet.value
              ? Builder(builder: (context) {
                  return FloatingActionButton(
                    backgroundColor: controller.colorSecondary.value,
                    onPressed: () {
                      alerteAddScreenController.isShowBottomSheet.value = false;
                      Get.back();
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  );
                })
              : Builder(builder: (context) {
                  return FloatingActionButton(
                    backgroundColor: controller.colorPrimary.value,
                    onPressed: () {
                      alerteAddScreenController.isShowBottomSheet.value = true;
                      showBottomSheet(
                          context: context,
                          builder: (_) => const AddAlertScreen());
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  );
                })),
      body: const AlerteComponent(),
    );
  }
}
