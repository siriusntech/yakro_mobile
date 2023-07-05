import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_cocody/app/Utils/app_colors.dart';
import 'package:jaime_cocody/app/Utils/app_routes.dart';
import 'package:jaime_cocody/app/Utils/default_image.dart';
import 'package:jaime_cocody/app/data/repository/main_services.dart';
import 'package:jaime_cocody/app/models/media.dart';
import 'package:jaime_cocody/app/routes/app_pages.dart';
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
  final MainController mainCtrl = Get.put(MainController());
  final ActualiteController actualite_ctrl = Get.put(ActualiteController());
  final CommerceController commerce_ctrl = Get.put(CommerceController());
  final JobController job_ctrl = Get.put(JobController());
  final PharmacieController pharm_ctrl = Get.put(PharmacieController());
  final AlerteController alerte_ctrl = Get.put(AlerteController());
  final AnnuaireController annuaire_ctrl = Get.put(AnnuaireController());
  final HistoriqueController culture_ctrl = Get.put(HistoriqueController());
  final DiffusionController bon_plan_ctrl = Get.put(DiffusionController());

  Loading() {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 1),
      child: LoadingWidget(),
    );
  }

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => mainCtrl.isSettingProcessing.value == true
        ? Loading()
        : Scaffold(
            backgroundColor: mainColor,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white,
              // automaticallyImplyLeading: false,
              elevation: 0.0,
              // leading: NotificationWidget(icon: Icons.home,
              //   action: (){
              //     controller.refreshData();
              //   },
              // ),
              actions: [
                NotificationWidget(
                  icon: Icons.home,
                  color: mainCtrl.vert_color_fonce,
                  action: () async {
                    await controller.refreshHome();
                  },
                ),
                NotificationWidget(
                  icon: Icons.call,
                  color: mainCtrl.vert_color_fonce,
                  action: () {
                    Get.toNamed(AppRoutes.NOUSCONTACTEZ);
                  },
                ),
                NotificationWidget(
                  icon: Icons.help,
                  color: mainCtrl.vert_color_fonce,
                  action: () {
                    Get.toNamed(AppRoutes.APROPOS);
                  },
                ),
                NotificationWidget(
                  icon: Icons.share,
                  color: mainCtrl.vert_color_fonce,
                  action: () {
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
                      fit: BoxFit.cover),
                ),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        width: 390,
                        child: Center(
                          child: Column(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                  enableInfiniteScroll: true,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 7),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 3500),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                ),
                                items: generateSlider(
                                    controller.sliderList.map((e) {
                                  return e.imageUrl;
                                }).toList()),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Visibility(
                        visible: mainCtrl.isCocody.value == true &&
                            controller.miseAJourModel.value.id != null &&
                            controller.miseAJourModel.value.etat == 0 &&
                            controller.showUpdateWidget.value == true,
                        child: Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          child: Card(
                            elevation: 30,
                            child: ListTile(
                              leading: Icon(
                                Icons.system_update_alt_rounded,
                                color: mainColor,
                                size: 30,
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    controller.closeUpdateWidget();
                                  },
                                  icon: Icon(Icons.close)),
                              title: TextWidget(
                                text: controller.miseAJourModel.value.titre,
                                fontWeight: FontWeight.bold,
                              ),
                              subtitle: TextWidget(
                                text:
                                    controller.miseAJourModel.value.description,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              onTap: () {
                                // print(controller.miseAJourModel.value.lien);
                                var link = controller
                                            .miseAJourModel.value.lien !=
                                        ""
                                    ? controller.miseAJourModel.value.lien
                                    : "https://play.google.com/store/apps/details?id=com.siriusntech.jaime_cocody";
                                launchUrl(Uri.parse(link!));
                                // await controller.makeUpdate();
                                controller.makeUpdate();
                              },
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 3,
                      child: controller.isDataRefreshing == true
                          ? LoadingWidget()
                          : Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: ListView(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                          child: MenuWidget(
                                        width: (Get.width / 2) - 20,
                                        height: 120,
                                        color: mainCtrl.vert_color_fonce,
                                        title: 'Cultures',
                                        icon: MENU_HISTORIQUE,
                                        enabled: true,
                                        itemCount: controller
                                            .selectedItemsCounts
                                            .value
                                            .un_read_sujet_count,
                                        action: () async {
                                          // controller.addHistoriqueVisiteCount();
                                          Get.toNamed(AppRoutes.HISTORIQUE);
                                          culture_ctrl.refreshData();
                                          if (await MainServices
                                                  .checkUserIsExclude() ==
                                              false) {
                                            controller
                                                .addVisiteCount('culture');
                                          }
                                        },
                                      )),
                                      Flexible(
                                          child: MenuWidget(
                                              width: (Get.width / 2) - 20,
                                              height: 120,
                                              color: mainCtrl.vert_color_fonce,
                                              title: 'Hotels',
                                              icon: HOTEL,
                                              enabled: true,
                                              action: () async {
                                                Get.toNamed(Routes.HOTEL);
                                                // annuaire_ctrl.refreshData();
                                                // if(await MainServices.checkUserIsExclude() == false){
                                                //   controller.addVisiteCount('annuaire');
                                                // }
                                              })),
                                      Flexible(
                                          child: MenuWidget(
                                              width: (Get.width / 2) - 20,
                                              height: 120,
                                              color: mainCtrl.vert_color_fonce,
                                              title: 'Numéros utiles',
                                              icon: MENU_INFORMATION,
                                              enabled: true,
                                              action: () async {
                                                // controller.addAnnuaireVisiteCount();
                                                Get.toNamed(AppRoutes.ANNUAIRE);
                                                annuaire_ctrl.refreshData();
                                                if (await MainServices
                                                        .checkUserIsExclude() ==
                                                    false) {
                                                  controller.addVisiteCount(
                                                      'annuaire');
                                                }
                                              })),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                          child: MenuWidget(
                                              width: (Get.width / 2) - 20,
                                              height: 120,
                                              color: mainCtrl.vert_color_fonce,
                                              title: 'Pharmacie de garde',
                                              icon: MENU_PHARMACIE,
                                              enabled: true,
                                              action: () async {
                                                Get.toNamed(
                                                    AppRoutes.PHARMACIE);
                                                pharm_ctrl.refreshData();
                                                if (await MainServices
                                                        .checkUserIsExclude() ==
                                                    false) {
                                                  controller.addVisiteCount(
                                                      'pharmacie');
                                                }
                                              })),
                                      Flexible(
                                          child: MenuWidget(
                                              width: (Get.width / 2) - 20,
                                              height: 120,
                                              color: mainCtrl.vert_color_fonce,
                                              title: 'Sites Touristiques',
                                              icon: VT,
                                              enabled: true,
                                              action: () async {
                                                Get.toNamed(
                                                    Routes.SITETOURISTIQUES);
                                                // annuaire_ctrl.refreshData();
                                                // if(await MainServices.checkUserIsExclude() == false){
                                                //   controller.addVisiteCount('annuaire');
                                                // }
                                              })),
                                      Flexible(
                                          child: MenuWidget(
                                              width: (Get.width / 2) - 20,
                                              height: 120,
                                              color: mainCtrl.vert_color_fonce,
                                              title: 'Restaurants et Maquis',
                                              icon: RESTAURANT,
                                              enabled: true,
                                              action: () async {
                                                Get.toNamed(Routes.RESTAURANT);
                                                // annuaire_ctrl.refreshData();
                                                // if(await MainServices.checkUserIsExclude() == false){
                                                //   controller.addVisiteCount('annuaire');
                                                // }
                                              }))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    )
                  ],
                )),
            // drawer: MainDrawer()
          ));
  }
}

List<Widget> generateSlider(List item) {
  List<Widget> imageSliders = item.map((item) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              // color: AppColors.vert_color,
              ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            child: CachedNetworkImage(
              imageUrl: item,
              fit: BoxFit.cover,
              width: Get.width,
            ),
          ),
        );
      },
    );
  }).toList();
  return imageSliders;
}
