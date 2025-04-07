import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Screens/Modules/Evenement/path_evenement.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailEvenementSingleComponent
    extends GetView<EvenementScreenController> {
  const DetailEvenementSingleComponent({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                      'Hotel des savanes korhogo',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 40,
                      // width: 60,
                      // color: Colors.amber,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(Icons.star),
                          Text('4.9  ',
                              style: TextStyle(
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          Text('(499 reviews)',
                              style: TextStyle(
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17))
                        ],
                      ),
                    )
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
                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Rerum sed numquam ex illum vitae eveniet dicta dolor accusantium earum? Commodi expedita laudantium consectetur voluptate at tenetur aperiam ipsa atque est.',
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
                      Text('Tarif(s) : ',
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('- 15 000 Frs CFA / Jour'),
                      const Text('- 15 000 Frs CFA / Jour'),
                      const Text('- 15 000 Frs CFA / Jour'),
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
                  child: Text('Itinéraire : ',
                      style: TextStyle(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
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
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Get.arguments['color'],
                                  borderRadius: BorderRadius.circular(
                                      AppConfig.borderRadius),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/icon/facebook.png"))),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      AppConfig.borderRadius),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/icon/instagram.png"))),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      AppConfig.borderRadius),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/icon/whatsapp.png"))),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      AppConfig.borderRadius),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/icon/lien-web.png"))),
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Commentaire',
                      ),
                    )
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
