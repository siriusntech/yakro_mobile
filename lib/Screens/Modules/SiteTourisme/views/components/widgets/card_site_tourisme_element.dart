import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/SiteTourisme/path_tourisme.dart';

class CardSiteTourismeElement extends StatefulWidget {
  const CardSiteTourismeElement(
      {super.key, required this.onTap, required this.siteTouristiqueModel});

  final Callback onTap;
  final SiteTouristiqueModel siteTouristiqueModel;
  @override
  State<CardSiteTourismeElement> createState() =>
      _CardSiteTourismeElementState();
}

class _CardSiteTourismeElementState extends State<CardSiteTourismeElement> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final SiteTourismeScreenController controllersiteTourismeScreeen =
        Get.put(SiteTourismeScreenController());
    final SiteTouristiqueApiController controllerApi =
        Get.put(SiteTouristiqueApiController());
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConfig.cardRadius),
            color: controllersiteTourismeScreeen.colorPrimary.value
                .withOpacity(0.17)),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height / 3.5,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppConfig.cardRadius),
                      color: controllersiteTourismeScreeen.colorPrimary.value,
                      image: DecorationImage(
                          image: NetworkImage(
                            "${widget.siteTouristiqueModel.medias![0].url}",
                          ),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                    right: 0,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: controllersiteTourismeScreeen
                              .colorPrimary.value
                              .withOpacity(0.7),
                          borderRadius:
                              BorderRadius.circular(AppConfig.cardRadius)),
                      child: Obx(() => IconButton(
                            icon: Icon(
                              widget.siteTouristiqueModel.isFavorite.value
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                                  widget.siteTouristiqueModel.isFavorite.value
                                      ? Colors.white
                                      : Colors.white,
                            ),
                            onPressed: () => controllerApi
                                .toggleFavorite(widget.siteTouristiqueModel),
                          )),
                    ))
              ],
            ),
            Container(
              padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          widget.siteTouristiqueModel.nomVt.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        // width: 60,
                        // color: Colors.amber,
                        child: Row(
                          children: [
                            const Icon(Icons.favorite),
                            Text('',
                                style: TextStyle(
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            Obx(() => Text(
                                '(${widget.siteTouristiqueModel.countFavoris.value})',
                                style: TextStyle(
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17)))
                          ],
                        ),
                      )
                    ],
                  ),
                  widget.siteTouristiqueModel.contact == null
                      ? Container()
                      : Text(
                          'contact: ${widget.siteTouristiqueModel.contact.toString()}',
                          style: TextStyle(
                            fontFamily: GoogleFonts.nunito().fontFamily,
                            fontSize: 15,
                          ),
                        ),
                  const SizedBox(
                    height: 2,
                  ),
                  widget.siteTouristiqueModel.prix == null ||
                          widget.siteTouristiqueModel.prix == 0
                      ? Container()
                      : Text(
                          'A partir de ${NumberFormat.currency(locale: 'fr', symbol: 'FCFA').format(widget.siteTouristiqueModel.prix)}',
                          style: TextStyle(
                            fontFamily: GoogleFonts.anuphan().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
