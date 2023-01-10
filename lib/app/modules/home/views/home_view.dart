import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_cocody/app/Utils/app_routes.dart';
import 'package:jaime_cocody/app/widgets/notification_widget.dart';

import '../../../Utils/app_constantes.dart';
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
        leading: NotificationWidget(icon: Icons.refresh_rounded,
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
              image: AssetImage(BG_HOME),
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
            Expanded(
              flex: 3,
              child: Obx(() => MenuViewDeux()),
            )
          ],
        ),
      )
    );
  }


  MenuViewDeux(){
    return ListView(
      padding: EdgeInsets.only(bottom: 20),
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Flexible(
            //     child: MenuDeuxWidget(width: (Get.width / 2) - 20, height: 120,
            //       title: 'Agenda',icon: MENU_AGENDA, page: AppRoutes.AGENDA,
            //     )
            // ),
            Flexible(
                child: MenuDeuxWidget(width: (Get.width / 2) - 20, height: 120,
                    title: 'Actualités',icon: MENU_ACTUALITE, page: AppRoutes.ACTUALITE,
                    enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_actualite_count,
                )
            ),
            Flexible(
                child: MenuDeuxWidget(width: (Get.width / 2) - 20, height: 120,
                  title: 'Commerces et autres',icon: MENU_COMMERCE, page: AppRoutes.COMMERCE,
                  enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_commerce_count,
                )
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Flexible(
            //     child: MenuDeuxWidget(width: (Get.width / 2) - 20, height: 120,
            //         title: 'Discussions',icon: MENU_DISCUSSION, page: AppRoutes.DISCUSSION,
            //     )
            // ),
            Flexible(
                child: MenuDeuxWidget(width: (Get.width / 2) - 20, height: 120,
                    title: 'Bon à savoir',icon: MENU_HISTORIQUE, page: AppRoutes.HISTORIQUE,
                    enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_sujet_count,
                    action: (){

                    },
                )
            ),
            Flexible(
                child: MenuDeuxWidget(width: (Get.width / 2) - 20, height: 120,
                  title: 'Signaler un incident',icon: MENU_ALERTE, page: AppRoutes.ALERTE,
                  enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_alerte_count
                )
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: MenuDeuxWidget(width: (Get.width / 2) - 20, height: 120,
                  title: 'Notification', icon: MENU_NOTIFICATION, page: AppRoutes.DIFFUSION,
                  enabled: true, itemCount: controller.unReadDiffusionCount.value
                )
            ),
            Flexible(
                child: MenuDeuxWidget(width: (Get.width / 2) - 20, height: 120,
                  title: 'Informations utiles', icon: MENU_INFORMATION, page: AppRoutes.ANNUAIRE,
                  enabled: true,
                )
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: MenuDeuxWidget(width: (Get.width / 2) - 20, height: 120,
                  title: 'Discussions',icon: MENU_DISCUSSION, page: AppRoutes.DISCUSSION,
                  enabled: true, itemCount: controller.selectedItemsCounts.value.un_read_discussion_count,
                )
            ),
            Flexible(
                child: MenuDeuxWidget(width: (Get.width / 2) - 20, height: 120,
                  title: 'Pharmacie de garde', icon: MENU_PHARMACIE, page: AppRoutes.PHARMACIE,
                  enabled: true,
                )
            ),
          ],
        ),
      ],
    );
  }

  _menu({page, icon, title, subtitle}){
    return GestureDetector(
      onTap: (){
        Get.toNamed(page);
      },
      child: Container(
        margin: EdgeInsets.only(left: 8, right: 8, top: 2),
        width: double.maxFinite,
        height: 80,
        child: Card(
          elevation: 25 ,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              SizedBox(width: 5,),
              Container(
                child: Image.asset(icon, width: 40, height: 40,),
              ),
              SizedBox(width: 5,),
              Text("|", style: TextStyle(fontSize: 55.0, color: Colors.black38),),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(text: title, fontSize: 16.0, color: Colors.black87, fontWeight: FontWeight.bold),
                  SizedBox(height: 3,),
                  TextWidget(text: subtitle, fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.w600),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
