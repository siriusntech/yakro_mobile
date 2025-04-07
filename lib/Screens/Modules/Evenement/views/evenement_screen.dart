import 'package:flutter/material.dart';
import 'package:jaime_yakro/Screens/Modules/Evenement/path_evenement.dart';
import 'package:jaime_yakro/routes/path_route.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EvenementScreen extends GetView<EvenementScreenController> {
  const EvenementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.homeScreen);
            },
            icon: const Icon(Icons.chevron_left)),
        backgroundColor: controller.colorPrimary.value,
        title: Text('${controller.title.value} Yakro',
            style: TextStyle(
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.taprom().fontFamily)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await showSearch(
                  context: context,
                  delegate: EvenementSearchComponent(
                    evenementList:
                        controller.bonPlanApiControllerGetter.bonPlanList,
                  ),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: const EvenementComponent(),
    );
  }
}
