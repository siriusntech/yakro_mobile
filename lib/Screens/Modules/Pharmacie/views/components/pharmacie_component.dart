import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Pharmacie/path_pharmacie.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Screens/Modules/Pharmacie/views/pharmacie_single_screen.dart';

class PharmacieComponent extends StatefulWidget {
  const PharmacieComponent({super.key});

  @override
  State<PharmacieComponent> createState() => _PharmacieComponentState();
}

class _PharmacieComponentState extends State<PharmacieComponent> {
  // final PharmacieScreenController controller =
  //     Get.put(PharmacieScreenController());
  // @override
  // void initState() {
  //   controller.onInit();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final PharmacieScreenController controller =
        Get.put(PharmacieScreenController());
    final PharmacieApiController controllerApiPharmacie =
        Get.put(PharmacieApiController());
    return Container(
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
        height: height,
        width: width,
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            controller.pharmacieApiControllerGetter.pharmacieList.isEmpty
                ? const SizedBox()
                : Container(
                    height: height / 12,
                    width: width,
                    decoration: const BoxDecoration(
                        // color: Colors.amber
                        ),
                    alignment: Alignment.center,
                    child: Text(
                      '${controller.pharmacieApiControllerGetter.pharmacieList[0].periode}',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: GoogleFonts.agdasima().fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: RefreshIndicator(
                  color: controller.colorPrimary.value,
                  onRefresh: () {
                    controllerApiPharmacie.getPharmacieList();
                    return Future.value();
                  },
                  child: Obx(
                    () => controller
                            .pharmacieApiControllerGetter.pharmacieLoading.value
                        ? Center(
                            child: SpinKitDoubleBounce(
                              color: controller.colorPrimary.value,
                            ),
                          )
                        : controller.pharmacieApiControllerGetter.pharmacieList
                                .isEmpty
                            ? Center(
                                child: Text("Aucune pharmacie disponible",
                                    style: TextStyle(
                                        color: controller.colorPrimary.value,
                                        fontFamily:
                                            GoogleFonts.nunito().fontFamily,
                                        fontSize: 25)))
                            : ListView.separated(
                                itemBuilder: (context, index) =>
                                    CardPharmacieElement(
                                  pharmacieModel: controller
                                      .pharmacieApiControllerGetter
                                      .pharmacieList[index],
                                  onTap: () {
                                    controller
                                        .pharmacieSingleScreenControllerGetter
                                        .setPharmcieModel(controller
                                            .pharmacieApiControllerGetter
                                            .pharmacieList[index]);
                                    showBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            const PharmacieSingleScreen());
                                  },
                                ),
                                itemCount: controller
                                    .pharmacieApiControllerGetter
                                    .pharmacieList
                                    .length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 20,
                                ),
                              ),
                  )),
            ),
          ],
        ));
  }
}




// Obx(
//               () => controller
//                       .pharmacieApiControllerGetter.pharmacieLoading.value
//                   ? Center(
//                       child: SpinKitDoubleBounce(
//                       color: controller.colorPrimary.value,
//                     ))
//                   : controller
//                           .pharmacieApiControllerGetter.pharmacieList.isEmpty
//                       ? Center(
//                           child: Text("Aucune pharmacie disponible",
//                               style: TextStyle(
//                                   color: controller.colorPrimary.value,
//                                   fontFamily: GoogleFonts.nunito().fontFamily,
//                                   fontSize: 25)))
//                       : ListView.separated(
//                           itemBuilder: (context, index) => CardPharmacieElement(
//                             pharmacieModel: controller
//                                 .pharmacieApiControllerGetter
//                                 .pharmacieList[index],
//                             onTap: () {
//                               controller.pharmacieSingleScreenControllerGetter
//                                   .setPharmcieModel(controller
//                                       .pharmacieApiControllerGetter
//                                       .pharmacieList[index]);
//                             },
//                           ),
//                           itemCount: controller.pharmacieApiControllerGetter
//                               .pharmacieList.length,
//                           separatorBuilder: (context, index) => const SizedBox(
//                             height: 20,
//                           ),
//                         ),
//             )