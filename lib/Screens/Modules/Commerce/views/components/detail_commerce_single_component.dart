import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Helpers/helpers.dart';
import 'package:jaime_yakro/Screens/Modules/Commerce/path_commerce.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailCommerceSingleComponent extends StatefulWidget {
  const DetailCommerceSingleComponent({super.key});

  @override
  State<DetailCommerceSingleComponent> createState() =>
      _DetailCommerceSingleComponentState();
}

class _DetailCommerceSingleComponentState
    extends State<DetailCommerceSingleComponent> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final CommerceSingleScreenController controllerCommerceSingleScreeen =
        Get.put(CommerceSingleScreenController());
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
                      '${controllerCommerceSingleScreeen.findCommerceModel.nom}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
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
                        //   color: controllerCommerceSingleScreeenHotelScreeen.colorPrimary.value,
                        // )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() => RatingBar.builder(
                                initialRating: double.parse(
                                    controllerCommerceSingleScreeen
                                        .commerceModel.value.moyenneRating.value
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
                                    controllerCommerceSingleScreeen.setRating(
                                        controllerCommerceSingleScreeen
                                            .findCommerceModel,
                                        rating);
                                  });
                                },
                                updateOnDrag: true,
                              )),
                          Text(
                            '${controllerCommerceSingleScreeen.findCommerceModel.countRating.value} Personnes ont données leur avis',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: GoogleFonts.nunito().fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 40,
                    //   // width: 60,
                    //   // color: Colors.amber,
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.end,
                    //     children: [
                    //       const Icon(Icons.star),
                    //       Text('4.9  ',
                    //           style: TextStyle(
                    //               fontFamily: GoogleFonts.nunito().fontFamily,
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 18)),
                    //       Text('(499 reviews)',
                    //           style: TextStyle(
                    //               fontFamily: GoogleFonts.nunito().fontFamily,
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 17))
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
              const Divider(),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: AppConfig.paddingBodySimple,
                      bottom: AppConfig.paddingBodySimple),
                  child: Text(
                    '${controllerCommerceSingleScreeen.findCommerceModel.description}',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Specialité : ',
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ...controllerCommerceSingleScreeen
                                .findCommerceModel.specialites!
                                .map((e) => Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: controllerCommerceSingleScreeen
                                          .colorPrimary.value
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      ' ${e.specialiteCommerceModel!.libelle} ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily:
                                              GoogleFonts.nunito().fontFamily),
                                    )))
                          ],
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
                  child: Row(
                    children: [
                      Text('Itinéraire : ',
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      TextButton(
                        onPressed: () {
                          launchUrl(Uri.parse(
                              '${controllerCommerceSingleScreeen.findCommerceModel.lien}'));
                        },
                        child: Text(
                          'Voir l\'Itinéraire',
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              color: controllerCommerceSingleScreeen
                                  .colorPrimary.value,
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
                              onTap: () async {
                                Uri url = Uri.parse(
                                    '${controllerCommerceSingleScreeen.findCommerceModel.facebook}');

                                Helpers.launchInAppBrowsers(url);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: controllerCommerceSingleScreeen
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
                                    '${controllerCommerceSingleScreeen.findCommerceModel.instagram}');

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
                              //https://wa.me/?text=urlencodedtext
                              onTap: () {
                                Helpers.launchInAppBrowser(Uri(
                                  scheme: "https",
                                  host: 'wa.me',
                                  path:
                                      "+225${controllerCommerceSingleScreeen.findCommerceModel.contact}?text=Bonjour",
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
                                    '${controllerCommerceSingleScreeen.findCommerceModel.site}');

                                Helpers.launchInAppBrowsers(url);
                                // launchUrl(Uri.parse(
                                //     '${controllerCommerceSingleScreeen.findCommerceModel.lien}'));
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
                      controller: controllerCommerceSingleScreeen
                          .textcommentaireController.value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: controllerCommerceSingleScreeen
                                  .colorPrimary.value),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(
                              width: 3,
                              color: controllerCommerceSingleScreeen
                                  .colorPrimary.value),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 3,
                              color: controllerCommerceSingleScreeen
                                  .colorPrimary.value),
                        ),
                        hintText: 'Commentaire',
                        suffixIcon: Obx(() => controllerCommerceSingleScreeen
                                .commentaireHotelLoading.value
                            ? CircularProgressIndicator(
                                color: controllerCommerceSingleScreeen
                                    .colorPrimary.value,
                              )
                            : IconButton(
                                color: controllerCommerceSingleScreeen
                                    .colorPrimary.value,
                                icon: Icon(
                                  Icons.send,
                                  color: controllerCommerceSingleScreeen
                                      .colorPrimary.value,
                                ),
                                onPressed: () {
                                  // print(controllerCommerceSingleScreeen
                                  //     .textcommentaireController.value.text);
                                  if (controllerCommerceSingleScreeen
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
                                    controllerCommerceSingleScreeen
                                        .postAddCommentaireCommerce(
                                            controllerCommerceSingleScreeen
                                                .findCommerceModel.id!);
                                  }
                                },
                              )),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          controllerCommerceSingleScreeen
                              .getAllCommentaireCommerce(
                                  controllerCommerceSingleScreeen
                                      .findCommerceModel.id!);
                          showBottomSheet(
                              context: context,
                              builder: (_) =>
                                  const BottomSheetCommentaireCommerceElement());
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
