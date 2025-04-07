import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
        child: Column(
          children: [
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
                        Text('${boutiqueController.controllerCartScreen.title}',
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
            Padding(
                padding: const EdgeInsets.all(4.0),
                child: Obx(() => Column(children: [
                      Container(
                        height: height / 2.4,
                        width: width,
                        decoration: BoxDecoration(
                          // color: boutiqueController.colorPrimary.value,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: boutiqueController.controllerCartScreen
                                .cartBoutiqueListGetter.isEmpty
                            ? Center(
                                child: Text(
                                  'Votre panier est vide',
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontSize: 20),
                                ),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) =>
                                    CardCartElement(
                                      cartBoutiqueModel: boutiqueController
                                          .controllerCartScreen
                                          .cartBoutiqueListGetter[index],
                                    ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 10,
                                    ),
                                itemCount: boutiqueController
                                    .controllerCartScreen
                                    .cartBoutiqueListGetter
                                    .length),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          height: height / 5,
                          width: width,
                          decoration: BoxDecoration(
                            color: boutiqueController
                                .controllerCartScreen.colorSecondary.value,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Facture',
                                  style: TextStyle(
                                      color:
                                          boutiqueController.colorPrimary.value,
                                      fontWeight: FontWeight.bold,
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontSize: 25),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                width: width,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Panier: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily:
                                                GoogleFonts.nunito().fontFamily,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        boutiqueController
                                            .controllerCartScreen.totalGetter,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily:
                                                GoogleFonts.nunito().fontFamily,
                                            fontSize: 20),
                                      )
                                    ]),
                              ),
                              // Container(
                              //   padding: const EdgeInsets.all(5),
                              //   width: width,
                              //   child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         Text(
                              //           'Frais de Livraison : ',
                              //           style: TextStyle(
                              //               color: Colors.black,
                              //               fontFamily:
                              //                   GoogleFonts.nunito().fontFamily,
                              //               fontSize: 18),
                              //         ),
                              //         Text(
                              //             '${boutiqueController.controllerBoutique
                              //                 .currentShipping.value!.prix!} F',
                              //           style: TextStyle(
                              //               color: Colors.black,
                              //               fontFamily:
                              //                   GoogleFonts.nunito().fontFamily,
                              //               fontSize: 18),
                              //         )
                              //       ]),
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                height: 10,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 0,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    color:
                                        boutiqueController.colorPrimary.value,
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total : ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: GoogleFonts.nunito()
                                                  .fontFamily,
                                              fontSize: 25),
                                        ),
                                        Text(
                                          boutiqueController
                                              .controllerCartScreen.totalGetter,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: GoogleFonts.nunito()
                                                  .fontFamily,
                                              fontSize: 25),
                                        )
                                      ]),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      boutiqueController.controllerCartScreen
                              .cartBoutiqueListGetter.isNotEmpty
                          ? InkWell(
                              onTap: () => {
                                boutiqueController.userBoutiqueControllerGetter
                                    .getUserBoutiqueWithDeviceId(),
                                boutiqueController.controllerCartScreen
                                    .genererCodeCommande(context)
                              },
                              child: Container(
                                height: height / 15,
                                width: width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:
                                        boutiqueController.panierButton.value,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'Passer la commande',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily),
                                ),
                              ),
                            )
                          : const SizedBox(
                              height: 0,
                            )
                    ])))
          ],
        ),
      ),
    );
  }
}
