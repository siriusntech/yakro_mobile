import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CardCategorieElement extends GetView<BoutiqueScreenController> {
  const CardCategorieElement(
      {this.onTap, super.key, this.categorieBoutiqueModel});
  final CategorieBoutiqueModel? categorieBoutiqueModel;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConfig.borderRadius),
        ),
        child: Container(
          height: height / 3,
          width: 120,
          decoration: BoxDecoration(
            color: controller.colorPrimary.value,
            borderRadius: BorderRadius.circular(AppConfig.borderRadius),
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
                      borderRadius:
                          BorderRadius.circular(AppConfig.borderRadius),
                      color: controller.colorPrimary.value,
                      // image: DecorationImage(
                      //     image: NetworkImage(
                      //       categorieBoutiqueModel!.imageUrl!,
                      //     ),
                      //     fit: BoxFit.cover)
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppConfig.borderRadius),
                      child: CachedNetworkImage(
                        imageUrl:
                            '${AppConfig.baseUrl}${categorieBoutiqueModel!.imageUrl!}',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              // colorFilter: ColorFilter.mode(
                              //     controller.colorPrimary.value,
                              //     BlendMode.overlay)
                            ), //colorBurn
                          ),
                        ),
                        placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  '${categorieBoutiqueModel!.libelle}',
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
    );
  }
}
