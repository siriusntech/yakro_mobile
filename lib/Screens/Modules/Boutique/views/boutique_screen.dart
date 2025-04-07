import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Screens/Widgets/alert_dialog_windget.dart';
import 'package:quickalert/models/quickalert_type.dart';

import 'components/FloatingActionButton/floating_expandable.dart';

class BoutiqueScreen extends StatefulWidget {
  const BoutiqueScreen({super.key});

  @override
  State<BoutiqueScreen> createState() => _BoutiqueScreenState();
}

class _BoutiqueScreenState extends State<BoutiqueScreen> {
  final commerceController = Get.put(BoutiqueScreenController());
  @override
  void initState() {
    commerceController.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    commerceController.controllerBoutique.produitBoutiqueControllerGetter
        .getAllProduitBoutiqueByPub();
    commerceController.floatingDisable = false.obs;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Obx(
      () => commerceController.typeScreenGetter == TypeScreen.boutiqueScreen
          ? Scaffold(
              floatingActionButton: commerceController.floatingDisable.value ==
                      false
                  ? ExpandableFab(
                      distance: 112,
                      colorPrimary: commerceController.colorPrimary.value,
                      children: [
                        // ActionButton(
                        //   onPressed: () => print("Action 1"),
                        //   icon: const Icon(Icons.favorite),
                        //   color: commerceController.colorSecondary.value,
                        // ),
                        ActionButton(
                          onPressed: () {
                            commerceController.authController.authModel.value ==
                                        null ||
                                    commerceController.authController.authModel
                                            .value!.userModel!.nom ==
                                        null
                                ? quickAlertDialog(
                                    context, QuickAlertType.warning,
                                    color:
                                        commerceController.colorPrimary.value,
                                    message: "Veuillez vous connecter")
                                : commerceController.setChangeScreen(
                                    TypeScreen.profileUserScreen);
                          },
                          icon: const Icon(Icons.person),
                          color: commerceController.colorSecondary.value,
                        ),
                        Stack(
                          children: [
                            ActionButton(
                              onPressed: () {
                                commerceController
                                    .setChangeScreen(TypeScreen.cartScreen);
                              },
                              icon: const Icon(Icons.shopping_cart),
                              color: commerceController.colorSecondary.value,
                            ),
                            Positioned(
                              top: -2,
                              right: -2,
                              child: Container(
                                height: 23,
                                width: 23,
                                decoration: BoxDecoration(
                                  color: commerceController.colorPrimary.value,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Obx(() => Center(
                                      child: Text(
                                        "${commerceController.controllerCartScreen.cartBoutiqueListGetter.length}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: GoogleFonts.nunito()
                                                .fontFamily),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : null,

              // Obx(() => commerceController.floatingDisable.value == false
              //     ?
              //     Stack(
              //   children: [
              //     FloatingActionButton(
              //       backgroundColor: Colors.amber,
              //       onPressed: () {
              //         print('Person');
              //       },
              //       child: const Icon(
              //         Icons.person,
              //         color: Colors.white,
              //       ),
              //     ),
              //     Positioned(
              //         top: 0,
              //         right: 0,
              //         child: Container(
              //           height: 23,
              //           width: 23,
              //           decoration: BoxDecoration(
              //             color: commerceController.colorPrimary.value,
              //             borderRadius: const BorderRadius.only(
              //               // topLeft: Radius.circular(15),
              //               topRight: Radius.circular(15),
              //               bottomLeft: Radius.circular(15),
              //               // bottomRight: Radius.circular(15),
              //             ),
              //           ),
              //           child: Center(
              //             child: Text(
              //               "2",
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 16,
              //                   fontFamily: GoogleFonts.nunito().fontFamily),
              //             ),
              //           ),
              //         ))
              //   ],
              // ),
              // : const SizedBox()),
              body: Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    //App Bar
                    Container(
                      padding:
                          const EdgeInsets.all(AppConfig.paddingBodySimple),
                      height: height / 12,
                      width: width,
                      decoration: BoxDecoration(
                          color: commerceController.colorPrimary.value),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  child:
                                      Image.asset("assets/images/achats.png"),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('${commerceController.title}',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.taprom().fontFamily)),
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
                                  Get.back();
                                },
                                color: Colors.white,
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //Affiche Pub
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          commerceController.controllerCartScreen
                                  .cartBoutiqueListGetter.isNotEmpty
                              ? Obx(() => Container(
                                    height: 60,
                                    width: width / 2,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(
                                          AppConfig.bottonsheetRadius),
                                    ),
                                    child: Text(
                                      'Total: ${commerceController.controllerCartScreen.totalGetter}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ))
                              : const SizedBox(
                                  height: 0,
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: AppConfig.paddingBodySimple,
                              right: AppConfig.paddingBodySimple,
                            ),
                            height: 50,
                            width: width,
                            decoration: BoxDecoration(
                                color: commerceController.colorPrimary.value
                                    .withOpacity(0.4),
                                borderRadius: BorderRadius.circular(
                                    AppConfig.borderRadius)),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cherchez un article',
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontSize: 18),
                                ),
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.black38),
                                  child: IconButton(
                                      onPressed: () async {
                                        await showSearch(
                                          context: context,
                                          delegate: BoutiqueSearchComponent(),
                                        );
                                      },
                                      color: Colors.white,
                                      icon: const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const BoutiqueComponent()
                  ],
                ),
              ),
            )
          : commerceController.typeScreenGetter == TypeScreen.cartScreen
              ? const CartScreen()
              : commerceController.typeScreenGetter ==
                      TypeScreen.profileUserScreen
                  ? const ProfilScreen()
                  : const Scaffold(
                      body: Text('Profile Screen'),
                    ),
    );
  }
}
