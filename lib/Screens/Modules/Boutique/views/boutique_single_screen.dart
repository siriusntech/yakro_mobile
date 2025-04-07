import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BoutiqueSingleScreen extends StatefulWidget {
  const BoutiqueSingleScreen({super.key, this.produitBoutiqueModel});
  final ProduitBoutiqueModel? produitBoutiqueModel;
  @override
  State<BoutiqueSingleScreen> createState() => _BoutiqueSingleScreenState();
}

class _BoutiqueSingleScreenState extends State<BoutiqueSingleScreen> {
  @override
  Widget build(BuildContext context) {
    final commerceController = Get.put(BoutiqueScreenController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: height / 2.5,
                width: width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            '${AppConfig.baseUrl}${widget.produitBoutiqueModel!.imageUrl!}'),
                        fit: BoxFit.contain)),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: CircleAvatar(
                  backgroundColor: commerceController.colorPrimary.value,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                        commerceController.setFloatingDisable(false);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppConfig.paddingBody),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              NumberFormat.currency(locale: 'fr', symbol: 'F')
                                  .format(double.parse(widget
                                      .produitBoutiqueModel!.prix
                                      .toString())),
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 25)),
                          widget.produitBoutiqueModel!.quantite! > 0
                              ? Text(
                                  'Stock: ${widget.produitBoutiqueModel!.quantite}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 25))
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Text('${widget.produitBoutiqueModel!.libelle}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 18)),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   height: 60,
                    //   width: width,
                    //   decoration: const BoxDecoration(),
                    //   child: Row(
                    //     children: [
                    //       OutlinedButton(
                    //           onPressed: () {
                    //             print(
                    //                 'DEVICE ID : ${commerceController.cartBoutiqueControllerGetter.mainController.deviceId.value}');
                    //           },
                    //           child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceAround,
                    //             children: [
                    //               const Icon(
                    //                 Icons.favorite,
                    //                 color: Color(0xFFF38022),
                    //               ),
                    //               const SizedBox(
                    //                 width: 5,
                    //               ),
                    //               Text(
                    //                 '4.5',
                    //                 style: TextStyle(
                    //                     fontFamily:
                    //                         GoogleFonts.nunito().fontFamily,
                    //                     color: Colors.black),
                    //               )
                    //             ],
                    //           )),
                    //       const SizedBox(
                    //         width: 30,
                    //       ),
                    //       OutlinedButton(
                    //           onPressed: null,
                    //           child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceAround,
                    //             children: [
                    //               Text(
                    //                 '199 reviews',
                    //                 style: TextStyle(
                    //                     fontFamily:
                    //                         GoogleFonts.nunito().fontFamily,
                    //                     color: Colors.black),
                    //               )
                    //             ],
                    //           ))
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Description',
                              style: TextStyle(
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                        Text(
                          '${widget.produitBoutiqueModel!.description}',
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 15),
                        ),
                      ],
                    )),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // Container(
                    //   padding: const EdgeInsets.all(2),
                    //   height: height / 16,
                    //   width: width,
                    //   alignment: Alignment.center,
                    //   decoration: const BoxDecoration(),
                    //   child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Expanded(
                    //             child: Container(
                    //           decoration: BoxDecoration(
                    //               color: commerceController.colorPrimary.value
                    //                   .withOpacity(0.5),
                    //               borderRadius: BorderRadius.circular(
                    //                   AppConfig.cardRadius)),
                    //           child: const Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Icon(
                    //                 Icons.share,
                    //                 color: Colors.white,
                    //               ),
                    //               Text('Partager',
                    //                   style: TextStyle(color: Colors.white))
                    //             ],
                    //           ),
                    //         )),
                    //         const SizedBox(
                    //           width: 30,
                    //         ),
                    //         Expanded(
                    //             child: Container(
                    //           decoration: BoxDecoration(
                    //               color: commerceController.colorPrimary.value
                    //                   .withOpacity(0.5),
                    //               borderRadius: BorderRadius.circular(
                    //                   AppConfig.cardRadius)),
                    //           child: const Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Icon(
                    //                 Icons.favorite,
                    //                 color: Colors.white,
                    //               ),
                    //               Text("J'aime",
                    //                   style: TextStyle(color: Colors.white))
                    //             ],
                    //           ),
                    //         ))
                    //       ]),
                    // ),
                    const SizedBox(
                      height: 60,
                    ),
                    widget.produitBoutiqueModel!.quantite! > 0
                        ? Obx(() => commerceController
                                .controllerCartScreen.cartBoutiqueListGetter
                                .where((element) =>
                                    element.produitBoutiqueModel.id ==
                                    widget.produitBoutiqueModel!.id)
                                .isEmpty
                            ? InkWell(
                                onTap: () {
                                  commerceController.controllerCartScreen
                                      .addToCart(
                                          widget.produitBoutiqueModel!,
                                          commerceController.controllerBoutique
                                              .orderNumber.value);
                                  Get.back();
                                  commerceController.setFloatingDisable(false);
                                },
                                child: Container(
                                  height: 70,
                                  width: width,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppConfig.cardRadius),
                                      color:
                                          commerceController.colorPrimary.value,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 5,
                                            offset: Offset(0, 5))
                                      ]),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Ajouter au Panier',
                                        style: TextStyle(
                                          color: ConstColors.appbarTextColor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.add_shopping_cart,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                height: 70,
                                width: width,
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            commerceController
                                                .controllerCartScreen
                                                .incrementQuantity(widget
                                                    .produitBoutiqueModel!);
                                          });
                                        },
                                        child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: commerceController
                                                .colorPrimary.value,
                                            borderRadius: BorderRadius.circular(
                                                AppConfig.cardRadius),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 80,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${commerceController.controllerCartScreen.cartBoutiqueList.where((element) => element.produitBoutiqueModel.id == widget.produitBoutiqueModel!.id).first.quantite}',
                                        style: const TextStyle(fontSize: 25),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            commerceController
                                                .controllerCartScreen
                                                .decrementQuantity(widget
                                                    .produitBoutiqueModel!);
                                          });
                                        },
                                        child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: commerceController
                                                .colorPrimary.value,
                                            borderRadius: BorderRadius.circular(
                                                AppConfig.cardRadius),
                                          ),
                                          child: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        : Container(
                            height: 70,
                            width: width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppConfig.cardRadius),
                                color: commerceController.colorPrimary.value,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      offset: Offset(0, 5))
                                ]),
                            child: const Text(
                              "En rupture de stock",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
