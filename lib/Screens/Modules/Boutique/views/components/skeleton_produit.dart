import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonProduit extends StatelessWidget {
  const SkeletonProduit({super.key});

  @override
  Widget build(BuildContext context) {
    final BoutiqueScreenController controller = Get.find();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 0.7,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ...controller.tableProduct.map((produit) => Shimmer.fromColors(
            baseColor: controller.colorPrimary.value.withOpacity(0.7),
            highlightColor: Colors.amber,
            direction: ShimmerDirection.ltr,
            period: const Duration(seconds: 2),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConfig.cardRadius),
              ),
              child: Stack(
                children: [
                  Container(
                    height: height / 4.2,
                    width: width / 2,
                    decoration: BoxDecoration(
                        color: controller.colorPrimary.value.withOpacity(0.4),
                        borderRadius:
                            BorderRadius.circular(AppConfig.cardRadius)),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: controller.colorPrimary.value.withOpacity(0.7),
                          borderRadius:
                              BorderRadius.circular(AppConfig.cardRadius)),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 60,
                      width: width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppConfig.cardRadius),
                          color:
                              controller.colorPrimary.value.withOpacity(0.3)),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Produit',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily),
                                ),
                                const Text('20000 FCFA',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                    )),
                              ],
                            ),
                          ),
                          const Text(
                            'Edward Elrick',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )))
      ],
    );
  }
}
