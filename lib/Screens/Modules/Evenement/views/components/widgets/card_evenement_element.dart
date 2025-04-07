import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Evenement/path_evenement.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';

class CardEvenementElement extends GetView<EvenementScreenController> {
  const CardEvenementElement(
      {super.key, required this.onTap, this.bonPlanModel});
  final Callback onTap;
  final BonPlanModel? bonPlanModel;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: height / 2.5,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConfig.cardRadius),
            color: controller.colorPrimary.value.withOpacity(0.17)),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height / 3.5,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppConfig.cardRadius),
                      color: controller.colorPrimary.value,
                      image: DecorationImage(
                          image: NetworkImage(
                            "${bonPlanModel!.medias![0].url}",
                          ),
                          fit: BoxFit.cover)),
                ),
                // Positioned(
                //   right: 0,
                //   child: Container(
                //     height: 60,
                //     width: 60,
                //     decoration: BoxDecoration(
                //         color: controller.colorPrimary.value.withOpacity(0.7),
                //         borderRadius:
                //             BorderRadius.circular(AppConfig.cardRadius)),
                //     child: IconButton(
                //         onPressed: () {}, icon: const Icon(Icons.favorite)),
                //   ),
                // )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          '${bonPlanModel!.objet}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      // SizedBox(
                      //   height: 40,
                      //   // width: 60,
                      //   // color: Colors.amber,
                      //   child: Row(
                      //     children: [
                      //       const Icon(Icons.star),
                      //       Text('4.9  ',
                      //           style: TextStyle(
                      //               fontFamily: GoogleFonts.nunito().fontFamily,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 18)),
                      //       Text('(499)',
                      //           style: TextStyle(
                      //               fontFamily: GoogleFonts.nunito().fontFamily,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 17))
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                  // Text(
                  //   'contact: +225 ${bonPlanModel!.objet}',
                  //   style: TextStyle(
                  //     fontFamily: GoogleFonts.nunito().fontFamily,
                  //     fontSize: 15,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 2,
                  // ),
                  // Text(
                  //   'A partir de 1000 FCFA',
                  //   style: TextStyle(
                  //     fontFamily: GoogleFonts.anuphan().fontFamily,
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 15,
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
