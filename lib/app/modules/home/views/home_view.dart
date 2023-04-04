import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_cocody/app/Utils/app_routes.dart';
import 'package:jaime_cocody/app/Utils/default_image.dart';
import 'package:jaime_cocody/app/data/repository/main_services.dart';
import 'package:jaime_cocody/app/widgets/notification_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_constantes.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/menu_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../actualite/controllers/actualite_controller.dart';
import '../../alerte/controllers/alerte_controller.dart';
import '../../annuaire/controllers/annuaire_controller.dart';
import '../../commerce/controllers/commerce_controller.dart';
import '../../diffusion/controllers/diffusion_controller.dart';
import '../../historique/controllers/historique_controller.dart';
import '../../job/controllers/job_controller.dart';
import '../../pharmacie/controllers/pharmacie_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

  // final mainCtrl = Get.find<MainController>();
  final MainController mainCtrl = Get.put(MainController());
  final ActualiteController actualite_ctrl = Get.put(ActualiteController());
  final CommerceController commerce_ctrl = Get.put(CommerceController());
  final JobController job_ctrl = Get.put(JobController());
  final PharmacieController pharm_ctrl = Get.put(PharmacieController());
  final AlerteController alerte_ctrl = Get.put(AlerteController());
  final AnnuaireController annuaire_ctrl = Get.put(AnnuaireController());
  final HistoriqueController culture_ctrl = Get.put(HistoriqueController());
  final DiffusionController bon_plan_ctrl = Get.put(DiffusionController());

  Loading(){
    return Container(
      color: Colors.white,
      child: LoadingWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Obx(() => mainCtrl.isSettingProcessing.value == true ? Loading() :
        Scaffold(
        backgroundColor: mainColor,
        resizeToAvoidBottomInset: false,
        appBar:  AppBar(
          backgroundColor: Colors.white,
          // automaticallyImplyLeading: false,
          elevation: 0.0,
          // leading: NotificationWidget(icon: Icons.home,
          //   action: (){
          //     controller.refreshData();
          //   },
          // ),
          actions: [
            NotificationWidget(icon: Icons.home,
              color: mainCtrl.menuColor,
              action: () async{
                 await controller.refreshHome();
              },
            ),
            NotificationWidget(icon: Icons.call,
              color: mainCtrl.menuColor,
              action: (){
                Get.toNamed(AppRoutes.NOUSCONTACTEZ);
              },
            ),
            NotificationWidget(icon: Icons.help,
              color: mainCtrl.menuColor,
              action: (){
                Get.toNamed(AppRoutes.APROPOS);
              },
            ),
            NotificationWidget(icon: Icons.share,
              color: mainCtrl.menuColor,
              action: (){
                controller.ShareAppLink();
              },
            )
          ],
        ),
        body: Container(
          // height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(DefaultImage.HOME_BG),
                  fit: BoxFit.cover
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 1, right: 1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              flex: 12,
                              child: Container(
                                height: 115,
                                width: 115,
                                child: Image(
                                  image: AssetImage(mainCtrl.app_logo.value),
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.contain,
                                ),
                              )
                          ),
                          // SizedBox(height: 3,),
                          Flexible(
                              flex: 8,
                              child: Center(
                                child: Column(
                                  children: [
                                    TextWidget(text: "Bienvenue sur l'application mobile de la commune.",
                                      fontSize: 14, fontWeight: FontWeight.bold,alignement: TextAlign.center,
                                    ),
                                    TextWidget(text: "Connaitre et participer au developpement de votre commune.",
                                      color: Colors.blueGrey,fontSize: 14, fontWeight: FontWeight.w600,alignement: TextAlign.center, maxLine: 5,
                                    )
                                  ],
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Visibility(
                    visible: mainCtrl.isCocody.value == true && controller.miseAJourModel.value.id != null && controller.miseAJourModel.value.etat == 0 && controller.showUpdateWidget.value == true,
                    child: Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Card(
                        elevation: 30,
                        child: ListTile(
                          leading: Icon(Icons.system_update_alt_rounded, color: mainColor, size: 30,),
                          trailing: IconButton(
                              onPressed: (){
                                controller.closeUpdateWidget();
                              },
                              icon: Icon(Icons.close)
                          ),
                          title: TextWidget(text: controller.miseAJourModel.value.titre, fontWeight: FontWeight.bold,),
                          subtitle: TextWidget(text: controller.miseAJourModel.value.description, fontSize: 15, fontWeight: FontWeight.w600,),
                          onTap: () {
                            // print(controller.miseAJourModel.value.lien);
                            var link = controller.miseAJourModel.value.lien != "" ? controller.miseAJourModel.value.lien : "https://play.google.com/store/apps/details?id=com.siriusntech.jaime_cocody" ;
                            launchUrl(Uri.parse(link!));
                            // await controller.makeUpdate();
                            controller.makeUpdate();
                          },
                        ),
                      ),
                    )
                ),
                Expanded(
                  flex: 3,
                  child: controller.isDataRefreshing == true ? LoadingWidget() : ListView(
                    padding: EdgeInsets.only(bottom: 20),
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Flexible(
                      //         child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                      //           title: 'Matchs',icon: AppIcons.calendrier_foot, enabled: true,
                      //           itemCount: 0,
                      //           action: () async{
                      //             // Get.toNamed(AppRoutes.ACTUALITE);
                      //             // if(await MainServices.checkUserIsExclude() == false){
                      //             //   controller.addVisiteCount('actualite');
                      //             // }
                      //           },
                      //         )
                      //     ),
                      //     Flexible(
                      //         child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                      //           title: 'Sites Touristique',icon: AppIcons.site_touristique, enabled: true,
                      //           itemCount: 0,
                      //           action: () async{
                      //             // Get.toNamed(AppRoutes.ACTUALITE);
                      //             // if(await MainServices.checkUserIsExclude() == false){
                      //             //   controller.addVisiteCount('actualite');
                      //             // }
                      //           },
                      //         )
                      //     )
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Flexible(
                          //     child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                          //       title: 'Ambassades',icon: AppIcons.ambassade, enabled: true,
                          //       itemCount: 0,
                          //       action: () async{
                          //         // Get.toNamed(AppRoutes.ACTUALITE);
                          //         // if(await MainServices.checkUserIsExclude() == false){
                          //         //   controller.addVisiteCount('actualite');
                          //         // }
                          //       },
                          //     )
                          // ),
                          Flexible(
                              child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                                color: mainCtrl.menuColor,
                                title: 'Actualités',icon: MENU_ACTUALITE, enabled: true,
                                itemCount: controller.selectedItemsCounts.value.un_read_actualite_count,
                                action: () async{
                                  Get.toNamed(AppRoutes.ACTUALITE);
                                  actualite_ctrl.refreshData();
                                  if(await MainServices.checkUserIsExclude() == false){
                                    controller.addVisiteCount('actualite');
                                  }
                                },
                              )
                          ),
                          Flexible(
                              child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                                  color: mainCtrl.menuColor,
                                  title: 'Commerces et autres',icon: MENU_COMMERCE,
                                  enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_commerce_count,
                                  action: () async{
                                    // controller.addCommerceVisiteCount();
                                    Get.toNamed(AppRoutes.COMMERCE);
                                    commerce_ctrl.refreshData();
                                    if(await MainServices.checkUserIsExclude() == false){
                                      controller.addVisiteCount('commerce');
                                    }
                                  }
                              )
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                                  color: mainCtrl.menuColor,
                                  title: 'Jobs / Annonces',icon: MENU_JOB,
                                  enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_job_count,
                                  action: () async{
                                    // controller.addJobVisiteCount();
                                    Get.toNamed(AppRoutes.JOB);
                                    job_ctrl.refreshData();
                                    if(await MainServices.checkUserIsExclude() == false){
                                      controller.addVisiteCount('job');
                                    }
                                  }
                              )
                          ),
                          Flexible(
                              child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                                color: mainCtrl.menuColor,
                                title: 'Culture',icon: MENU_HISTORIQUE,
                                enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_sujet_count,
                                action: () async{
                                  // controller.addHistoriqueVisiteCount();
                                  Get.toNamed(AppRoutes.HISTORIQUE);
                                  culture_ctrl.refreshData();
                                  if(await MainServices.checkUserIsExclude() == false){
                                    controller.addVisiteCount('culture');
                                  }
                                },
                              )
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                                  color: mainCtrl.menuColor,
                                  title: 'Bons plans', icon: MENU_BON_PLAN,
                                  enabled: true, itemCount: controller.unReadDiffusionCount.value,
                                  action: () async{
                                    // controller.addDiffusionVisiteCount();
                                    Get.toNamed(AppRoutes.DIFFUSION);
                                    bon_plan_ctrl.refreshData();
                                    if(await MainServices.checkUserIsExclude() == false){
                                      controller.addVisiteCount('bon_plan');
                                    }
                                  }
                              )
                          ),
                          Flexible(
                              child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                                  color: mainCtrl.menuColor,
                                  title: 'Signaler un incident',icon: MENU_ALERTE,
                                  enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_alerte_count,
                                  action: () async{
                                    // controller.addAlerteVisiteCount();
                                    Get.toNamed(AppRoutes.ALERTE);
                                    alerte_ctrl.refreshData();
                                    if(await MainServices.checkUserIsExclude() == false){
                                      controller.addVisiteCount('alerte');
                                    }
                                  }
                              )
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                                  color: mainCtrl.menuColor,
                                  title: 'Numéros utiles', icon: MENU_INFORMATION,
                                  enabled: true,
                                  action: () async{
                                    // controller.addAnnuaireVisiteCount();
                                    Get.toNamed(AppRoutes.ANNUAIRE);
                                    annuaire_ctrl.refreshData();
                                    if(await MainServices.checkUserIsExclude() == false){
                                      controller.addVisiteCount('annuaire');
                                    }
                                  }
                              )
                          ),
                          Flexible(
                              child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                                  color: mainCtrl.menuColor,
                                  title: 'Pharmacie de garde', icon: MENU_PHARMACIE,
                                  enabled: true,
                                  action: () async{
                                    // controller.addPharmacieVisiteCount();
                                    Get.toNamed(AppRoutes.PHARMACIE);
                                    pharm_ctrl.refreshData();
                                    if(await MainServices.checkUserIsExclude() == false){
                                      controller.addVisiteCount('pharmacie');
                                    }
                                  }
                              )
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //
                      //   ],
                      // ),
                    ],
                  ),
                )
              ],
            )
        ),
        drawer: MainDrawer()
    ));

  }

  // MENU DRAWER
  MainDrawer(){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image(
              image: AssetImage(mainCtrl.app_logo.value),
              alignment: Alignment.topCenter,
              fit: BoxFit.contain,
            ),
            decoration: BoxDecoration(
              color: Colors.white70,
            ),
          ),
          ListTile(
            title: TextWidget(
              text: mainCtrl.isCocody.value == true ? "Mon Plateau" : "J'aime Cocody",
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: mainCtrl.isCocody.value== true ? Colors.deepOrange : Colors.lightBlue,
            ),
            tileColor: Get.currentRoute == '/home' ? Colors.grey[300] : null,
            onTap: () async{
              await mainCtrl.isCocody.value == true ? mainCtrl.setToPlateau() : mainCtrl.setToCocody();
              // Get.back();
              // Get.offNamed('/home');
            },
          ),
          Divider(),
          ListTile(
            title: TextWidget(
              text: "Yamoussoukro", fontSize: 15,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
            // tileColor: Get.currentRoute == '/home' ? Colors.grey[300] : null,
            onTap: () {
              // Get.back();
              // Get.offNamed('/home');
            },
          ),
          ListTile(
            title: TextWidget(
              text: "San-Pédro", fontSize: 15,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
            // tileColor: Get.currentRoute == '/home' ? Colors.grey[300] : null,
            onTap: () {
              // Get.back();
              // Get.offNamed('/home');
            },
          ),
          ListTile(
            title: TextWidget(
              text: "Bouaké", fontSize: 15,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
            // tileColor: Get.currentRoute == '/home' ? Colors.grey[300] : null,
            onTap: () {
              // Get.back();
              // Get.offNamed('/home');
            },
          ),
          ListTile(
            title: TextWidget(
              text: "Korhogo", fontSize: 15,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
            // tileColor: Get.currentRoute == '/home' ? Colors.grey[300] : null,
            onTap: () {
              // Get.back();
              // Get.offNamed('/home');
            },
          ),
        ],
      ),
    );
  }


  // WIDGET MENU
  MenuViewDeux(){
    return ListView(
      padding: EdgeInsets.only(bottom: 20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Flexible(
            //     child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
            //       title: 'Agenda',icon: MENU_AGENDA, page: AppRoutes.AGENDA,
            //     )
            // ),
            Flexible(
                child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                    title: 'Actualités',icon: MENU_ACTUALITE, enabled: true,
                    itemCount: controller.selectedItemsCounts.value.un_read_actualite_count,
                    action: (){
                      Get.toNamed(AppRoutes.ACTUALITE);
                    },
                )
            ),
            Flexible(
                child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                  title: 'Commerces et autres',icon: MENU_COMMERCE,
                  enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_commerce_count,
                    action: (){
                      Get.toNamed(AppRoutes.COMMERCE);
                    }
                )
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Flexible(
            //     child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
            //         title: 'Discussions',icon: MENU_DISCUSSION, page: AppRoutes.DISCUSSION,
            //     )
            // ),
            Flexible(
                child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                    title: 'Culture',icon: MENU_HISTORIQUE,
                    enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_sujet_count,
                    action: (){
                      Get.toNamed(AppRoutes.HISTORIQUE);
                    },
                )
            ),
            Flexible(
                child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                  title: 'Signaler un incident',icon: MENU_ALERTE,
                  enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_alerte_count,
                    action: (){
                      Get.toNamed(AppRoutes.ALERTE);
                    }
                )
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                  title: 'Bons plans', icon: MENU_NOTIFICATION,
                  enabled: true, itemCount: controller.unReadDiffusionCount.value,
                    action: (){
                      Get.toNamed(AppRoutes.DIFFUSION);
                    }
                )
            ),
            Flexible(
                child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                  title: 'Numéros utiles', icon: MENU_INFORMATION,
                  enabled: true,
                    action: (){
                      Get.toNamed(AppRoutes.ANNUAIRE);
                    }
                )
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                  title: 'Discussions',icon: MENU_DISCUSSION,
                  enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_discussion_count,
                    action: (){
                      Get.toNamed(AppRoutes.DISCUSSION);
                    }
                )
            ),
            Flexible(
                child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                  title: 'Pharmacie de garde', icon: MENU_PHARMACIE,
                  enabled: true,
                    action: (){
                      Get.toNamed(AppRoutes.PHARMACIE);
                    }
                )
            ),
          ],
        ),
      ],
    );
  }
}

// MENU SIDEBAR
// class MainDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           DrawerHeader(
//             child: Image(
//               image: AssetImage(LOGO),
//               alignment: Alignment.topCenter,
//               fit: BoxFit.contain,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white70,
//             ),
//           ),
//           ListTile(
//             title: TextWidget(
//               text: "Mon Plateau", fontSize: 15,
//               fontWeight: FontWeight.bold,
//               fontStyle: FontStyle.italic,
//               color: Colors.deepOrange,
//             ),
//             // tileColor: Get.currentRoute == '/home' ? Colors.grey[300] : null,
//             onTap: () async{
//               // Get.back();
//               // Get.offNamed('/home');
//             },
//           ),
//           Divider(),
//           // ListTile(
//           //   title: TextWidget(
//           //     text: "Cocan", fontSize: 15,
//           //     fontWeight: FontWeight.bold,
//           //     fontStyle: FontStyle.italic,
//           //     color: Colors.deepOrange,
//           //   ),
//           //   // tileColor: Get.currentRoute == '/home' ? Colors.grey[300] : null,
//           //   onTap: () {
//           //     // Get.back();
//           //     // Get.offNamed('/home');
//           //   },
//           // ),
//         ],
//       ),
//     );
//   }
// }