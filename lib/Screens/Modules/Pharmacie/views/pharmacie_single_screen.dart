import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Helpers/helpers.dart';
import 'package:jaime_yakro/Screens/Modules/Pharmacie/path_pharmacie.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PharmacieSingleScreen extends GetView<PharmacieSingleScreenController> {
  const PharmacieSingleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
      height: height / 1.3,
      width: width,
      decoration: BoxDecoration(
        color: controller.colorPrimary.value.withOpacity(0.17),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppConfig.borderRadius),
          topRight: Radius.circular(AppConfig.borderRadius),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 200,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConfig.cardRadius),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        '${controller.pharmacieModel.value.photo}'))),
          ),
          SizedBox(
            child: Text(
              '${controller.pharmacieModel.value.nom}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: GoogleFonts.nunito().fontFamily),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          'Medecin / Infirmer :',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.nunito().fontFamily),
                        ),
                        Text(
                          '${controller.pharmacieModel.value.medecin}',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: GoogleFonts.nunito().fontFamily),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          'Situation géographique :',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.nunito().fontFamily),
                        ),
                        Text(
                          '${controller.pharmacieModel.value.adresse} / Zone: ${controller.pharmacieModel.value.zone}',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: GoogleFonts.nunito().fontFamily),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: OutlinedButton(
                        onPressed: () {
                          launchUrl(Uri.parse(
                              '${controller.pharmacieModel.value.localisation}'));
                        },
                        child: Text(
                          'Itinéraire',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.nunito().fontFamily),
                        )),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: const BoxDecoration(),
                    height: 80,
                    width: 300,
                    child: Column(
                      children: [
                        Text(
                          'Contact :',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.nunito().fontFamily),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller
                                .pharmacieModel.value.contacts!.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(
                                  AppConfig.paddingBodySimple),
                              child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  const Text('Plus d\'Action'),
                                                  CircleAvatar(
                                                    backgroundColor: Colors.red,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        icon: const Icon(
                                                          Icons.close,
                                                          size: 20,
                                                        )),
                                                  )
                                                ],
                                              ),
                                              content: SizedBox(
                                                height: height / 7,
                                                width: width,
                                                child: Column(children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        launchUrl(
                                                          Uri.parse(
                                                              "tel:${controller.pharmacieModel.value.contacts![index].numero}"),
                                                        );
                                                      },
                                                      child: Text(
                                                        'Appeler',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .nunito()
                                                                    .fontFamily),
                                                      )),
                                                  TextButton(
                                                      onPressed: () {
                                                        Helpers.pressPapiers(
                                                            '${controller.pharmacieModel.value.contacts![index].numero}');
                                                      },
                                                      child: Text(
                                                        'Copier',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .nunito()
                                                                    .fontFamily),
                                                      )),
                                                ]),
                                              ),
                                            ));
                                  },
                                  child: Text(
                                      '${controller.pharmacieModel.value.contacts![index].numero}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: GoogleFonts.nunito()
                                              .fontFamily))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
