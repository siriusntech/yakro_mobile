import 'package:flutter/material.dart';
// import 'package:jaime_yakro/Screens/Modules/Hotel/path_hotel.dart';
import 'package:jaime_yakro/Screens/Modules/SiteTourisme/path_tourisme.dart';
// import 'package:jaime_yakro/Screens/Widgets/dialog.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:jaime_yakro/Screens/Widgets/dialog.dart';

class SiteTourismeScreen extends GetView<SiteTourismeScreenController> {
  const SiteTourismeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  delegate: SiteTourismeSearchComponent(),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     controller.categorieVtApiControllerGetter.onInit();
      //     showDialog(
      //         context: context,
      //         builder: (_) => FiltreSiteTouristique(
      //               categorieVTList: controller
      //                   .categorieVtApiControllerGetter.categorieVTList.value,
      //             ));
      //   },
      //   backgroundColor: controller.colorSecondary.value,
      //   child: const Icon(
      //     Icons.filter_alt_outlined,
      //     color: Colors.white,
      //   ),
      // ),
      body: const SiteTourismeComponent(),
    );
  }
}
