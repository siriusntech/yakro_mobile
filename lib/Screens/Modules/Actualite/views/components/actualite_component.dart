import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Screens/Modules/Actualite/path_actualite.dart';
import 'package:jaime_yakro/routes/path_route.dart';
import 'package:get/get.dart';

class ActualiteComponent extends GetView<ActualiteScreenController> {
  const ActualiteComponent({super.key});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
      height: height,
      width: width,
      decoration: const BoxDecoration(),
      child: ListView.separated(
          itemBuilder: (context, index) => CardActualiteElement(
                onTap: () {
                  Get.toNamed(AppRoutes.actualiteSingleScreen);
                  // showBottomSheet(
                  //     context: context, builder: (_) => AlerteSingleScreen());
                },
              ),
          separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
          itemCount: 10),
    );
  }
}
