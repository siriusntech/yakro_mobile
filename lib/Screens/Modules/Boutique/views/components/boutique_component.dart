import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';
import 'package:get/get.dart';

class BoutiqueComponent extends GetView<BoutiqueScreenController> {
  const BoutiqueComponent({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
        child: RefreshIndicator(
          color: controller.colorPrimary.value,
          onRefresh: () {
            controller.controllerBoutique.categorieBoutiqueControllerGetter
                .getAllCategorieBoutique();
            controller.controllerBoutique.produitBoutiqueControllerGetter
                .getAllProduitBoutique();
            controller.controllerBoutique.produitBoutiqueControllerGetter
                .getAllProduitBoutiqueByPub();
            return Future.value();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: height / 5,
                  width: width,
                  decoration: BoxDecoration(
                    // image: const DecorationImage(
                    //     image:
                    //         AssetImage("assets/images/affiche-ecommerce.jpeg"),
                    //     fit: BoxFit.cover),
                    borderRadius:
                        BorderRadius.circular(AppConfig.bottonsheetRadius),
                  ),
                  child: PubProduit(
                    produitBoutiqueList: controller
                        .controllerBoutiqueGetter
                        .produitBoutiqueControllerGetter
                        .produitBoutiqueListPubGetter,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CategorieListComponent(),
                const SizedBox(
                  height: 20,
                ),
                const ProduitListComponent()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
