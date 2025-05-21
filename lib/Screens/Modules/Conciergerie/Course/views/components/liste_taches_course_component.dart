import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Providers/models/path_mdels.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Course/path_course.dart';
import 'package:jaime_yakro/Screens/Widgets/path_widget.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:url_launcher/url_launcher.dart';

class ListeTachesCourseComponent extends StatefulWidget {
  const ListeTachesCourseComponent(
      {super.key,
      required this.tacheConcierges,
      required this.courseConciergeModel});
  final List<TacheConciergeModel> tacheConcierges;
  final CourseConciergeModel? courseConciergeModel;
  @override
  State<ListeTachesCourseComponent> createState() =>
      _ListeTachesCourseComponentState();
}

class _ListeTachesCourseComponentState
    extends State<ListeTachesCourseComponent> {
  final CourseConciergerieScreenController courseConciergerieScreenController =
      Get.put(CourseConciergerieScreenController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: const SizedBox(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: Row(
                children: [
                  Text('Tache en Cours'),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: ConstColors.alertInfo,
                  )
                ],
              ),
            ),
            SizedBox(
              child: Row(
                children: [
                  Text('Tache en Attente'),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: ConstColors.alertWarnig,
                  )
                ],
              ),
            ),
            SizedBox(
              child: Row(
                children: [
                  Text('Tache Terminé'),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: ConstColors.alertSuccess,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Les Taches',
                        style: GoogleFonts.taprom(
                          fontSize: 30,
                          color: Colors.black,
                        )),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    titlePadding: const EdgeInsets.all(0),
                                    contentPadding: const EdgeInsets.all(10),
                                    buttonPadding: const EdgeInsets.all(0),
                                    title: Container(
                                      // height: height / 12,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        color:
                                            widget.courseConciergeModel!.etat ==
                                                    'en_cours'
                                                ? ConstColors.alertInfo
                                                : widget.courseConciergeModel!
                                                            .etat ==
                                                        'terminer'
                                                    ? ConstColors.alertSuccess
                                                    : ConstColors.alertWarnig,
                                      ),
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Informations",
                                            style: TextStyle(
                                                fontFamily: GoogleFonts.nunito()
                                                    .fontFamily,
                                                fontSize: 25,
                                                color: Colors.white),
                                          ),
                                          Container(
                                            width: width,
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '${widget.courseConciergeModel!.reference}',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.nunito()
                                                              .fontFamily,
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    content: SizedBox(
                                      height: height / 5,
                                      width: width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Nom & Prenom: ',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.nunito()
                                                              .fontFamily,
                                                      fontSize: 18),
                                                ),
                                                SizedBox(
                                                  child: Text(
                                                    '${widget.courseConciergeModel!.userConcierge!.nom} ${widget.courseConciergeModel!.userConcierge!.prenoms}',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            GoogleFonts.nunito()
                                                                .fontFamily,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            child: OutlinedButton(
                                              onPressed: () {
                                                launchUrl(
                                                  Uri.parse(
                                                      "tel:${widget.courseConciergeModel!.userConcierge!.telephone}"),
                                                );
                                              },
                                              child: Text(
                                                'Tel: ${widget.courseConciergeModel!.userConcierge!.telephone}',
                                                style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.nunito()
                                                            .fontFamily,
                                                    color:
                                                        courseConciergerieScreenController
                                                            .colorPrimary.value,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: Text(
                                              'Localisation: ${widget.courseConciergeModel!.userConcierge!.quartier}',
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.nunito()
                                                          .fontFamily,
                                                  fontSize: 20),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text(
                                            'Fermer',
                                            style: TextStyle(
                                                fontFamily: GoogleFonts.nunito()
                                                    .fontFamily,
                                                color:
                                                    courseConciergerieScreenController
                                                        .colorPrimary.value),
                                          ))
                                    ],
                                  ));
                        },
                        icon: const Icon(
                          Icons.person,
                          color: Color(0xff0d5ccc),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                    itemCount: widget.tacheConcierges.length,
                    separatorBuilder: (_, indexs) => const Divider(),
                    itemBuilder: (_, indexs) => InkWell(
                          child: Card(
                            child: Row(
                              children: [
                                Container(
                                  height: height / 7,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      color:
                                          widget.tacheConcierges[indexs].etat ==
                                                  'en_cours'
                                              ? ConstColors.alertInfo
                                              : widget.tacheConcierges[indexs]
                                                          .etat ==
                                                      'terminer'
                                                  ? ConstColors.alertSuccess
                                                  : ConstColors.alertWarnig,
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10))),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "${widget.tacheConcierges[indexs].libelle}",
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily),
                                )),
                                SizedBox(
                                  // width: 100,
                                  child: Column(
                                    children: [
                                      DropdownMenuItem(
                                        child: Obx(
                                          () => DropdownButton<Status>(
                                            value:
                                                courseConciergerieScreenController
                                                    .selectedStatus!.value,
                                            hint: const Text('Select Status'),
                                            items: Status.values.map((status) {
                                              return DropdownMenuItem<Status>(
                                                value:
                                                    status, //  courseConciergerieScreenController.stringToStatus(courseConciergerieScreenController.courseConciergerieListEnAttenteByCoursier[index].tacheConcierges![indexs].etat.toString()),
                                                child: Text(
                                                    courseConciergerieScreenController
                                                        .statusToString(
                                                            status)),
                                              );
                                            }).toList(),
                                            onChanged: (Status? newValue) {
                                              // print(newValue);
                                              if (newValue != null) {
                                                quickAlertDialog(context,
                                                    QuickAlertType.confirm,
                                                    color:
                                                        ConstColors.alertInfo,
                                                    title:
                                                        'Confirmez Cette Modification',
                                                    message:
                                                        'Cette Modification sera appliquée',
                                                    onConfirmBtnTap: () {
                                                  // courseConciergerieScreenController.selectedStatus!.value = newValue;
                                                  Map<String, dynamic>
                                                      dataTache = {
                                                    'id': widget
                                                        .tacheConcierges[indexs]
                                                        .id,
                                                    'etat':
                                                        courseConciergerieScreenController
                                                            .statusToStringPut(
                                                                newValue)
                                                  };
                                                  courseConciergerieScreenController
                                                      .updateTacheEtatCourseConciergerie(
                                                          dataTache, context);
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          courseConciergerieScreenController
                                              .descriptionController
                                              .value
                                              .text = widget
                                                      .tacheConcierges[indexs]
                                                      .description ==
                                                  null
                                              ? ''
                                              : widget.tacheConcierges[indexs]
                                                  .description!;
                                          showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                  title: Text(
                                                    'Ajouter une desctiption',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            GoogleFonts.nunito()
                                                                .fontFamily,
                                                        fontSize: 20),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text(
                                                          'Annuler',
                                                          style: TextStyle(
                                                              fontFamily: GoogleFonts
                                                                      .nunito()
                                                                  .fontFamily,
                                                              color: Colors.red,
                                                              fontSize: 20),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          Map<String, dynamic>
                                                              dataTache = {
                                                            'id': widget
                                                                .tacheConcierges[
                                                                    indexs]
                                                                .id,
                                                            'description':
                                                                courseConciergerieScreenController
                                                                    .descriptionController
                                                                    .value
                                                                    .text
                                                          };
                                                          courseConciergerieScreenController
                                                              .addDescriptionTacheCourseConciergerie(
                                                                  dataTache,
                                                                  context);
                                                        },
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStateProperty
                                                                    .all(ConstColors
                                                                        .alertSuccess)),
                                                        child: Text(
                                                          'Valider',
                                                          style: TextStyle(
                                                              fontFamily: GoogleFonts
                                                                      .nunito()
                                                                  .fontFamily,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        )),
                                                  ],
                                                  content: SizedBox(
                                                    height: height / 4,
                                                    width: width,
                                                    child: TextFormField(
                                                      controller:
                                                          courseConciergerieScreenController
                                                              .descriptionController
                                                              .value,
                                                      maxLines: 10,
                                                      minLines: 1,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                              color: courseConciergerieScreenController
                                                                  .colorPrimary
                                                                  .value),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                          borderSide: BorderSide(
                                                              color: courseConciergerieScreenController
                                                                  .colorPrimary
                                                                  .value),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                              color: courseConciergerieScreenController
                                                                  .colorPrimary
                                                                  .value),
                                                        ),
                                                        hintText: 'Description',
                                                      ),
                                                    ),
                                                  )));
                                        },
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                            Color(0xff0d5ccc),
                                          ),
                                        ),
                                        child: Text(
                                          'Description',
                                          style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.nunito().fontFamily,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
              ),
            ],
          )),
    );
  }
}
