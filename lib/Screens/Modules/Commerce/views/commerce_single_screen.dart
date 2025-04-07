import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Screens/Modules/Commerce/path_commerce.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CommerceSingleScreen extends GetView<CommerceSingleScreenController> {
  const CommerceSingleScreen({super.key});

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
              child: PageViewRestaurantSingle(
                commerceModel: controller.commerceModel.value,
              ),
            ),
            const DetailCommerceSingleComponent()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppConfig.paddingBody),
        height: 80,
        width: width,
        decoration: BoxDecoration(
            color: controller.colorPrimary.value,
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
              onPressed: controller.commerceModel.value.contact == null
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Contact non disponible'),
                        ),
                      );
                    }
                  : () {
                      launchUrl(
                        Uri.parse(
                            "tel:${controller.commerceModel.value.contact}"),
                      );
                    },
              child: Text(
                'Contactez',
                style: TextStyle(
                    color: controller.colorPrimary.value, fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}
