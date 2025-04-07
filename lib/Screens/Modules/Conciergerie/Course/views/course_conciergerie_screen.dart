import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Helpers/helpers.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Course/path_course.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseConciergerieScreen
    extends GetView<CourseConciergerieScreenController> {
  const CourseConciergerieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: controller.colorPrimary.value,
        title: Text('${controller.title.value} Yakro',
            style: TextStyle(
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.taprom().fontFamily)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: controller.colorPrimary.value,
        onPressed: () {
          controller.codeCourse.value = 'COURSE_${Helpers.generateRandomString(6).toUpperCase()}';
          showDialog(
              context: context,
              builder: (_) => const AddCourseConciergerieComponent());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          controller.getCourseConciergerieListByUser();
          return Future.value();
        },
        child: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(),
            child: Obx(() => controller.courseConciergerieLoading.value
                ? Center(
                    child: SpinKitDoubleBounce(
                    color: controller.colorPrimary.value,
                  ))
                : controller.courseConciergerieList.isEmpty
                    ? Center(
                        child: Text(
                        "Aucune Course",
                        style: TextStyle(
                            color: controller.colorPrimary.value,
                            fontFamily: GoogleFonts.nunito().fontFamily,
                            fontSize: 20),
                      ))
                    : ListView.separated(
                        separatorBuilder: (_, index) => const Divider(),
                        itemBuilder: (_, index) => Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) => Container(
                                    height: height / 2,
                                    width: width,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Les Taches',
                                          style: GoogleFonts.taprom(
                                            fontSize: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView.separated(
                                              itemCount: controller
                                                  .courseConciergerieList[index]
                                                  .tacheConcierges!
                                                  .length,
                                              separatorBuilder: (_, indexs) =>
                                                  const Divider(),
                                              itemBuilder:
                                                  (_, indexs) => ListTile(
                                                        title: SizedBox(
                                                            child: Text(
                                                          '${controller.courseConciergerieList[index].tacheConcierges![indexs].libelle}',
                                                          style: TextStyle(
                                                              fontFamily: GoogleFonts
                                                                      .nunito()
                                                                  .fontFamily),
                                                        )),
                                                        trailing: Column(
                                                          children: [
                                                            Text(
                                                              '${controller.courseConciergerieList[index].tacheConcierges![indexs].etat}',
                                                              style: TextStyle(
                                                                  color: controller
                                                                              .courseConciergerieList[
                                                                                  index]
                                                                              .tacheConcierges![
                                                                                  indexs]
                                                                              .etat ==
                                                                          'en_cours'
                                                                      ? ConstColors
                                                                          .alertInfo
                                                                      : controller.courseConciergerieList[index].tacheConcierges![indexs].etat ==
                                                                              'terminer'
                                                                          ? ConstColors
                                                                              .alertSuccess
                                                                          : ConstColors
                                                                              .alertWarnig,
                                                                  fontFamily: GoogleFonts
                                                                          .nunito()
                                                                      .fontFamily,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            ),
                                                            Expanded(
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          showModalBottomSheet(
                                                                              context: context,
                                                                              builder: (_) => Container(
                                                                                    height: height / 2,
                                                                                    width: width,
                                                                                    padding: const EdgeInsets.all(20),
                                                                                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Text(
                                                                                          'Description',
                                                                                          style: GoogleFonts.taprom(
                                                                                            fontSize: 30,
                                                                                            color: Colors.black,
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(child: SelectableText('${controller.courseConciergerieList[index].tacheConcierges![indexs].description}')),
                                                                                      ],
                                                                                    ),
                                                                                  ));
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Description',
                                                                          style: TextStyle(
                                                                              fontFamily: GoogleFonts.nunito().fontFamily,
                                                                              fontSize: 15,
                                                                              color: controller.colorPrimary.value),
                                                                        )))
                                                          ],
                                                        ),
                                                      )),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(
                                              'Fermer',
                                              style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.nunito()
                                                          .fontFamily,
                                                  fontSize: 20,
                                                  color: controller
                                                      .colorPrimary.value),
                                            ))
                                      ],
                                    )),
                              );
                            },
                            child: SizedBox(
                              height: height / 10,
                              width: width,
                              child: Row(
                                children: [
                                  Container(
                                    height: height / 10,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: controller
                                                    .courseConciergerieList[
                                                        index]
                                                    .etat ==
                                                'en_cours'
                                            ? ConstColors.alertInfo
                                            : controller
                                                        .courseConciergerieList[
                                                            index]
                                                        .etat ==
                                                    'terminer'
                                                ? ConstColors.alertSuccess
                                                : ConstColors.alertWarnig,
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10))),
                                    child: IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (_) => SizedBox(
                                                    height: height / 3,
                                                    width: width,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: width,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: controller
                                                                              .courseConciergerieList[
                                                                                  index]
                                                                              .etat ==
                                                                          'en_cours'
                                                                      ? ConstColors
                                                                          .alertInfo
                                                                      : controller.courseConciergerieList[index].etat ==
                                                                              'terminer'
                                                                          ? ConstColors
                                                                              .alertSuccess
                                                                          : ConstColors
                                                                              .alertWarnig,
                                                                  borderRadius: const BorderRadius
                                                                      .only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              10))),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Informations Coursier',
                                                                style:
                                                                    GoogleFonts
                                                                        .taprom(
                                                                  fontSize: 30,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  icon:
                                                                      const Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 30,
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                                'Reference: ${controller.courseConciergerieList[index].reference}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontFamily:
                                                                        GoogleFonts.nunito()
                                                                            .fontFamily)),
                                                            Text(
                                                                'Nom & Prenoms: ${controller.courseConciergerieList[index].cousierConcierges!.nom} ${controller.courseConciergerieList[index].cousierConcierges!.prenoms}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontFamily:
                                                                        GoogleFonts.nunito()
                                                                            .fontFamily)),
                                                            SizedBox(
                                                              child:
                                                                  OutlinedButton(
                                                                onPressed: () {
                                                                  launchUrl(
                                                                    Uri.parse(
                                                                        "tel:${controller.courseConciergerieList[index].cousierConcierges!.telephone1}"),
                                                                  );
                                                                },
                                                                child: Text(
                                                                  'Tel 1: ${controller.courseConciergerieList[index].cousierConcierges!.telephone1}',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          GoogleFonts.nunito()
                                                                              .fontFamily,
                                                                      color: controller
                                                                          .colorPrimary
                                                                          .value,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              child:
                                                                  OutlinedButton(
                                                                onPressed: () {
                                                                  launchUrl(
                                                                    Uri.parse(
                                                                        "tel:${controller.courseConciergerieList[index].cousierConcierges!.telephone2}"),
                                                                  );
                                                                },
                                                                child: Text(
                                                                  'Tel 2: ${controller.courseConciergerieList[index].cousierConcierges!.telephone2}',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          GoogleFonts.nunito()
                                                                              .fontFamily,
                                                                      color: controller
                                                                          .colorPrimary
                                                                          .value,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ))
                                                      ],
                                                    ),
                                                  ));
                                        },
                                        icon: const Icon(
                                          Icons.delivery_dining,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                height: height / 10,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '${controller.courseConciergerieList[index].reference}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily:
                                                          GoogleFonts.nunito()
                                                              .fontFamily,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Text(
                                                'Etat: ${controller.statusToString(controller.stringToStatus(controller.courseConciergerieList[index].etat.toString()))}',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily:
                                                      GoogleFonts.nunito()
                                                          .fontFamily,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "${controller.courseConciergerieList[index].createdAt!.day}/${controller.courseConciergerieList[index].createdAt!.month}/${controller.courseConciergerieList[index].createdAt!.year}",
                                          style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.nunito().fontFamily,
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        itemCount: controller.courseConciergerieList.length,
                      ))),
      ),
    );
  }
}
