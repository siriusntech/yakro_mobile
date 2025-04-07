import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Coursier/auth/path_auth_coursier.dart';
import 'package:jaime_yakro/Screens/Widgets/path_widget.dart';
import 'package:quickalert/models/quickalert_type.dart';

import '../../../../../../routes/path_route.dart';

class ProfilCoursierScreen extends GetView<ProfilCoursierController> {
  const ProfilCoursierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: controller.colorPrimary.value,
          centerTitle: true,
          // leading: IconButton(
          //     onPressed: () {
          //       Get.toNamed(AppRoutes.homeScreen);
          //     },
          //     icon: const Icon(
          //       Icons.chevron_left,
          //       color: Colors.white,
          //     )),

          title: Text(controller.title.value,
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.taprom().fontFamily)),
          actions: [
            IconButton(
                onPressed: () {
                  Get.dialog(Obx(() => AlertDialog(
                        title: Text(
                          'Changer votre mot de passe',
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 20),
                        ),
                        content: controller.resetPassword.value
                            ? SpinKitDoubleBounce(
                                color: controller.colorPrimary.value,
                              )
                            : Container(
                                height: height / 4,
                                child: Column(
                                    children: [
                                  TextField(
                                    controller: controller
                                        .verifTelephoneController.value,
                                    decoration: InputDecoration(
                                        label: Text(
                                          'Saisir un de vos numeros de telephone',
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.nunito()
                                                  .fontFamily),
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: controller
                                                    .colorPrimary.value))),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  controller.showInputOtp.value
                                      ? TextField(
                                          controller:
                                              controller.newOtpController.value,
                                          maxLength: 6,
                                          decoration: InputDecoration(
                                              label: Text(
                                                'Saisir votre code OTP',
                                                style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.nunito()
                                                            .fontFamily),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: controller
                                                          .colorPrimary
                                                          .value))),
                                        )
                                      : const Text(""),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  controller.showInputNewPassword.value
                                      ? TextField(
                                          controller: controller
                                              .newPasswordController.value,
                                          decoration: InputDecoration(
                                              label: Text(
                                                'Nouveau mot de passe',
                                                style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.nunito()
                                                            .fontFamily),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: controller
                                                          .colorPrimary
                                                          .value))),
                                        )
                                      : const Text(""),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ])),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Annuler',
                                style: TextStyle(
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    color: controller.colorPrimary.value),
                              )),
                          controller.showInputOtp.value
                              ? TextButton(
                                  onPressed: () async {
                                    await controller.verifyOtp();
                                  },
                                  child: Text(
                                    'Verifiez OTP',
                                    style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.nunito().fontFamily,
                                        color: controller.colorPrimary.value),
                                  ))
                              : controller.showInputNewPassword.value
                                  ? TextButton(
                                      onPressed: () async {
                                        await controller.changePassword();
                                      },
                                      child: Text(
                                        'Changer mot de passe',
                                        style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.nunito().fontFamily,
                                            color:
                                                controller.colorPrimary.value),
                                      ))
                                  : TextButton(
                                      onPressed: () async {
                                        await controller.sendOtp();
                                      },
                                      child: Text(
                                        'Verifiez Numero',
                                        style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.nunito().fontFamily,
                                            color:
                                                controller.colorPrimary.value),
                                      ),
                                    )
                        ],
                      )));
                },
                icon: const Icon(
                  Icons.password,
                  color: Colors.white,
                ))
          ],
        ),
        body: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Obx(() => Stack(
                    children: [
                      controller.coursierConciergeModel.value!.profileImg !=
                              null
                          ? Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(80)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${AppConfig.baseUrl}${controller.coursierConciergeModel.value!.profileImg}'),
                                    fit: BoxFit.fill,
                                  )),
                            )
                          : controller.imagesFile != null
                              ? Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(80)),
                                    image: DecorationImage(
                                      image: FileImage(File(
                                          controller.imagesFile!.value.path)),
                                      fit: BoxFit.fill,
                                    ),
                                  ))
                              : Container(
                                  height: 150,
                                  width: 150,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(80)),
                                      color: Colors.amber),
                                  child: const Icon(Icons.person,
                                      color: Colors.white, size: 100),
                                ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                              onPressed: () {
                                controller.addImages();
                              },
                              icon: Icon(
                                Icons.camera_alt,
                                color: controller.colorPrimary.value,
                                size: 40,
                              )))
                    ],
                  )),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Text('${controller.coursierConciergeModel.value!.profileImg}'),
                      // Text('${controller.imagesFile!.value}'),
                      Container(
                        // height: height/9,
                        width: width,
                        // color: controller.colorPrimary.value.withOpacity(0.5),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nom',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              // height:
                              //     height / 14,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: controller.colorPrimary.value
                                        .withOpacity(0.3),
                                    width: 1),
                              ),
                              child: TextFormField(
                                controller: controller.nomController.value,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: controller.colorPrimary.value),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(
                                        color: controller.colorPrimary.value),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: controller.colorPrimary.value),
                                  ),
                                  hintText: 'Konan',
                                  suffixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.amber,
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
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Prénoms',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              // height:
                              //     height / 14,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: controller.colorPrimary.value
                                        .withOpacity(0.3),
                                    width: 1),
                              ),
                              child: TextFormField(
                                controller: controller.prenomController.value,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: controller.colorPrimary.value),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(
                                        color: controller.colorPrimary.value),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: controller.colorPrimary.value),
                                  ),
                                  hintText: 'Arnaud Ndong',
                                  suffixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.amber,
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
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              // height:
                              //     height / 14,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: controller.colorPrimary.value
                                        .withOpacity(0.3),
                                    width: 1),
                              ),
                              child: TextFormField(
                                controller: controller.emailController.value,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: controller.colorPrimary.value),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(
                                        color: controller.colorPrimary.value),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: controller.colorPrimary.value),
                                  ),
                                  hintText: 'xyz@gmail.com',
                                  suffixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   // height: height/9,
                      //   width: width,
                      //   // color: controller.colorPrimary.value.withOpacity(0.5),
                      //   padding: const EdgeInsets.all(10),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         'Téléphone 1',
                      //         style: TextStyle(
                      //             fontSize: 20,
                      //             fontFamily: GoogleFonts.nunito().fontFamily,
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //       Container(
                      //         // height:
                      //         //     height / 14,
                      //         width: width,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(10),
                      //           border: Border.all(
                      //               color: controller.colorPrimary.value
                      //                   .withOpacity(0.3),
                      //               width: 1),
                      //         ),
                      //         child: TextFormField(
                      //           controller:
                      //               controller.telephoneController_1.value,
                      //           keyboardType: TextInputType.phone,
                      //           decoration: InputDecoration(
                      //             border: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(10),
                      //               borderSide: BorderSide(
                      //                   color: controller.colorPrimary.value),
                      //             ),
                      //             enabledBorder: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(0),
                      //               borderSide: BorderSide(
                      //                   color: controller.colorPrimary.value),
                      //             ),
                      //             focusedBorder: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(10),
                      //               borderSide: BorderSide(
                      //                   color: controller.colorPrimary.value),
                      //             ),
                      //             hintText: '07 00 00 00 00',
                      //             suffixIcon: const Icon(
                      //               Icons.phone,
                      //               color: Colors.amber,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        // height: height/9,
                        width: width,
                        // color: controller.colorPrimary.value.withOpacity(0.5),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Téléphone 2',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: GoogleFonts.nunito().fontFamily,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              // height:
                              //     height / 14,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: controller.colorPrimary.value
                                        .withOpacity(0.3),
                                    width: 1),
                              ),
                              child: TextFormField(
                                controller:
                                    controller.telephoneController_2.value,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: controller.colorPrimary.value),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(
                                        color: controller.colorPrimary.value),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: controller.colorPrimary.value),
                                  ),
                                  hintText: '07 00 00 00 00',
                                  suffixIcon: const Icon(
                                    Icons.phone,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() =>
                          controller.coursierConciergeLoading.value == false
                              ? InkWell(
                                  onTap: controller
                                              .coursierConciergeLoading.value ==
                                          true
                                      ? null
                                      : () {
                                          controller.updateProfilCoursier();
                                        },
                                  child: Container(
                                      height: 60,
                                      width: 300,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.amber,
                                      ),
                                      child: Text(
                                        'Modifiez',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily:
                                                GoogleFonts.nunito().fontFamily,
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
                                  ))),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          quickAlertDialog(context, QuickAlertType.confirm, color: controller.colorPrimary.value, message: "Voulez-vous vraiment vous deconnecter ?", title: "Deconnexion", onConfirmBtnTap: () async {controller.mainController.setCoursierConnected(false);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.homeScreen,
                                (route) => false,
                          );});
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: controller.colorPrimary.value,
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text(
                              //   'Deconnexion',
                              //   style: TextStyle(
                              //       color: controller.colorPrimary.value,
                              //       fontFamily: GoogleFonts.nunito().fontFamily,
                              //       fontSize: 20),
                              // ),
                              // const SizedBox(width: 20,),
                              Icon(
                                Icons.logout,
                                color:controller.colorPrimary.value,
                              )
                            ],
                          ))
                        )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
