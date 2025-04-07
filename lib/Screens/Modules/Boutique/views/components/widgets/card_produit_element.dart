import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';

class CardProduitElement extends GetView<BoutiqueScreenController> {
  const CardProduitElement(
      {this.produitBoutiqueModel, required this.onTap, super.key});
  final ProduitBoutiqueModel? produitBoutiqueModel;
  final Callback onTap;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        color: controller.colorPrimary.value,
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
                  image: DecorationImage(
                      image: NetworkImage('${AppConfig.baseUrl}${produitBoutiqueModel!.imageUrl}'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(AppConfig.cardRadius)),
            ),
            // Positioned(
            //   right: 0,
            //   child: Container(
            //     height: 50,
            //     width: 50,
            //     decoration: BoxDecoration(
            //         color: controller.colorPrimary.value.withOpacity(0.7),
            //         borderRadius: BorderRadius.circular(AppConfig.cardRadius)),
            //     child: IconButton(
            //         onPressed: () {}, icon: const Icon(Icons.favorite_border)),
            //   ),
            // ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 80,
                width: width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConfig.cardRadius),
                    color: controller.colorPrimary.value.withOpacity(0.3)),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${produitBoutiqueModel!.libelle}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: GoogleFonts.nunito().fontFamily),
                          ),
                          Text(NumberFormat.currency(locale: 'fr', symbol: 'F').format(double.parse(produitBoutiqueModel!.prix.toString())),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
