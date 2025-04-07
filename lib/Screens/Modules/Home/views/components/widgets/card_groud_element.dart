import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/views/boutique_screen.dart';
import 'package:jaime_yakro/routes/path_route.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

import '../../../../../Widgets/path_widget.dart';
import '../../../path_home.dart';

class CardGroudElement extends StatefulWidget {
  const CardGroudElement({super.key});

  @override
  State<CardGroudElement> createState() => _CardGroudElementState();
}

class _CardGroudElementState extends State<CardGroudElement> {
  final MainController mainController = Get.find();
  final AuthController authController = Get.find();
  final SliderApiController sliderApiController =
  Get.put(SliderApiController());
  final boutique = Get.put(BoutiqueScreenController());
  final ModuleController moduleController = Get.find();
  @override
  void initState() {

    mainController.onInit();
    moduleController.getModules();
    mainController.getModulesInfo();
    authController.refreshFcmToken();
    moduleController.onInit();
    boutique.controllerBoutiqueGetter.produitBoutiqueControllerGetter
        .getAllProduitBoutiqueByPub();
    sliderApiController.getAllSlider();
    refreshModules();
    super.initState();
  }

  refreshModules() {
    moduleController.getModules();
    sliderApiController.getAllSlider();
    mainController.getModulesInfo();
    Future.delayed(const Duration(seconds: 5), () {
      moduleController.getModules();
      sliderApiController.getAllSlider();
      mainController.getModulesInfo();

    });
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return RefreshIndicator(
      color: Colors.amber,
      onRefresh: () {
        moduleController.getModules();
        sliderApiController.getAllSlider();
        mainController.getModulesInfo();
        return Future.value();
      },
      child: Container(
        padding:
        const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
        height: height,
        width: width,
        decoration: const BoxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SliderHomeComponent(),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: height / 6,
                width: width,
                //decoration: const BoxDecoration(color: Colors.amber),
                child: Row(
                  children: [

                    Obx(()=>CardElement(
                      color: const Color(0xff3D81B0).withOpacity(0.4),
                      height: height / 4,
                      width: width,
                      textColor: Colors.white,
                      imgPath: "assets/icon/hotel.jpg",
                      fit: BoxFit.cover,
                      title: "Hotel",
                      onTap: mainController.hotelEnable.value == true
                          ? () {
                        Get.toNamed(AppRoutes.hotelScreen);
                      }
                          : () {
                        quickAlertDialog(context, QuickAlertType.info,
                            title: "Hotel",
                            color: const Color(0xff3D81B0),
                            message: "Bientôt disponible",
                            onConfirmBtnTap: () =>
                                Navigator.pop(context));
                      },
                    )),
                    const SizedBox(
                      width: 10,
                    ),
      Obx(()=>CardElement(
                      color: const Color(0xff2E2E0F).withOpacity(0.4),
                      height: height / 4,
                      width: width,
                      textColor: Colors.white,
                      imgPath: "assets/icon/tourisme_yakro.jpg",
                      fit: BoxFit.cover,
                      title: "Tourisme",
                      onTap: mainController.tourismeEnable.value == true
                          ? () {
                        Get.toNamed(AppRoutes.siteTouristiqueScreen);
                      }
                          : () {
                        quickAlertDialog(context, QuickAlertType.info,
                            title: "Tourisme",
                            color: const Color(0xff2E2E0F),
                            message: "Bientôt disponible",
                            onConfirmBtnTap: () =>
                                Navigator.pop(context));
                      },
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: height / 5,
                width: width,
                //decoration: const BoxDecoration(color: Colors.amber),
                child: Column(
                  children: [
                    // Obx(()=>
                        CardElement(
                      color: const Color(0xff343E35).withOpacity(0.4),
                      height: height / 5,
                      width: width,
                      textColor: Colors.white,
                      imgPath: 'assets/images/coursier.jpg',
                      fit: BoxFit.fill,
                      title: "Conciergerie",
                      onTap:
                      // mainController.conciergeEnable.value == true
                      //     ?
                          () {
                        Get.toNamed(AppRoutes.courseConciergerieScreen);
                      }
                      //     : () {
                      //   quickAlertDialog(context, QuickAlertType.info,
                      //       title: "Conciergerie",
                      //       color: const Color(0xff434242),
                      //       message: "Bientôt disponible",
                      //       onConfirmBtnTap: () =>
                      //           Navigator.pop(context));
                      // },
                    // )
        ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 6,
                width: width,
                //decoration: const BoxDecoration(color: Colors.amber),
                child: Row(
                  children: [
                    Obx(()=>CardElement(
                      color: const Color(0xffEEB446).withOpacity(0.4),
                      height: height / 4,
                      width: width,
                      textColor: Colors.white,
                      imgPath: "assets/icon/restaurant.jpg",
                      fit: BoxFit.cover,
                      title: "Restaurant/Bar",
                      onTap: mainController.restaurantEnable.value == true
                          ? () {
                        Get.toNamed(AppRoutes.commerceScreen);
                      }
                          : () {
                        quickAlertDialog(context, QuickAlertType.info,
                            title: "Restaurant/Bar",
                            color: const Color(0xffEEB446),
                            message: "Bientôt disponible",
                            onConfirmBtnTap: () =>
                                Navigator.pop(context));
                      },
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                  Obx(()=> CardElement(
                      color: const Color(0xFF673C0A).withOpacity(0.4),
                      height: height / 4,
                      width: width,
                      textColor: Colors.white,
                      imgPath: "assets/icon/event.jpg",
                      fit: BoxFit.cover,
                      title: "Bons Plans",
                      onTap: mainController.bonPlanEnable.value == true
                          ? () {
                        Get.toNamed(AppRoutes.evenementScreen);
                      }
                          : () {
                        quickAlertDialog(context, QuickAlertType.info,
                            title: "Bons Plans",
                            color: const Color(0xFF673C0A),
                            message: "Bientôt disponible",
                            onConfirmBtnTap: () =>
                                Navigator.pop(context));
                      },
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: height / 6,
                width: width,
                //decoration: const BoxDecoration(color: Colors.amber),
                child: Row(
                  children: [
                    Obx(()=>CardElement(
                      color: const Color(0xff2F536E).withOpacity(0.4),
                      height: height / 4,
                      width: width,
                      textColor: Colors.white,
                      imgPath: "assets/icon/pharmacie.jpg",
                      fit: BoxFit.cover,
                      title: "Pharmacie de Garde",
                      onTap: mainController.pharmacieEnable.value == true
                          ? () {
                        Get.toNamed(AppRoutes.pharmacieScreen);
                      }
                          : () {
                        quickAlertDialog(
                          context,
                          QuickAlertType.info,
                          title: "Pharmacie de Garde",
                          color: const Color(0xff2F536E),
                          message: "Bientôt disponible",
                          onConfirmBtnTap: () => Navigator.pop(context),
                        );
                      },
                    )),
                    const SizedBox(
                      width: 10,
                    ),
      Obx(()=>CardElement(
                      color: const Color(0xff931F22).withOpacity(0.4),
                      height: height / 4,
                      width: width,
                      textColor: Colors.white,
                      imgPath: "assets/icon/shopping.jpg",
                      fit: BoxFit.cover,
                      title: "Boutique",
                      onTap: mainController.boutiqueEnable.value == true
                          ? () {
                        Get.put(BoutiqueScreenController());
                        showBottomSheet(
                            context: context,
                            builder: (_) => const BoutiqueScreen());
                      }
                          : () {
                        quickAlertDialog(context, QuickAlertType.info,
                            title: "Boutique",
                            color: const Color(0xff931F22),
                            message: "Bientôt disponible",
                            onConfirmBtnTap: () =>
                                Navigator.pop(context));
                      },
                    )),
                  ],
                ),
              ),

              // SizedBox(
              //   height: height / 5,
              //   width: width,
              //   //decoration: const BoxDecoration(color: Colors.amber),
              //   child: Row(
              //     children: [
              //       CardElement(
              //         color: const Color(0xff343E35).withOpacity(0.4),
              //         height: height / 4,
              //         width: width,
              //         textColor: Colors.white,
              //         imgPath: "assets/icon/actualite.jpg",
              //         fit: BoxFit.cover,
              //         title: "Actualités",
              //         onTap: () {
              //           Get.toNamed(AppRoutes.actualiteScreen, arguments: {
              //             "color": const Color(0xff343E35),
              //             "title": "Actualités"
              //           });
              //         },
              //       ),
              //       const SizedBox(
              //         width: 10,
              //       ),
              //       CardElement(
              //         color: const Color(0xff9A241A).withOpacity(0.4),
              //         height: height / 4,
              //         width: width,
              //         textColor: Colors.white,
              //         imgPath: "assets/icon/alert.jpg",
              //         fit: BoxFit.cover,
              //         title: "Alertes",
              //         onTap: () {
              //           Get.toNamed(AppRoutes.alerteScreen, arguments: {
              //             "color": const Color(0xff9A241A),
              //             "title": "Alertes"
              //           });
              //         },
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
