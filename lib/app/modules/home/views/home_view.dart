import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_cocody/app/Utils/app_routes.dart';
import 'package:jaime_cocody/app/Utils/default_image.dart';
import 'package:jaime_cocody/app/data/repository/main_services.dart';
import 'package:jaime_cocody/app/widgets/notification_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_constantes.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/menu_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: mainColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: NotificationWidget(icon: Icons.home,
          action: (){
            controller.refreshData();
          },
        ),
        actions: [
          NotificationWidget(icon: Icons.call,
            action: (){
              Get.toNamed(AppRoutes.NOUSCONTACTEZ);
            },
          ),
          NotificationWidget(icon: Icons.help,
            action: (){
              Get.toNamed(AppRoutes.APROPOS);
            },
          ),
          NotificationWidget(icon: Icons.share,
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
        child: Obx(() => Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
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
                              image: AssetImage(LOGO),
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
              visible: controller.miseAJourModel.value.id != null && controller.miseAJourModel.value.etat == 0 && controller.showUpdateWidget.value == true,
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
                  onTap: () async{
                    print(controller.miseAJourModel.value.lien);
                    var link = controller.miseAJourModel.value.lien != "" ? controller.miseAJourModel.value.lien : "https://play.google.com/store/apps/details?id=com.siriusntech.jaime_cocody" ;
                    launchUrl(Uri.parse(link!));
                    await controller.makeUpdate();
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
                            action: () async{
                              Get.toNamed(AppRoutes.ACTUALITE);
                              if(await MainServices.checkUserIsExclude() == false){
                                controller.addVisiteCount('actualite');
                              }
                            },
                          )
                      ),
                      Flexible(
                          child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                              title: 'Commerces et autres',icon: MENU_COMMERCE,
                              enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_commerce_count,
                              action: () async{
                                // controller.addCommerceVisiteCount();
                                Get.toNamed(AppRoutes.COMMERCE);
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
                      // Flexible(
                      //     child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                      //         title: 'Discussions',icon: MENU_DISCUSSION, page: AppRoutes.DISCUSSION,
                      //     )
                      // ),
                      Flexible(
                          child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                            title: 'Culture',icon: MENU_HISTORIQUE,
                            enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_sujet_count,
                            action: () async{
                              // controller.addHistoriqueVisiteCount();
                              Get.toNamed(AppRoutes.HISTORIQUE);
                              if(await MainServices.checkUserIsExclude() == false){
                                controller.addVisiteCount('culture');
                              }
                            },
                          )
                      ),
                      Flexible(
                          child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                              title: 'Signaler un incident',icon: MENU_ALERTE,
                              enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_alerte_count,
                              action: () async{
                                // controller.addAlerteVisiteCount();
                                Get.toNamed(AppRoutes.ALERTE);
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
                              title: 'Bons plans', icon: MENU_BON_PLAN,
                              enabled: true, itemCount: controller.unReadDiffusionCount.value,
                              action: () async{
                                // controller.addDiffusionVisiteCount();
                                Get.toNamed(AppRoutes.DIFFUSION);
                                if(await MainServices.checkUserIsExclude() == false){
                                  controller.addVisiteCount('bon_plan');
                                }
                              }
                          )
                      ),
                      Flexible(
                          child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                              title: 'Numéros utiles', icon: MENU_INFORMATION,
                              enabled: true,
                              action: () async{
                                // controller.addAnnuaireVisiteCount();
                                Get.toNamed(AppRoutes.ANNUAIRE);
                                if(await MainServices.checkUserIsExclude() == false){
                                  controller.addVisiteCount('annuaire');
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
                              title: 'Jobs / Annonces',icon: MENU_JOB,
                              enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_job_count,
                              action: () async{
                                // controller.addJobVisiteCount();
                                Get.toNamed(AppRoutes.JOB);
                                if(await MainServices.checkUserIsExclude() == false){
                                 controller.addVisiteCount('job');
                                }
                              }
                          )
                      ),
                      Flexible(
                          child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                              title: 'Pharmacie de garde', icon: MENU_PHARMACIE,
                              enabled: true,
                              action: () async{
                                // controller.addPharmacieVisiteCount();
                                Get.toNamed(AppRoutes.PHARMACIE);
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
                  //     Flexible(
                  //         child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                  //             title: 'Discussions',icon: MENU_DISCUSSION,
                  //             enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_discussion_count,
                  //             action: (){
                  //               controller.addDiscussionVisiteCount();
                  //               Get.toNamed(AppRoutes.DISCUSSION);
                  //             }
                  //         )
                  //     ),
                  //     Flexible(
                  //         child: MenuWidget(width: (Get.width / 2) - 20, height: 120,
                  //             title: 'Pharmacie de garde', icon: MENU_PHARMACIE,
                  //             enabled: true,
                  //             action: (){
                  //               controller.addPharmacieVisiteCount();
                  //               Get.toNamed(AppRoutes.PHARMACIE);
                  //             }
                  //         )
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            )
          ],
        )),
      )
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
