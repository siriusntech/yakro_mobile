import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Helpers/helpers.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';

import 'components/mes_commande_screen.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  Widget build(BuildContext context) {
    final BoutiqueScreenController boutiqueController =
        Get.put(BoutiqueScreenController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(),
            child: Column(children: [
              //App Bar
              Container(
                padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
                height: height / 12,
                width: width,
                decoration:
                    BoxDecoration(color: boutiqueController.colorPrimary.value),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Image.asset("assets/images/achats.png"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('Profil',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.taprom().fontFamily)),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black38),
                      child: IconButton(
                          onPressed: () {
                            boutiqueController
                                .setChangeScreen(TypeScreen.boutiqueScreen);
                          },
                          color: Colors.white,
                          icon: const Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
                  // height: height / 3,
                  width: width,
                  decoration: const BoxDecoration(),
                  child: Column(children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: boutiqueController.colorPrimary.value,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 51,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      width: width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade300, width: 2.0),
                        borderRadius:
                            BorderRadius.circular(AppConfig.borderRadius),
                      ),
                      child: Text(
                        '${boutiqueController.authController.authModel.value?.userModel?.nom} ${boutiqueController.authController.authModel.value?.userModel!.prenom}',
                        style: TextStyle(
                            fontFamily: GoogleFonts.nunito().fontFamily,
                            fontSize: 20),
                      ),
                    ),
                    boutiqueController.authController.authModel.value?.userModel?.email!=null?  const SizedBox(
                      height: 10,
                    ):const SizedBox(),
                    boutiqueController.authController.authModel.value?.userModel?.email!=null?Container(
                      height: 60,
                      width: width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade300, width: 2.0),
                        borderRadius:
                            BorderRadius.circular(AppConfig.borderRadius),
                      ),
                      child: Text(
                        '${boutiqueController.authController.authModel.value?.userModel?.email}',
                        style: TextStyle(
                            fontFamily: GoogleFonts.nunito().fontFamily,
                            fontSize: 20),
                      ),
                    ):const SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      width: width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade300, width: 2.0),
                        borderRadius:
                            BorderRadius.circular(AppConfig.borderRadius),
                      ),
                      child: Text(
                        '${boutiqueController.authController.authModel.value?.userModel?.contact}',
                        style: TextStyle(
                            fontFamily: GoogleFonts.nunito().fontFamily,
                            fontSize: 20),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   height: 60,
                    //   width: width,
                    //   alignment: Alignment.center,
                    //   decoration: BoxDecoration(
                    //     border:
                    //         Border.all(color: Colors.grey.shade300, width: 2.0),
                    //     borderRadius:
                    //         BorderRadius.circular(AppConfig.borderRadius),
                    //   ),
                    //   child: ListTile(
                    //     title: Text('Mes Adresses',
                    //         style: TextStyle(
                    //           fontFamily: GoogleFonts.nunito().fontFamily,
                    //           fontSize: 20,
                    //         )),
                    //     trailing: IconButton(
                    //         onPressed: () {},
                    //         icon: Icon(
                    //           Icons.location_city,
                    //           color: boutiqueController.colorPrimary.value,
                    //         )),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      width: width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade300, width: 2.0),
                        borderRadius:
                            BorderRadius.circular(AppConfig.borderRadius),
                      ),
                      child: ListTile(
                        title: Text('Mes Commandes',
                            style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 20,
                            )),
                        trailing: Stack(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MesCommandeScreen()));
                                },
                                icon: Icon(
                                  Icons.shopping_bag,
                                  color: boutiqueController.colorPrimary.value,
                                )),
                            Positioned(
                              child: Container(
                                  height: 20,
                                  width: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:
                                        boutiqueController.colorSecondary.value,
                                  ),
                                  child: Obx(
                                    () => boutiqueController.authController
                                                .authModel.value !=
                                            null
                                        ? boutiqueController
                                                .authController
                                                .authModel
                                                .value!
                                                .orderBoutiqueModelList!
                                                .isEmpty
                                            ? const Text('')
                                            : Text(
                                                '${boutiqueController.authController.authModel.value!.orderBoutiqueModelList!.length}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              )
                                        : const Text(''),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      width: width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade300, width: 2.0),
                        borderRadius:
                            BorderRadius.circular(AppConfig.borderRadius),
                      ),
                      child: ListTile(
                        title: Text('Contactez Nous',
                            style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 20,
                            )),
                        trailing: IconButton(
                            onPressed: () {
                              Helpers.launchInAppBrowser(Uri(
                                scheme: "https",
                                host: 'wa.me',
                                path: "+2250140355555/",
                              ));
                            },
                            icon: Icon(
                              Icons.phone_android,
                              color: boutiqueController.colorPrimary.value,
                            )),
                      ),
                    ),
                  ]))
            ])));
  }
}
