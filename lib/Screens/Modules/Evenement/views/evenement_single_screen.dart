import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Screens/Modules/Evenement/path_evenement.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EvenementSingleScreen extends GetView<EvenementScreenController> {
  const EvenementSingleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Container(
              height: height / 3,
              width: width,
              decoration: const BoxDecoration(),
              child: const PageViewEvenementSingle(),
            ),
            const DetailEvenementSingleComponent()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppConfig.paddingBody),
        height: 80,
        width: width,
        decoration: BoxDecoration(
            color: Get.arguments['color'],
            borderRadius: BorderRadius.circular(AppConfig.bottomRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Text(
                'A partir de 15 000 Frs CFA',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: GoogleFonts.nunito().fontFamily,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Contactez',
                style: TextStyle(color: Get.arguments['color'], fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}
