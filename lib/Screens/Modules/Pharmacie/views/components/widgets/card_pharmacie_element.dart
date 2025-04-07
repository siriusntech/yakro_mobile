import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Pharmacie/path_pharmacie.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';

class CardPharmacieElement extends GetView<PharmacieScreenController> {
  const CardPharmacieElement(
      {super.key, this.onTap, this.index, this.pharmacieModel});
  final Callback? onTap;
  final int? index;
  final PharmacieModel? pharmacieModel;
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
                          image: NetworkImage(pharmacieModel!.photo!),
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
                //         onPressed: () {},
                //         icon: const Icon(Icons.favorite_border)),
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
                        width: width / 1.2,
                        child: Text(
                          '${pharmacieModel!.nom}',
                          overflow: TextOverflow.ellipsis,
                            maxLines: 1,
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
                  Text(
                    'contact: ${pharmacieModel!.contacts!.first.numero}',
                    style: TextStyle(
                      fontFamily: GoogleFonts.nunito().fontFamily,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
