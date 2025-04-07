import 'package:flutter/material.dart';
import 'package:jaime_yakro/Screens/Modules/Pharmacie/path_pharmacie.dart';
import 'package:jaime_yakro/Screens/Widgets/dialog.dart';
import 'package:jaime_yakro/routes/path_route.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PharmacieScreen extends GetView<PharmacieScreenController> {
  const PharmacieScreen({super.key});

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
                  delegate: PharmacieSearchComponent(),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.pharmacieApiControllerGetter.onInit();
          showDialog(
              context: context,
              builder: (_) => FiltrePharmacie(
                    zoneList: controller.pharmacieApiControllerGetter.zoneList,
                  ));
        },
        backgroundColor: controller.colorSecondary.value,
        child: const Icon(
          Icons.filter_alt_outlined,
          color: Colors.white,
        ),
      ),
      body: const PharmacieComponent(),
    );
  }
}
