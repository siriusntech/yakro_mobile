import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Helpers/helpers.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/views/components/add_location_component.dart';
import 'package:quickalert/quickalert.dart';

class ConfirmationCommandeScreen extends StatefulWidget {
  const ConfirmationCommandeScreen({super.key});

  @override
  State<ConfirmationCommandeScreen> createState() =>
      _ConfirmationCommandeScreenState();
}

class _ConfirmationCommandeScreenState
    extends State<ConfirmationCommandeScreen> {
  @override
  Widget build(BuildContext context) {
    final commerceController = Get.put(BoutiqueScreenController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // print(commerceController.controllerBoutique.orderNumber);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: commerceController.colorPrimary.value,
        title: Text('${commerceController.controllerCommandeScreen.title}',
            style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.taprom().fontFamily)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                // height: height / 4,
                width: width,
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        height: height / 5,
                        width: width,
                        decoration: BoxDecoration(
                          color: commerceController
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
                                'RESUME DE COMMANDE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontSize: 18),
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
                                          fontSize: 17),
                                    ),
                                    Text(
                                      commerceController
                                          .controllerCartScreen.totalGetter,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily:
                                              GoogleFonts.nunito().fontFamily,
                                          fontSize: 17),
                                    )
                                  ]),
                            ),
                            commerceController.controllerCommandeScreenGetter
                                        .typeLivraison.value ==
                                    TypeLivraison.domicile
                                ? Container(
                                    padding: const EdgeInsets.all(5),
                                    width: width,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Frais de Livraison : ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: GoogleFonts.nunito()
                                                    .fontFamily,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            commerceController
                                                .controllerCartScreen
                                                .prixLivraisonGetter,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: GoogleFonts.nunito()
                                                    .fontFamily,
                                                fontSize: 16),
                                          )
                                        ]),
                                  )
                                : SizedBox(),
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
                                  color: commerceController.colorPrimary.value,
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
                                            fontFamily:
                                                GoogleFonts.nunito().fontFamily,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        commerceController.controllerCartScreen
                                            .totalTTCGetter,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                                GoogleFonts.nunito().fontFamily,
                                            fontSize: 18),
                                      )
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  // height: height / 7,
                  width: width,
                  decoration: BoxDecoration(
                    // color: commerceController.colorPrimary.value,
                    border: Border.all(
                        color: commerceController.colorSecondary.value),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: width,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: commerceController.colorSecondary.value,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Type de Livraison',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.nunito().fontFamily,
                            fontSize: 20,
                          ),
                        ),
                      ),

                      RadioListTile<TypeLivraison>(
                        title: Text(
                          'Domicile',
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontWeight: FontWeight.bold,
                              color: commerceController
                                          .controllerCommandeScreenGetter
                                          .typeLivraison
                                          .value ==
                                      TypeLivraison.domicile
                                  ? Colors.black
                                  : Colors.black),
                        ),
                        subtitle: Row(
                          children: [
                            Text('Entre le ${Helpers.addOneDay(DateTime.now(), days: 3)}'),
                            const Text(' et le '),
                            Text(
                                Helpers.addOneDay(DateTime.now(), days: 5)
                            ),
                          ],
                        ),
                        value: TypeLivraison.domicile,
                        groupValue: commerceController
                            .controllerCommandeScreenGetter.typeLivraison.value,
                        onChanged: (value) {
                          setState(() {
                            commerceController.controllerCartScreenGetter
                                .getShippingByCurrentHour();
                            commerceController.controllerCartScreenGetter
                                .setChangeAmounLivraison(double.parse(
                                    commerceController
                                        .controllerCartScreenGetter
                                        .currentShipping
                                        .value!
                                        .prix
                                        .toString()));
                            commerceController.controllerCommandeScreenGetter
                                .typeLivraison.value = value!;
                          });
                        },
                        activeColor: commerceController.colorSecondary.value,
                        selected: commerceController
                                .controllerCommandeScreenGetter
                                .typeLivraison
                                .value ==
                            TypeLivraison.domicile,
                      ),
                      // RadioListTile<TypeLivraison>(
                      //   title: Text(
                      //     'Point de relais',
                      //     style: TextStyle(
                      //         fontFamily: GoogleFonts.nunito().fontFamily,
                      //         fontWeight: FontWeight.bold,
                      //         color: commerceController
                      //                     .controllerCommandeScreenGetter
                      //                     .typeLivraison
                      //                     .value ==
                      //                 TypeLivraison.point_relais
                      //             ? Colors.black
                      //             : Colors.black),
                      //   ),
                      //   subtitle: Row(
                      //     children: [
                      //       Text('Entre le ${Helpers.addOneDay(DateTime.now(), days: 3)}'),
                      //       const Text(' et le '),
                      //       Text(
                      //           Helpers.addOneDay(DateTime.now(), days: 5)                     ),
                      //     ],
                      //   ),
                      //   value: TypeLivraison.point_relais,
                      //   groupValue: commerceController
                      //       .controllerCommandeScreenGetter.typeLivraison.value,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       commerceController.controllerCartScreenGetter
                      //           .setChangeAmounLivraison(0.0);
                      //       commerceController.controllerCommandeScreenGetter
                      //           .typeLivraison.value = value!;
                      //     });
                      //   },
                      //   activeColor: commerceController.colorSecondary.value,
                      //   selected: commerceController
                      //           .controllerCommandeScreenGetter
                      //           .typeLivraison
                      //           .value ==
                      //       TypeLivraison.point_relais,
                      // ),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              Obx(() => commerceController.controllerCommandeScreenGetter
                              .typeLivraison.value ==
                          TypeLivraison.domicile ||
                      commerceController.controllerCommandeScreenGetter
                              .typeLivraison.value ==
                          TypeLivraison.point_relais
                  ? Container(
                      // height: height / 7,
                      width: width,
                      decoration: BoxDecoration(
                        // color: commerceController.colorPrimary.value,
                        border: Border.all(
                            color: commerceController.colorSecondary.value),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: width,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: commerceController.colorSecondary.value,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  commerceController
                                              .controllerCommandeScreenGetter
                                              .typeLivraison
                                              .value ==
                                          TypeLivraison.point_relais
                                      ? 'Ajouter'
                                      : 'Ajouter une Adresse ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontSize: 20,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) =>
                                              const AddLocationComponent());
                                    },
                                    icon: const Icon(
                                        Icons.add_location_alt_outlined))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            child: Obx(() => commerceController
                                    .userBoutiqueControllerGetter
                                    .userBoutiqueList
                                    .isEmpty
                                ? Text(
                                    'Aucune Adresse',
                                    style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.nunito().fontFamily,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )
                                : ListView.builder(
                                    itemCount: commerceController
                                        .userBoutiqueControllerGetter
                                        .userBoutiqueList
                                        .length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        // width:300,
                                        height: 60,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 300,
                                              child: RadioListTile<
                                                  UserBoutiqueModel>(
                                                title: Text(
                                                  "${commerceController.userBoutiqueControllerGetter.userBoutiqueList[index].nom} ${commerceController.userBoutiqueControllerGetter.userBoutiqueList[index].prenoms}",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.nunito()
                                                              .fontFamily,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: commerceController
                                                                  .controllerCommandeScreenGetter
                                                                  .typeLivraison
                                                                  .value ==
                                                              TypeLivraison
                                                                  .domicile
                                                          ? Colors.black
                                                          : Colors.black),
                                                ),
                                                subtitle: Text(
                                                    '${commerceController.userBoutiqueControllerGetter.userBoutiqueList[index].quartier}'),
                                                value: commerceController
                                                    .userBoutiqueControllerGetter
                                                    .userBoutiqueList[index],
                                                groupValue: commerceController
                                                    .userBoutiqueControllerGetter
                                                    .userBoutique
                                                    .value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    commerceController
                                                        .userBoutiqueControllerGetter
                                                        .userBoutique
                                                        .value = value!;
                                                  });
                                                },
                                                activeColor: commerceController
                                                    .colorSecondary.value,
                                                selected: commerceController
                                                        .userBoutiqueControllerGetter
                                                        .userBoutique
                                                        .value ==
                                                    commerceController
                                                        .userBoutiqueControllerGetter
                                                        .userBoutiqueList[index],
                                              ),
                                            ),
                                            // IconButton(
                                            //     onPressed: () {
                                            //       commerceController
                                            //           .userBoutiqueControllerGetter
                                            //           .editUserBoutique(
                                            //               commerceController
                                            //                   .userBoutiqueControllerGetter
                                            //                   .userBoutiqueList[
                                            //                       index]
                                            //                   .id!);
                                            //     },
                                            //     icon: const Icon(
                                            //       Icons.edit,
                                            //       color: Colors.red,
                                            //     ))
                                          ],
                                        ),
                                      );
                                    })),
                          )
                        ],
                      ))
                  : const SizedBox()),
              const SizedBox(
                height: 20,
              ),
              commerceController
                          .controllerCommandeScreenGetter.typeLivraison.value ==
                      TypeLivraison.domicile
                  ? const Text(
                      'Le Paiement se fera à la livraison',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 20,
              ),
              Obx(() => commerceController
                          .controllerBoutique.validCommandLoading.value ==
                      false
                  ? InkWell(
                      onTap: () {
                        // print(commerceController.userBoutiqueControllerGetter
                        //     .userBoutique.value!.nom);
                        // return null;
                        if (commerceController.userBoutiqueControllerGetter
                                .userBoutiqueList.isEmpty &&
                            commerceController.controllerCommandeScreenGetter
                                    .typeLivraison.value ==
                                TypeLivraison.domicile) {
                          Get.snackbar(
                            "Attention",
                            "Ajoutez d'abord un Lieu",
                            backgroundColor: ConstColors.alertWarnig,
                            colorText: Colors.white,
                            snackStyle: SnackStyle.FLOATING,
                            borderRadius: 10,
                            margin: const EdgeInsets.all(10),
                            icon: const Icon(
                              Icons.warning,
                              color: Colors.white,
                            ),
                          );
                          return;
                        } else if (commerceController
                                    .userBoutiqueControllerGetter
                                    .userBoutique
                                    .value ==
                                null &&
                            commerceController.controllerCommandeScreenGetter
                                    .typeLivraison.value ==
                                TypeLivraison.domicile) {
                          Get.snackbar(
                            "Attention",
                            "Selectionnez d'abord un Lieu",
                            backgroundColor: ConstColors.alertWarnig,
                            colorText: Colors.white,
                            snackStyle: SnackStyle.FLOATING,
                            borderRadius: 10,
                            margin: const EdgeInsets.all(10),
                            icon: const Icon(
                              Icons.warning,
                              color: Colors.white,
                            ),
                          );
                          return;
                        } else if (commerceController
                                .userBoutiqueControllerGetter
                                .userBoutiqueList
                                .isEmpty &&
                            commerceController.controllerCommandeScreenGetter
                                    .typeLivraison.value ==
                                TypeLivraison.point_relais) {
                          Get.snackbar(
                            "Attention",
                            "Ajoutez une personne",
                            backgroundColor: ConstColors.alertWarnig,
                            colorText: Colors.white,
                            snackStyle: SnackStyle.FLOATING,
                            borderRadius: 10,
                            margin: const EdgeInsets.all(10),
                            icon: const Icon(
                              Icons.warning,
                              color: Colors.white,
                            ),
                          );
                        } else if (commerceController
                                    .userBoutiqueControllerGetter
                                    .userBoutique
                                    .value ==
                                null &&
                            commerceController.controllerCommandeScreenGetter
                                    .typeLivraison.value ==
                                TypeLivraison.point_relais) {
                          Get.snackbar(
                            "Attention",
                            "Selectionnez d'abord une Personne",
                            backgroundColor: ConstColors.alertWarnig,
                            colorText: Colors.white,
                            snackStyle: SnackStyle.FLOATING,
                            borderRadius: 10,
                            margin: const EdgeInsets.all(10),
                            icon: const Icon(
                              Icons.warning,
                              color: Colors.white,
                            ),
                          );
                          return;
                        }
                        // print([commerceController.controllerCommandeScreenGetter
                        //     .typeLivraison.value, commerceController
                        //     .userBoutiqueControllerGetter
                        //     .userBoutique
                        //     .value!.nom]);
                        QuickAlert.show(
                          context: context,
                          type: commerceController.controllerBoutique
                                      .validCommandLoading.value ==
                                  false
                              ? QuickAlertType.confirm
                              : QuickAlertType.loading,
                          text:
                              'Commande de ${commerceController.controllerCartScreenGetter.totalTTCGetter} \n Client: ${commerceController.userBoutiqueControllerGetter.userBoutique.value!.nom} ${commerceController.userBoutiqueControllerGetter.userBoutique.value!.prenoms} \n Téléphone: ${commerceController.userBoutiqueControllerGetter.userBoutique.value!.telephone} \n Type Livraison: ${commerceController.controllerCommandeScreenGetter.typeLivraison.value == TypeLivraison.domicile ? 'Domicile' : 'Point Relais'}',
                          onCancelBtnTap: () {
                            Get.back();
                          },
                          onConfirmBtnTap: () {
                            commerceController.controllerBoutique.validerCommande(
                                context: context,
                                quantity: commerceController
                                    .controllerCartScreen
                                    .cartBoutiqueListGetter
                                    .length,
                                shippingId: commerceController
                                            .controllerCommandeScreenGetter
                                            .typeLivraison
                                            .value ==
                                        TypeLivraison.point_relais
                                    ? 3
                                    : commerceController.controllerBoutique
                                        .currentShipping.value!.id!,
                                subTotal: commerceController
                                    .controllerCartScreen.totalGetter,
                                totalAmount: commerceController.controllerCartScreenGetter.totalTTCGetter,
                                typeLivraison: commerceController
                                    .controllerCommandeScreenGetter
                                    .typeLivraison
                                    .value,
                                jourLivraison: "Entre le ${Helpers.addOneDay(DateTime.now(), days: 3)} et le ${Helpers.addOneDay(DateTime.now(), days: 5)}",
                                nbrJourAvLivraison: 5);
                            commerceController.authController.checkDeviceId();
                            commerceController.controllerCartScreenGetter
                                .clearCart();
                            // commerceController.controllerBoutiqueGetter.orderNumber.value = 'ORDER_${Helpers.generateRandomString(5).toUpperCase()}';
                            commerceController
                                .setChangeScreen(TypeScreen.boutiqueScreen);
                          },
                          title: 'Confirmer la commande',
                          confirmBtnColor:
                              commerceController.colorSecondary.value,
                        );
                      },
                      child: Container(
                        height: height / 15,
                        width: width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: commerceController.panierButton.value,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'Valider la commande',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: GoogleFonts.nunito().fontFamily),
                        ),
                      ),
                    )
                  : SizedBox(
                      child: SpinKitDoubleBounce(
                        color: commerceController.colorSecondary.value,
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
