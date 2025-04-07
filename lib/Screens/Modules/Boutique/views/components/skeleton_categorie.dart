import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonCategorie extends StatelessWidget {
  const SkeletonCategorie({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final BoutiqueScreenController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(5),
      height: height / 4.8,
      width: width,
      decoration: const BoxDecoration(),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Shimmer.fromColors(
                baseColor: controller.colorPrimary.value.withOpacity(0.7),
                highlightColor: Colors.amber,
                direction: ShimmerDirection.ltr,
                period: const Duration(seconds: 2),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConfig.borderRadius),
                  ),
                  child: Container(
                    height: height / 3,
                    width: 120,
                    decoration: BoxDecoration(
                      color: controller.colorPrimary.value,
                      borderRadius:
                          BorderRadius.circular(AppConfig.borderRadius),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: height / 7.7,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppConfig.borderRadius),
                                color: Colors.green.shade200,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: GoogleFonts.nunito().fontFamily),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          separatorBuilder: (_, index) => const SizedBox(
                height: 5,
              ),
          itemCount: 4),
    );
  }
}
