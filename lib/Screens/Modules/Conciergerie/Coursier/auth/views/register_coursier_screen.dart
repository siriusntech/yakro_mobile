import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Coursier/auth/path_auth_coursier.dart';

class RegisterCoursierScreen extends GetView<RegisterCoursierController> {
  const RegisterCoursierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: controller.colorPrimary.value,
        centerTitle: true,
        title: Text(controller.title.value,
            style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.taprom().fontFamily)),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: height / 4,
                width: width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/coursier.jpg'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Obx(() => controller.coursierConciergeLoading.value
                ? SpinKitDoubleBounce(
                    color: controller.colorPrimary.value,
                    size: 30,
                  )
                : Expanded(
                    child: controller.coursierConciergeModel.value!.etatDoc ==
                            'non-uploader'
                        ? Column(
                            children: [
                              Text(
                                "Piéce d'Identité",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: GoogleFonts.laila().fontFamily,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ListView.separated(
                                    itemBuilder: (context, index) => Container(
                                      height: height / 3.5,
                                      width: width,
                                      decoration: BoxDecoration(
                                        // color: primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: const Color(0xFF696868)
                                                .withOpacity(0.5)),
                                      ),
                                      child: Row(children: [
                                        Container(
                                          // height: 80,
                                          width: 10,
                                          decoration: BoxDecoration(
                                              color:
                                                  controller.colorPrimary.value,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              )),
                                        ),
                                        Expanded(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      SizedBox(
                                                        // height: 10,
                                                        child: Text(
                                                          '${controller.document[index]}',
                                                          style: TextStyle(
                                                              fontFamily: GoogleFonts
                                                                      .manrope()
                                                                  .fontFamily,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      const Divider(
                                                        height: 30,
                                                        color:
                                                            Color(0xFF696868),
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            controller.addImages(
                                                                '${controller.document[index]}');
                                                          },
                                                          radius: 10,
                                                          child: Obx(() => controller
                                                                      .fileTypeDoc[controller
                                                                          .document[
                                                                      index]] ==
                                                                  null
                                                              ? Container(
                                                                  height: 150,
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .amber
                                                                          .withOpacity(
                                                                              0.3),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const Icon(
                                                                        Icons
                                                                            .cloud_upload_outlined,
                                                                        size:
                                                                            60,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      Text(
                                                                        'Ajouter un document',
                                                                        style: TextStyle(
                                                                            fontFamily: GoogleFonts.manrope()
                                                                                .fontFamily,
                                                                            fontSize:
                                                                                25,
                                                                            color:
                                                                                Colors.white),
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              : SizedBox(
                                                                  height: 150,
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  child: Image
                                                                      .file(
                                                                          File(
                                                                    controller
                                                                        .fileTypeDoc[
                                                                            controller.document[index]]
                                                                        .path!,
                                                                  )))))
                                                    ])))
                                      ]),
                                    ),
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 30,
                                      );
                                    },
                                    itemCount: controller.document.length,
                                  ),
                                ),
                              ),
                              Obx(() => controller.coursierConciergeDocUploading
                                          .value ==
                                      false
                                  ? InkWell(
                                      onTap: controller
                                                  .coursierConciergeDocUploading
                                                  .value ==
                                              true
                                          ? null
                                          : () {
                                              controller
                                                  .createCoursierConciergeDocument();
                                            },
                                      child: Container(
                                          height: 60,
                                          width: 300,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.amber,
                                          ),
                                          child: Text(
                                            'Valider',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: GoogleFonts.nunito()
                                                    .fontFamily,
                                                fontSize: 20),
                                          )),
                                    )
                                  : Container(
                                      height: 60,
                                      width: 300,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.amber,
                                      ),
                                      child: SpinKitDoubleBounce(
                                        color: controller.colorPrimary.value,
                                        size: 30,
                                      )))
                            ],
                          )
                        : controller.coursierConciergeModel.value!.etatDoc ==
                                    'uploader' &&
                                controller.coursierConciergeModel.value!.etat ==
                                    'en attente'
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/icon/horloge-de-sable.gif'),
                                            fit: BoxFit.cover)),
                                  ),
                                  Text(
                                    "Votre dossier est en attente de validation ...",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                    ),
                                  ),
                                ],
                              )
                            : controller.coursierConciergeModel.value!.etat ==
                                    'rejeté'
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/icon/dossier_rejected.png'),
                                                fit: BoxFit.cover)),
                                      ),
                                      Text(
                                        "Votre dossier a été rejeté",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily:
                                              GoogleFonts.nunito().fontFamily,
                                        ),
                                      ),
                                    ],
                                  )
                                : controller.coursierConciergeModel.value!
                                                .etat ==
                                            'validé' &&
                                        controller.coursierConciergeModel.value!
                                                .etatDoc ==
                                            'validé'
                                    ? const LoginCoursierScreen()
                                    : SingleChildScrollView(
                                        child:
                                            controller.coursierConciergeModel
                                                        .value !=
                                                    null
                                                ? Column(
                                                    children: [
                                                      Text(
                                                        'Enregistrez vous !!!',
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .laila()
                                                                    .fontFamily,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Container(
                                                        // height: height/9,
                                                        width: width,
                                                        // color: controller.colorPrimary.value.withOpacity(0.5),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Nom',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontFamily: GoogleFonts
                                                                          .nunito()
                                                                      .fontFamily,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Container(
                                                              // height:
                                                              //     height / 14,
                                                              width: width,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    color: controller
                                                                        .colorPrimary
                                                                        .value
                                                                        .withOpacity(
                                                                            0.3),
                                                                    width: 1),
                                                              ),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    controller
                                                                        .nomController
                                                                        .value,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: controller
                                                                            .colorPrimary
                                                                            .value),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(0),
                                                                    borderSide: BorderSide(
                                                                        color: controller
                                                                            .colorPrimary
                                                                            .value),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: controller
                                                                            .colorPrimary
                                                                            .value),
                                                                  ),
                                                                  hintText:
                                                                      'Konan',
                                                                  suffixIcon:
                                                                      const Icon(
                                                                    Icons
                                                                        .person,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        // height: height/9,
                                                        width: width,
                                                        // color: controller.colorPrimary.value.withOpacity(0.5),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Prénoms',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontFamily: GoogleFonts
                                                                          .nunito()
                                                                      .fontFamily,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Container(
                                                              // height:
                                                              //     height / 14,
                                                              width: width,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    color: controller
                                                                        .colorPrimary
                                                                        .value
                                                                        .withOpacity(
                                                                            0.3),
                                                                    width: 1),
                                                              ),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    controller
                                                                        .prenomController
                                                                        .value,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: controller
                                                                            .colorPrimary
                                                                            .value),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(0),
                                                                    borderSide: BorderSide(
                                                                        color: controller
                                                                            .colorPrimary
                                                                            .value),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: controller
                                                                            .colorPrimary
                                                                            .value),
                                                                  ),
                                                                  hintText:
                                                                      'Arnaud Ndong',
                                                                  suffixIcon:
                                                                      const Icon(
                                                                    Icons
                                                                        .person,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        // height: height/9,
                                                        width: width,
                                                        // color: controller.colorPrimary.value.withOpacity(0.5),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Email',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontFamily: GoogleFonts
                                                                          .nunito()
                                                                      .fontFamily,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Container(
                                                              // height:
                                                              //     height / 14,
                                                              width: width,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    color: controller
                                                                        .colorPrimary
                                                                        .value
                                                                        .withOpacity(
                                                                            0.3),
                                                                    width: 1),
                                                              ),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    controller
                                                                        .emailController
                                                                        .value,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .emailAddress,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: controller
                                                                            .colorPrimary
                                                                            .value),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(0),
                                                                    borderSide: BorderSide(
                                                                        color: controller
                                                                            .colorPrimary
                                                                            .value),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: controller
                                                                            .colorPrimary
                                                                            .value),
                                                                  ),
                                                                  hintText:
                                                                      'xyz@gmail.com',
                                                                  suffixIcon:
                                                                      const Icon(
                                                                    Icons.email,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        // height: height/9,
                                                        width: width,
                                                        // color: controller.colorPrimary.value.withOpacity(0.5),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Téléphone 1',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontFamily: GoogleFonts
                                                                          .nunito()
                                                                      .fontFamily,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Container(
                                                              // height:
                                                              //     height / 14,
                                                              width: width,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    color: controller
                                                                        .colorPrimary
                                                                        .value
                                                                        .withOpacity(
                                                                            0.3),
                                                                    width: 1),
                                                              ),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    controller
                                                                        .telephoneController_1
                                                                        .value,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .phone,
                                                                maxLength: 10,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: controller
                                                                            .colorPrimary
                                                                            .value),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(0),
                                                                    borderSide: BorderSide(
                                                                        color: controller
                                                                            .colorPrimary
                                                                            .value),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: controller
                                                                            .colorPrimary
                                                                            .value),
                                                                  ),
                                                                  hintText:
                                                                      '07 00 00 00 00',
                                                                  suffixIcon:
                                                                      const Icon(
                                                                    Icons.phone,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        // height: height/9,
                                                        width: width,
                                                        // color: controller.colorPrimary.value.withOpacity(0.5),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Téléphone 2',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontFamily: GoogleFonts
                                                                          .nunito()
                                                                      .fontFamily,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Container(
                                                              // height:
                                                              //     height / 14,
                                                              width: width,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    color: controller
                                                                        .colorPrimary
                                                                        .value
                                                                        .withOpacity(
                                                                            0.3),
                                                                    width: 1),
                                                              ),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    controller
                                                                        .telephoneController_2
                                                                        .value,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .phone,
                                                                    maxLength: 10,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: controller
                                                                            .colorPrimary
                                                                            .value),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(0),
                                                                    borderSide: BorderSide(
                                                                        color: controller
                                                                            .colorPrimary
                                                                            .value),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: controller
                                                                            .colorPrimary
                                                                            .value),
                                                                  ),
                                                                  hintText:
                                                                      '07 00 00 00 00',
                                                                  suffixIcon:
                                                                      const Icon(
                                                                    Icons.phone,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        // height: height/9,
                                                        width: width,
                                                        // color: controller.colorPrimary.value.withOpacity(0.5),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Password',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontFamily: GoogleFonts
                                                                          .nunito()
                                                                      .fontFamily,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Container(
                                                              // height:
                                                              //     height / 14,
                                                              width: width,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    color: controller
                                                                        .colorPrimary
                                                                        .value
                                                                        .withOpacity(
                                                                            0.3),
                                                                    width: 1),
                                                              ),
                                                              child: Obx(() =>
                                                                  TextFormField(
                                                                    controller:
                                                                        controller
                                                                            .passwordController
                                                                            .value,
                                                                    obscureText:
                                                                        controller
                                                                            .visiblePassword
                                                                            .value,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .visiblePassword,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        borderSide:
                                                                            BorderSide(color: controller.colorPrimary.value),
                                                                      ),
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(0),
                                                                        borderSide:
                                                                            BorderSide(color: controller.colorPrimary.value),
                                                                      ),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        borderSide:
                                                                            BorderSide(color: controller.colorPrimary.value),
                                                                      ),
                                                                      hintText:
                                                                          '********',
                                                                      suffixIcon: IconButton(
                                                                          onPressed: () {
                                                                            controller.changeVisibilityPassword();
                                                                          },
                                                                          icon: controller.visiblePassword.value
                                                                              ? const Icon(
                                                                                  Icons.visibility_off,
                                                                                  color: Colors.amber,
                                                                                )
                                                                              : const Icon(
                                                                                  Icons.visibility,
                                                                                  color: Colors.amber,
                                                                                )),
                                                                    ),
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Obx(() => controller
                                                                  .coursierConciergeLoading
                                                                  .value ==
                                                              false
                                                          ? InkWell(
                                                              onTap: controller
                                                                          .coursierConciergeLoading
                                                                          .value ==
                                                                      true
                                                                  ? null
                                                                  : () {
                                                                      controller
                                                                          .addCoursierConcierge();
                                                                    },
                                                              child: Container(
                                                                  height: 60,
                                                                  width: 300,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                  child: Text(
                                                                    'Validez',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontFamily:
                                                                            GoogleFonts.nunito()
                                                                                .fontFamily,
                                                                        fontSize:
                                                                            20),
                                                                  )),
                                                            )
                                                          : Container(
                                                              height: 60,
                                                              width: 300,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                              child:
                                                                  SpinKitDoubleBounce(
                                                                color: controller
                                                                    .colorPrimary
                                                                    .value,
                                                                size: 30,
                                                              )))
                                                    ],
                                                  )
                                                : Text(
                                                    "ME DIRE QUE VOUS N’AVEZ PAS D’ACCES A CETTE PAGE",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily:
                                                            GoogleFonts.nunito()
                                                                .fontFamily,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                      ),
                  ))
          ],
        ),
      ),
    );
  }
}
