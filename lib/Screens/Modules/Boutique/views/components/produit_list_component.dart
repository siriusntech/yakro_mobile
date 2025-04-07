import 'package:flutter/material.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';
import 'package:get/get.dart';

class ProduitListComponent extends GetView<BoutiqueScreenController> {
  const ProduitListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.controllerBoutique
            .produitBoutiqueControllerGetter.produitBoutiqueLoading.value
        ? const SkeletonProduit()
        : GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 0.7,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ...controller.controllerBoutique.produitBoutiqueControllerGetter
                  .produitBoutiqueListGetter
                  .map((produit) => CardProduitElement(
                        produitBoutiqueModel: produit,
                        onTap: () {
                          controller.setFloatingDisable(true);
                          // controller.floatingDisable.value = true;
                          showBottomSheet(
                              context: context,
                              builder: (_) => BoutiqueSingleScreen(
                                    produitBoutiqueModel: produit,
                                  ));
                        },
                      ))
            ],
          ));
  }
}
