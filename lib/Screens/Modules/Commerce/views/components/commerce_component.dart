import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Screens/Modules/Commerce/path_commerce.dart';
import 'package:jaime_yakro/routes/path_route.dart';
import 'package:get/get.dart';

class CommerceComponent extends StatefulWidget {
  const CommerceComponent({super.key});

  @override
  State<CommerceComponent> createState() => _CommerceComponentState();
}

class _CommerceComponentState extends State<CommerceComponent> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final CommerceScreenController controller = Get.find();
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      height: height,
      width: width,
      decoration: const BoxDecoration(),
      child: RefreshIndicator(
        color: controller.colorPrimary.value,
        onRefresh: () {
          controller.commerceControllerGetter.getAllCommerce();
          return Future.value();
        },
        child: Obx(
          () => controller.commerceControllerGetter.commerceLoading.value
              ? Center(
                  child: SpinKitDoubleBounce(
                  color: controller.colorPrimary.value,
                ))
              : controller.commerceControllerGetter.commerceList.isEmpty
                  ? Center(
                      child: Text("Aucun commerce disponible",
                          style: TextStyle(
                              color: controller.colorPrimary.value,
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 25)))
                  : ListView.separated(
                      itemBuilder: (context, index) => CardCommerceElement(
                            onTap: () {
                              controller.commerceSingleScreenController
                                  .setCommerceModel(controller
                                      .commerceControllerGetter
                                      .commerceList[index]);
                              Get.toNamed(AppRoutes.commerceSingleScreen);
                            },
                            index: index,
                            commerceModel: controller
                                .commerceControllerGetter.commerceList[index],
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                      itemCount: controller
                          .commerceControllerGetter.commerceList.length),
        ),
      ),
    );
  }
}
