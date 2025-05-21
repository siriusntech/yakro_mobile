import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Helpers/helpers.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Hotel/path_hotel.dart';
import 'package:jaime_yakro/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailHotelSingleComponent extends StatefulWidget {
  const DetailHotelSingleComponent({super.key, this.hotelModel});
  final HotelModel? hotelModel;
  @override
  State<DetailHotelSingleComponent> createState() =>
      _DetailHotelSingleComponentState();
}

class _DetailHotelSingleComponentState
    extends State<DetailHotelSingleComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final HotelScreenController controllerHotelScreeen =
        Get.put(HotelScreenController());
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(AppConfig.paddingBody),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: height / 10,
                width: width,
                decoration: const BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${widget.hotelModel!.nomHotel}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Text('Avis : ',
                  style: TextStyle(
                      fontFamily: GoogleFonts.nunito().fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 90,
                width: width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(
                  //   color: controllerHotelScreeen.colorPrimary.value,
                  // )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() => RatingBar.builder(
                          initialRating: double.parse(controllerHotelScreeen
                              .hotelSingleScreenController
                              .hotelModel
                              .value
                              .moyenneRating
                              .value
                              .toString()),
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 50,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, index) {
                            switch (index + 1) {
                              case 1:
                                return const Icon(
                                  Icons.sentiment_very_dissatisfied,
                                  color: Colors.red,
                                  size: 30,
                                );
                              case 2:
                                return const Icon(
                                  Icons.sentiment_dissatisfied,
                                  color: Colors.redAccent,
                                );
                              case 3:
                                return const Icon(
                                  Icons.sentiment_neutral,
                                  color: Colors.amber,
                                );
                              case 4:
                                return const Icon(
                                  Icons.sentiment_satisfied,
                                  color: Colors.lightGreen,
                                );
                              case 5:
                                return const Icon(
                                  Icons.sentiment_very_satisfied,
                                  color: Colors.green,
                                );
                              default:
                                return Container();
                            }
                          },
                          onRatingUpdate: (rating) {
                            setState(() {
                              controllerHotelScreeen.hotelSingleScreenController
                                  .setRating(widget.hotelModel!, rating);
                            });
                          },
                          updateOnDrag: true,
                        )),
                    Text(
                      '${controllerHotelScreeen.hotelSingleScreenController.hotelModel.value.countRating.value} Personnes ont données leur avis',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: GoogleFonts.nunito().fontFamily,
                      ),
                    ),
                  ],
                ),

                // Column(
                //   children: [
                //     Obx(() => Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                //           children: [
                //             Row(
                //               children: [
                //                 IconButton(
                //                     iconSize: 30,
                //                     onPressed: () {
                //                       controllerHotelScreeen.hotelController
                //                           .toggleLike(widget.hotelModel!);
                //                     },
                //                     icon: Icon(
                //                       Icons.thumb_up,
                //                       color: widget.hotelModel!.like.value ==
                //                               true
                //                           ? controllerHotelScreeen
                //                               .colorPrimary.value
                //                           : Colors.grey,
                //                     )),
                //                 Text(
                //                   '${widget.hotelModel!.countLike.value}',
                //                   style: TextStyle(
                //                       color: Colors.black,
                //                       fontFamily:
                //                           GoogleFonts.nunito().fontFamily,
                //                       fontSize: 18),
                //                 ),
                //               ],
                //             ),
                //             Row(
                //               children: [
                //                 IconButton(
                //                     iconSize: 30,
                //                     onPressed: () {
                //                       controllerHotelScreeen.hotelController
                //                           .toggleDislike(widget.hotelModel!);
                //                     },
                //                     icon: Icon(
                //                       Icons.thumb_down,
                //                       color:
                //                           widget.hotelModel!.dislike.value ==
                //                                   true
                //                               ? controllerHotelScreeen
                //                                   .colorPrimary.value
                //                               : Colors.grey,
                //                     )),
                //                 Text(
                //                   '${widget.hotelModel!.countDislike.value}',
                //                   style: TextStyle(
                //                       color: Colors.black,
                //                       fontFamily:
                //                           GoogleFonts.nunito().fontFamily,
                //                       fontSize: 18),
                //                 ),
                //               ],
                //             )
                //           ],
                //         )),
                //   ],
                // )

                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     const Icon(Icons.star),
                //     Text('4.9  ',
                //         style: TextStyle(
                //             fontFamily: GoogleFonts.nunito().fontFamily,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 18)),
                //     Text('(499 reviews)',
                //         style: TextStyle(
                //             fontFamily: GoogleFonts.nunito().fontFamily,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 17))
                //   ],
                // ),
              ),
              const Divider(),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: AppConfig.paddingBodySimple,
                      bottom: AppConfig.paddingBodySimple),
                  child: Text(
                    '${widget.hotelModel!.description}',
                    style: TextStyle(
                        fontFamily: GoogleFonts.nunito().fontFamily,
                        fontSize: 18),
                  ),
                ),
              ),
              const Divider(),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: AppConfig.paddingBodySimple,
                      bottom: AppConfig.paddingBodySimple),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tarif(s) : ',
                                style: TextStyle(
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                '* ${widget.hotelModel!.prix.toString()} FCFA / Jour'),
                            // const Text('- 15 000 Frs CFA / Jour'),
                            // const Text('- 15 000 Frs CFA / Jour'),
                          ],
                        ),
                      ),
                      // widget.hotelModel!.reduction != null ||
                      Obx(() => controllerHotelScreeen.mainController
                                      .hotelReductionEnable.value ==
                                  true &&
                              widget.hotelModel!.reduction!.ceil() != 0
                          ? Container(
                              height: 60,
                              width: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppConfig.cardRadius),
                                color: ConstColors.alertDanger,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.typeChambreHotelScreen);
                                },
                                child: Text(
                                  "Profitez de -${widget.hotelModel!.reduction!.ceil()}%",
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              ))
                          : Container())
                    ],
                  ),
                ),
              ),
              const Divider(),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: AppConfig.paddingBodySimple,
                      bottom: AppConfig.paddingBodySimple),
                  child: Row(
                    children: [
                      Text('Itinéraire : ',
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      TextButton(
                        onPressed: () {
                          launchUrl(Uri.parse('${widget.hotelModel!.lienMap}'));
                        },
                        child: Text(
                          'Voir l\'Itinéraire',
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              color: controllerHotelScreeen.colorPrimary.value,
                              fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: AppConfig.paddingBodySimple,
                      bottom: AppConfig.paddingBodySimple),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Social : ',
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                Uri url =
                                    Uri.parse('${widget.hotelModel!.facebook}');

                                Helpers.launchInAppBrowsers(url);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: controllerHotelScreeen
                                        .colorPrimary.value,
                                    borderRadius: BorderRadius.circular(
                                        AppConfig.borderRadius),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/icon/facebook.png"))),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Uri url = Uri.parse(
                                    '${widget.hotelModel!.instagram}');

                                Helpers.launchInAppBrowsers(url);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppConfig.borderRadius),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/icon/instagram.png"))),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                widget.hotelModel!.contact == null
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        content: Text(
                                          "Aucun Numero WhatsApp",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.red,
                                      ))
                                    : Helpers.launchInAppBrowser(Uri(
                                        scheme: "https",
                                        host: 'wa.me',
                                        path:
                                            "+225${widget.hotelModel!.contact}/",
                                      ));
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppConfig.borderRadius),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/icon/whatsapp.png"))),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Uri url = Uri.parse(
                                    '${widget.hotelModel!.siteInternet}');
                                Helpers.launchInAppBrowsers(url);

                                // launchUrl(Uri.parse(
                                //     '${widget.hotelModel!.siteInternet}'));
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppConfig.borderRadius),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/icon/lien-web.png"))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Commentaire : ',
                        style: TextStyle(
                            fontFamily: GoogleFonts.nunito().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Avez vous déjà séjournez dans ce Etablissement ? si Oui, donnez une note svp.',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: GoogleFonts.nunito().fontFamily,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controllerHotelScreeen
                          .hotelSingleScreenController
                          .textcommentaireController
                          .value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: controllerHotelScreeen.colorPrimary.value),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(
                              color: controllerHotelScreeen.colorPrimary.value),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: controllerHotelScreeen.colorPrimary.value),
                        ),
                        suffixIcon: Obx(() => controllerHotelScreeen
                                .hotelSingleScreenController
                                .commentaireHotelLoading
                                .value
                            ? CircularProgressIndicator(
                                color:
                                    controllerHotelScreeen.colorPrimary.value,
                              )
                            : IconButton(
                                color:
                                    controllerHotelScreeen.colorPrimary.value,
                                icon: Icon(
                                  Icons.send,
                                  color:
                                      controllerHotelScreeen.colorPrimary.value,
                                ),
                                onPressed: () {
                                  if (controllerHotelScreeen
                                          .hotelSingleScreenController
                                          .textcommentaireController
                                          .value
                                          .text ==
                                      '') {
                                    Get.snackbar(
                                      'Commentaire',
                                      'Veuillez renseigner votre commentaire svp',
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
                                  } else {
                                    controllerHotelScreeen
                                        .hotelSingleScreenController
                                        .postAddCommentaireHotel(
                                            widget.hotelModel!.id!);
                                  }
                                },
                              )),
                        hintText: 'Commentaire',
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          controllerHotelScreeen.hotelSingleScreenController
                              .getAllCommentaireHotel(widget.hotelModel!.id!);
                          showBottomSheet(
                              context: context,
                              builder: (_) =>
                                  const BottomSheetCommentaireElement());
                        },
                        child: Text(
                          "Voir les commentaires ...",
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 18),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
