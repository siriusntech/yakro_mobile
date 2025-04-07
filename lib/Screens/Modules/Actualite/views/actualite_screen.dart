import 'package:flutter/material.dart';
import 'package:jaime_yakro/Screens/Modules/Actualite/path_actualite.dart';
import 'package:jaime_yakro/routes/path_route.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ActualiteScreen extends GetView<ActualiteScreenController> {
  const ActualiteScreen({super.key});

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
        title: Text('${Get.arguments['title']} Yakro',
            style: TextStyle(
                fontSize: 23,
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
      body: const ActualiteComponent(),
    );
  }
}
