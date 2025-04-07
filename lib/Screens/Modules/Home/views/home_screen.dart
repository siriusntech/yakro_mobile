import 'package:flutter/material.dart';
// import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Helpers/helpers.dart';
import 'package:jaime_yakro/Screens/Widgets/path_widget.dart';
import 'package:jaime_yakro/routes/path_route.dart';
import 'package:quickalert/models/quickalert_type.dart';
// import 'package:jaime_yakro/routes/path_route.dart';
import 'package:share_plus/share_plus.dart';
import '../path_home.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
//     print("======= HOME SCREEN CONNEXION =======");
// print(controller.coursierConciergerieController.connectedCoursierConcierge());
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading:
        IconButton(
          icon: const Icon(Icons.menu, color: ConstColors.vertColorFonce,),
          onPressed: (){
            // Get.toNamed(AppRoutes.reductionScreen);
            _scaffoldKey.currentState!.openDrawer();
          },),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/banner.png'), // Change this to your image
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text('Yakro',
            style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.taprom().fontFamily)),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return [
                // const PopupMenuItem<String>(
                //   value: 'Sondage',
                //   child: InkWell(
                //       child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Icon(Icons.keyboard_voice),
                //       Text('Sondage'),
                //     ],
                //   )),
                // ),
                PopupMenuItem<String>(
                  value: 'Contactez Nous',
                  child: InkWell(
                      onTap: () {
                        Helpers.launchInAppBrowser(Uri(
                          scheme: "https",
                          host: 'wa.me',
                          path: "+2250140355555/",
                        ));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.phone),
                          Text('Contactez Nous'),
                        ],
                      )),
                ),
                // (controller.coursierConciergerieController
                //                 .coursierConciergeModel.value!.nom !=
                //             null &&
                //         controller.coursierConciergerieController
                //                 .connectedCoursierConcierge() ==
                //             true)
                //     ? PopupMenuItem<String>(
                //         value: 'Profil Coursier',
                //         child: Obx(()=>  InkWell(
                //             onTap:controller.mainController.conciergeEnable.value==true?  () {
                //               Get.toNamed(AppRoutes.homeCoursierScreen);
                //             }: (){
                //               quickAlertDialog(context, QuickAlertType.info, color: const Color(0xff434242), message: 'Bientôt Disponible', title: 'Conciergerie');
                //             },
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 const Icon(Icons.person),
                //                 Text(
                //                   'Profil Coursier',
                //                   style: TextStyle(
                //                       color: Colors.black,
                //                       fontFamily:
                //                           GoogleFonts.nunito().fontFamily),
                //                 ),
                //               ],
                //             )),
                //       ))
                //     : PopupMenuItem<String>(
                //         value: 'Devenir Coursier',
                //         child:Obx(()=> InkWell(
                //             onTap:controller.mainController.conciergeEnable.value==true? () {
                //               Get.toNamed(AppRoutes.registerCoursierScreen);
                //             }: (){
                //               quickAlertDialog(context, QuickAlertType.info, color: const Color(0xff434242), message: 'Bientôt Disponible', title: 'Conciergerie');
                //             },
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 const Icon(Icons.person),
                //                 Text(
                //                   'Devenir Coursier',
                //                   style: TextStyle(
                //                       color: Colors.black,
                //                       fontFamily:
                //                           GoogleFonts.nunito().fontFamily),
                //                 ),
                //               ],
                //             )),
                //       )),
                PopupMenuItem<String>(
                  value: 'Partagez',
                  child: InkWell(
                      onTap: () {
                        String test =
                            "Voici le lien de l'appli J'aime Yakro: https://play.google.com/store/apps/details?id=com.siriusntech.jaime_yakro";

                        Share.share(test);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.share),
                          Text("Partagez l'appli"),
                        ],
                      )),
                ),
              ];
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: ConstColors.vertColorFonce,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Profil',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.taprom().fontFamily),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                        children: [
                          ListTile(
                              leading: const Icon(Icons.qr_code_scanner_rounded),
                              title: Text(
                                'Scanner le QR Code',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: GoogleFonts.nunito().fontFamily),
                              ),
                              onTap: () {
                                Get.toNamed(AppRoutes.scannerScreen);
                              }),
                          const Divider(height: 1,),
                          ListTile(
                              leading: const Icon(Icons.list_alt_rounded),
                              title: Text(
                                'Historique des réservations',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: GoogleFonts.nunito().fontFamily),
                              ),
                              onTap: () {
                                Get.toNamed(AppRoutes.reductionScreen);
                              }),
                          const Divider(height: 1,),
                          //Devenir Coursier
                          Obx(()=> (controller.coursierConciergerieController
                              .coursierConciergeModel.value!.nom !=
                              null &&
                              controller.coursierConciergerieController
                                  .connectedCoursierConcierge() ==
                                  true)
                              ? ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(
                              'Profil Coursier',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.nunito().fontFamily),
                            ),
                            onTap:
                            // controller.mainController.conciergeEnable.value==true?
                                () {
                              Get.toNamed(AppRoutes.homeCoursierScreen);
                            }
                            // : (){
                            //   quickAlertDialog(context, QuickAlertType.info, color: const Color(0xff434242), message: 'Bientôt Disponible', title: 'Conciergerie');
                            // },
                          ): ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(
                              'Devenir Coursier',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.nunito().fontFamily),
                            ),
                            onTap:
                            // controller.mainController.conciergeEnable.value==true?
                                () {
                              Get.toNamed(AppRoutes.registerCoursierScreen);
                            }
                            // : (){
                            //   quickAlertDialog(context, QuickAlertType.info, color: const Color(0xff434242), message: 'Bientôt Disponible', title: 'Conciergerie');
                            // }
                            ,)),

                        ]
                    ),
                  )
                ]
            )
        ),
      ),
      body: const HomeComponent(),
    );
  }
}
