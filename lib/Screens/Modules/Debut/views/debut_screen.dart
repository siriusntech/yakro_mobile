import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Widgets/path_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';

import '../path_debut.dart';

class DebutScreen extends GetView<DebutScreeenController> {
  DebutScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    // PageController pageController = PageController();.
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(AppConfig.paddingBody),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            height: 120,
            width: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ConstColors.vertColorFonce,
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(image: AssetImage(AppConfig.logo))),
          ),
          Container(
              height: 360,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  // color: ConstColors.mainColor,
                  borderRadius: BorderRadius.circular(20)),
              child: const PageViewDebut()),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                // color: ConstColors.vertColorFonce.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConfig.borderRadius)),
            child: Text(
              "Lire la politique de confidentialité et les condiftions d'utilisations",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: GoogleFonts.anuphan().fontFamily,
                  color: ConstColors.vertColorFonce),
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                // color: ConstColors.vertColorFonce.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConfig.borderRadius)),
            child: Row(
              children: [
                Obx(
                  () => Checkbox(
                    checkColor: Colors.white,
                    fillColor: controller.isAcceptCondition.value
                        ? WidgetStateProperty.all(ConstColors.vertColorFonce)
                        : null,
                    onChanged: (value) {
                      controller.acceptCondition(value!);
                    },
                    value: controller.isAcceptCondition.value,
                  ),
                ),
                Expanded(
                  child: Text(
                    "J'accepte la politique de confidentialité et les conditions",
                    style: TextStyle(
                        fontFamily: GoogleFonts.abrilFatface().fontFamily,
                        color: ConstColors.vertColorFonce),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (controller.isAcceptCondition.value == false) {
                quickAlertDialog(
                  context,
                  QuickAlertType.info,
                  color: ConstColors.vertColorFonce,
                  message: 'Veuillez accepté la politique de confidentialité',
                  title: "Info",
                  onConfirmBtnTap: () => Navigator.pop(context),
                );
              } else {
                if (controller.isAcceptCondition.value == true) {
                  authController.loginWithDeviceId(context);
                }
              }
            },
            child: Container(
                height: 60,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ConstColors.vertColorFonce,
                ),
                child: Text(
                  'Commencez',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.nunito().fontFamily,
                      fontSize: 20),
                )),
          )
        ]),
      ),
    );
  }
}
