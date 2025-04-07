import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';

class CardCartElement extends StatefulWidget {
  const CardCartElement({super.key, this.cartBoutiqueModel});
  final CartBoutiqueModel? cartBoutiqueModel;
  @override
  State<CardCartElement> createState() => _CardCartElementState();
}

class _CardCartElementState extends State<CardCartElement> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final BoutiqueScreenController commerceController =
        Get.put(BoutiqueScreenController());
    return Obx(() => Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConfig.borderRadius),
          ),
          child: Container(
            padding: const EdgeInsets.all(5),
            // height: height / 7,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConfig.borderRadius),
            ),
            child: Row(children: [
              Container(
                height: height / 8,
                width: width / 4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            '${AppConfig.baseUrl}${widget.cartBoutiqueModel!.produitBoutiqueModel.imageUrl!}'),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                height: height / 8,
                width: width / 2.5,
                child: Column(
                  children: [
                    Text(
                      widget.cartBoutiqueModel!.produitBoutiqueModel.libelle!,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: GoogleFonts.nunito().fontFamily),
                    ),
                    Text(
                        NumberFormat.currency(locale: 'fr', symbol: 'F').format(
                            double.parse(widget
                                .cartBoutiqueModel!.produitBoutiqueModel.prix
                                .toString())),
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: GoogleFonts.nunito().fontFamily)),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                onPressed: () {
                                  commerceController.controllerCartScreen
                                      .incrementQuantity(widget
                                          .cartBoutiqueModel!
                                          .produitBoutiqueModel);
                                }),
                          ),
                          Text(
                            'Qté: ${widget.cartBoutiqueModel!.quantite}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: commerceController
                                    .controllerCartScreen.colorPrimary.value,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: Center(
                              child: IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                  onPressed: () {
                                    commerceController.controllerCartScreen
                                        .decrementQuantity(widget
                                            .cartBoutiqueModel!
                                            .produitBoutiqueModel);
                                  }),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          commerceController.controllerCartScreen
                              .removeItemProduitBoutique(widget
                                  .cartBoutiqueModel!.produitBoutiqueModel);
                        }),
                    Container(
                      height: 40,
                      // width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.circular(AppConfig.borderRadius)),
                      child: Text(
                        NumberFormat.currency(locale: 'fr', symbol: 'F').format(
                            double.parse(widget.cartBoutiqueModel!.totalPrice
                                .toString())),
                        style: TextStyle(
                            fontFamily: GoogleFonts.nunito().fontFamily,
                            color: Colors.white,
                            fontSize: 17),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}
