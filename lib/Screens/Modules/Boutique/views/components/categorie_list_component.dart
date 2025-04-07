import 'package:flutter/material.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';
import 'package:get/get.dart';

class CategorieListComponent extends GetView<BoutiqueScreenController> {
  const CategorieListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final BoutiqueScreenController controller = Get.find();
    return Obx(() => controller.controllerBoutiqueGetter
            .categorieBoutiqueControllerGetter.categorieBoutiqueLoading.value
        ? const SkeletonCategorie()
        : Container(
            padding: const EdgeInsets.all(5),
            height: height / 4.8,
            width: width,
            decoration: const BoxDecoration(),
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => CardCategorieElement(
                      onTap: () {
                        controller.controllerBoutiqueGetter
                            .produitBoutiqueControllerGetter
                            .getAllProduitByCategorieBoutiqueId(controller
                                .controllerBoutiqueGetter
                                .categorieBoutiqueControllerGetter
                                .categorieBoutiqueListGetter[index]
                                .id!);
                      },
                      categorieBoutiqueModel: controller
                          .controllerBoutiqueGetter
                          .categorieBoutiqueControllerGetter
                          .categorieBoutiqueListGetter[index],
                    ),
                separatorBuilder: (_, index) => const SizedBox(
                      height: 5,
                    ),
                itemCount: controller
                    .controllerBoutiqueGetter
                    .categorieBoutiqueControllerGetter
                    .categorieBoutiqueListGetter
                    .length),
          ));
  }
}
