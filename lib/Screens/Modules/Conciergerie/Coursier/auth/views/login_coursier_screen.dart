import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Coursier/auth/path_auth_coursier.dart';

// import '../../../../../../routes/path_route.dart';

class LoginCoursierScreen extends StatefulWidget {
  const LoginCoursierScreen({super.key});

  @override
  State<LoginCoursierScreen> createState() => _LoginCoursierScreenState();
}

class _LoginCoursierScreenState extends State<LoginCoursierScreen> {
  final LoginCoursierController controller = Get.put(LoginCoursierController());
  final ProfilCoursierController controllerProfilCoursier =
      Get.put(ProfilCoursierController());
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: controller.coursierConciergeModel.value != null
          ? Column(
              children: [
                Text(
                  'Connectez vous !!!',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: GoogleFonts.laila().fontFamily,
                      fontWeight: FontWeight.bold),
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
                        'Téléphone',
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
                          controller: controller.telephoneController.value,
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
                            hintText: '0123456789',
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
                  height: 10,
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
                        'Password',
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
                        child: Obx(() => TextFormField(
                              controller: controller.passwordController.value,
                              obscureText: controller.visiblePassword.value,
                              keyboardType: TextInputType.visiblePassword,
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
                                hintText: '********',
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
                const SizedBox(
                  height: 30,
                ),
                Obx(() => controller.coursierConciergeLoading.value == false
                    ? InkWell(
                        onTap: controller.coursierConciergeLoading.value == true
                            ? null
                            : () {
                                controller.loginCoursierConcierge();
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
                              'Connexion',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.nunito().fontFamily,
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
                  height: 30,
                ),
                TextButton(
                  onPressed: () {
                    Get.dialog(Obx(() => AlertDialog(
                          title: Text(
                            'Changer votre mot de passe',
                            style: TextStyle(
                                fontFamily: GoogleFonts.nunito().fontFamily,
                                fontSize: 20),
                          ),
                          content: controllerProfilCoursier.resetPassword.value
                              ? SpinKitDoubleBounce(
                                  color: controller.colorPrimary.value,
                                )
                              : Container(
                                  height: height / 4,
                                  child: Column(children: [
                                    TextField(
                                      controller: controllerProfilCoursier
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
                                    controllerProfilCoursier.showInputOtp.value
                                        ? TextField(
                                            controller: controllerProfilCoursier
                                                .newOtpController.value,
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
                                    controllerProfilCoursier
                                            .showInputNewPassword.value
                                        ? TextField(
                                            controller: controllerProfilCoursier
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
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      color: controller.colorPrimary.value),
                                )),
                            controllerProfilCoursier.showInputOtp.value
                                ? TextButton(
                                    onPressed: () async {
                                      await controllerProfilCoursier
                                          .verifyOtp();
                                    },
                                    child: Text(
                                      'Verifiez OTP',
                                      style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.nunito().fontFamily,
                                          color: controller.colorPrimary.value),
                                    ))
                                : controllerProfilCoursier
                                        .showInputNewPassword.value
                                    ? TextButton(
                                        onPressed: () async {
                                          await controllerProfilCoursier
                                              .changePassword();
                                        },
                                        child: Text(
                                          'Changer mot de passe',
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.nunito()
                                                  .fontFamily,
                                              color: controller
                                                  .colorPrimary.value),
                                        ))
                                    : TextButton(
                                        onPressed: () async {
                                          await controllerProfilCoursier
                                              .sendOtp();
                                        },
                                        child: Text(
                                          'Verifiez Numero',
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.nunito()
                                                  .fontFamily,
                                              color: controller
                                                  .colorPrimary.value),
                                        ),
                                      )
                          ],
                        )));
                  },
                  child: Text(
                    "Mot de passe oublié?",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: GoogleFonts.nunito().fontFamily,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                  ),
                )
              ],
            )
          : Text(
              "ME DIRE QUE VOUS N’AVEZ PAS D’ACCES A CETTE PAGE",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: GoogleFonts.nunito().fontFamily,
                  fontWeight: FontWeight.bold),
            ),
    );
  }
}
