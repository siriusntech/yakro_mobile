import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Course/path_course.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Coursier/path_coursier.dart';
import 'package:jaime_yakro/routes/path_route.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class HomeCoursierScreen extends StatefulWidget {
  const HomeCoursierScreen({super.key});

  @override
  State<HomeCoursierScreen> createState() => _HomeCoursierScreenState();
}

class _HomeCoursierScreenState extends State<HomeCoursierScreen> {
  final HomeCoursierScreenController controller =
      Get.put(HomeCoursierScreenController());
  final CourseConciergerieScreenController courseConciergerieScreenController =
      Get.put(CourseConciergerieScreenController());
  final Color navigationBarColor = Colors.white;
  int selectedIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

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
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(
                  AppRoutes.profileCoursierScreen,
                );
              },
              icon: const Icon(Icons.person_2_outlined))
        ],
        title: Text(controller.title.value,
            style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.taprom().fontFamily)),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: controller.navigationBarColor.value,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: SizedBox(
          height: height,
          width: width,
          // backgroundColor: Colors.grey,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: <Widget>[
              Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    SizedBox(
                        child: Text('Terminer',
                            style: GoogleFonts.taprom(
                              fontSize: 30,
                              color: Colors.black,
                            ))),
                    Expanded(
                      child: Obx(() => courseConciergerieScreenController
                              .courseConciergerieTerminerLoading.value
                          ? Center(
                              child: SpinKitDoubleBounce(
                              color: controller.colorPrimary.value,
                            ))
                          : RefreshIndicator(
                              color: controller.colorPrimary.value,
                              onRefresh: () async {
                                courseConciergerieScreenController
                                    .getCourseConciergerieListEnAttenteByCoursier();
                                return Future.value();
                              },
                              child: ListView.separated(
                                separatorBuilder: (_, index) => const Divider(),
                                itemBuilder: (_, index) => Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                                title: const Text(
                                                  'Les Taches',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                content: Container(
                                                    height: height / 2,
                                                    width: width,
                                                    decoration:
                                                        const BoxDecoration(),
                                                    child: ListView.separated(
                                                        itemCount:
                                                            courseConciergerieScreenController
                                                                .courseConciergerieListTerminerByCoursier[
                                                                    index]
                                                                .tacheConcierges!
                                                                .length,
                                                        separatorBuilder:
                                                            (_, indexs) =>
                                                                const Divider(),
                                                        itemBuilder: (_,
                                                                indexs) =>
                                                            ListTile(
                                                              subtitle: Text(
                                                                "${courseConciergerieScreenController.courseConciergerieListTerminerByCoursier[index].tacheConcierges![indexs].updatedAt!.day}/${courseConciergerieScreenController.courseConciergerieListTerminerByCoursier[index].tacheConcierges![indexs].updatedAt!.month}/${courseConciergerieScreenController.courseConciergerieListTerminerByCoursier[index].tacheConcierges![indexs].updatedAt!.year} ${courseConciergerieScreenController.courseConciergerieListTerminerByCoursier[index].tacheConcierges![indexs].updatedAt!.hour}:${courseConciergerieScreenController.courseConciergerieListTerminerByCoursier[index].tacheConcierges![indexs].updatedAt!.minute}",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        GoogleFonts.nunito()
                                                                            .fontFamily),
                                                              ),
                                                              title: SizedBox(
                                                                  child: Text(
                                                                '${courseConciergerieScreenController.courseConciergerieListTerminerByCoursier[index].tacheConcierges![indexs].libelle}',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        GoogleFonts.nunito()
                                                                            .fontFamily),
                                                              )),
                                                              trailing: Text(
                                                                '${courseConciergerieScreenController.courseConciergerieListTerminerByCoursier[index].tacheConcierges![indexs].etat}',
                                                                style: TextStyle(
                                                                    color: courseConciergerieScreenController.courseConciergerieListTerminerByCoursier[index].tacheConcierges![indexs].etat == 'en_cours'
                                                                        ? ConstColors.alertInfo
                                                                        : courseConciergerieScreenController.courseConciergerieListTerminerByCoursier[index].tacheConcierges![indexs].etat == 'terminer'
                                                                            ? ConstColors.alertSuccess
                                                                            : ConstColors.alertWarnig,
                                                                    fontFamily: GoogleFonts.nunito().fontFamily),
                                                              ),
                                                            ))),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text(
                                                        'Fermer',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .nunito()
                                                                    .fontFamily,
                                                            color: controller
                                                                .colorPrimary
                                                                .value),
                                                      ))
                                                ],
                                              ));
                                    },
                                    child: SizedBox(
                                      height: height / 10,
                                      width: width,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: height / 10,
                                            width: 10,
                                            decoration: BoxDecoration(
                                                color: courseConciergerieScreenController
                                                            .courseConciergerieListTerminerByCoursier[
                                                                index]
                                                            .etat ==
                                                        'en_cours'
                                                    ? ConstColors.alertInfo
                                                    : courseConciergerieScreenController
                                                                .courseConciergerieListTerminerByCoursier[
                                                                    index]
                                                                .etat ==
                                                            'terminer'
                                                        ? ConstColors
                                                            .alertSuccess
                                                        : ConstColors
                                                            .alertWarnig,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        topLeft:
                                                            Radius.circular(
                                                                10))),
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
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        height: height / 10,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          '${courseConciergerieScreenController.courseConciergerieListTerminerByCoursier[index].reference}',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontFamily: GoogleFonts
                                                                      .nunito()
                                                                  .fontFamily,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Etat: ${courseConciergerieScreenController.courseConciergerieListTerminerByCoursier[index].etat}',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .nunito()
                                                                  .fontFamily,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  "${courseConciergerieScreenController.courseConciergerieListTerminerByCoursier[index].updatedAt!.day}/${courseConciergerieScreenController.courseConciergerieListTerminerByCoursier[index].updatedAt!.month}/${courseConciergerieScreenController.courseConciergerieListTerminerByCoursier[index].updatedAt!.year} ${courseConciergerieScreenController.courseConciergerieListTerminerByCoursier[index].updatedAt!.hour}:${courseConciergerieScreenController.courseConciergerieListTerminerByCoursier[index].updatedAt!.minute}",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.nunito()
                                                            .fontFamily,
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
                                itemCount: courseConciergerieScreenController
                                    .courseConciergerieListTerminerByCoursier
                                    .length,
                              ),
                            )),
                    )
                  ],
                ),
              ),
              Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    SizedBox(
                        child: Text('En Cours',
                            style: GoogleFonts.taprom(
                              fontSize: 30,
                              color: Colors.black,
                            ))),
                    Expanded(
                      child: Obx(() => courseConciergerieScreenController
                              .courseConciergerieEnCoursLoading.value
                          ? Center(
                              child: SpinKitDoubleBounce(
                              color: controller.colorPrimary.value,
                            ))
                          : RefreshIndicator(
                              color: controller.colorPrimary.value,
                              onRefresh: () async {
                                courseConciergerieScreenController
                                    .getCourseConciergerieListEnCoursByCoursier();
                                return Future.value();
                              },
                              child: ListView.separated(
                                separatorBuilder: (_, index) => const Divider(),
                                itemBuilder: (_, index) =>
                                    Builder(builder: (context) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: InkWell(
                                      onTap: () {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.info,
                                          title: 'Informations',
                                          barrierColor:
                                              controller.colorPrimary.value,
                                          confirmBtnColor:
                                              controller.colorPrimary.value,
                                          text:
                                              'Bonjour, votre Course est en cours, veuillez contactez le client pour plus d\'informations sur vos taches',
                                          onConfirmBtnTap: () => {
                                            Get.back(),
                                            launchUrl(
                                              Uri.parse(
                                                  "tel:${courseConciergerieScreenController.courseConciergerieListEnCoursByCoursier[index].userConcierge!.telephone}"),
                                            )
                                          },
                                          showCancelBtn: true,
                                          cancelBtnText: 'Les Taches',
                                          confirmBtnText: 'Appel',
                                          onCancelBtnTap: () {
                                            Get.back();
                                            showBottomSheet(
                                                context: context,
                                                builder: (_) =>
                                                    ListeTachesCourseComponent(
                                                      tacheConcierges:
                                                          courseConciergerieScreenController
                                                              .courseConciergerieListEnCoursByCoursier[
                                                                  index]
                                                              .tacheConcierges!,
                                                      courseConciergeModel:
                                                          courseConciergerieScreenController
                                                                  .courseConciergerieListEnCoursByCoursier[
                                                              index],
                                                    ),
                                                backgroundColor:
                                                    Colors.transparent);
                                          },
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
                                                    color: courseConciergerieScreenController
                                                                .courseConciergerieListEnCoursByCoursier[
                                                                    index]
                                                                .etat ==
                                                            'en_cours'
                                                        ? ConstColors.alertInfo
                                                        : courseConciergerieScreenController
                                                                    .courseConciergerieListEnCoursByCoursier[
                                                                        index]
                                                                    .etat ==
                                                                'terminer'
                                                            ? ConstColors
                                                                .alertSuccess
                                                            : ConstColors
                                                                .alertWarnig,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topLeft:
                                                                Radius.circular(
                                                                    10))),
                                                child: IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder:
                                                              (_) =>
                                                                  AlertDialog(
                                                                    titlePadding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            0),
                                                                    contentPadding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    buttonPadding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            0),
                                                                    title:
                                                                        Container(
                                                                      // height: height / 12,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius: const BorderRadius
                                                                            .only(
                                                                            topLeft:
                                                                                Radius.circular(15),
                                                                            topRight: Radius.circular(15)),
                                                                        color: courseConciergerieScreenController.courseConciergerieListEnCoursByCoursier[index].etat ==
                                                                                'en_cours'
                                                                            ? ConstColors.alertInfo
                                                                            : courseConciergerieScreenController.courseConciergerieListEnCoursByCoursier[index].etat == 'terminer'
                                                                                ? ConstColors.alertSuccess
                                                                                : ConstColors.alertWarnig,
                                                                      ),
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          15),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "Informations",
                                                                            style: TextStyle(
                                                                                fontFamily: GoogleFonts.nunito().fontFamily,
                                                                                fontSize: 25,
                                                                                color: Colors.white),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                width,
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                Text(
                                                                                  '${courseConciergerieScreenController.courseConciergerieListEnCoursByCoursier[index].reference}',
                                                                                  style: TextStyle(fontFamily: GoogleFonts.nunito().fontFamily, color: Colors.white, fontSize: 15),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    content:
                                                                        SizedBox(
                                                                      height:
                                                                          height /
                                                                              5,
                                                                      width:
                                                                          width,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          SizedBox(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Text(
                                                                                  'Nom & Prenom: ',
                                                                                  style: TextStyle(fontFamily: GoogleFonts.nunito().fontFamily, fontSize: 18),
                                                                                ),
                                                                                SizedBox(
                                                                                  child: Text(
                                                                                    '${courseConciergerieScreenController.courseConciergerieListEnCoursByCoursier[index].userConcierge!.nom} ${courseConciergerieScreenController.courseConciergerieListEnCoursByCoursier[index].userConcierge!.prenoms}',
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    softWrap: false,
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(fontFamily: GoogleFonts.nunito().fontFamily, fontSize: 18),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            child:
                                                                                OutlinedButton(
                                                                              onPressed: () {
                                                                                launchUrl(
                                                                                  Uri.parse("tel:${courseConciergerieScreenController.courseConciergerieListEnCoursByCoursier[index].userConcierge!.telephone}"),
                                                                                );
                                                                              },
                                                                              child: Text(
                                                                                'Tel: ${courseConciergerieScreenController.courseConciergerieListEnCoursByCoursier[index].userConcierge!.telephone}',
                                                                                style: TextStyle(fontFamily: GoogleFonts.nunito().fontFamily, color: controller.colorPrimary.value, fontSize: 20),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            child:
                                                                                Text(
                                                                              'Localisation: ${courseConciergerieScreenController.courseConciergerieListEnCoursByCoursier[index].userConcierge!.quartier}',
                                                                              maxLines: 2,
                                                                              style: TextStyle(fontFamily: GoogleFonts.nunito().fontFamily, fontSize: 20),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Get.back();
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Fermer',
                                                                            style:
                                                                                TextStyle(fontFamily: GoogleFonts.nunito().fontFamily, color: controller.colorPrimary.value),
                                                                          ))
                                                                    ],
                                                                  ));
                                                    },
                                                    icon: const Icon(Icons
                                                        .person_2_outlined))),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Container(
                                                          height: height / 10,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            '${courseConciergerieScreenController.courseConciergerieListEnCoursByCoursier[index].reference}',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontFamily: GoogleFonts
                                                                        .nunito()
                                                                    .fontFamily,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Etat: ${courseConciergerieScreenController.courseConciergerieListEnCoursByCoursier[index].etat}',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .nunito()
                                                                    .fontFamily,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    "${courseConciergerieScreenController.courseConciergerieListEnCoursByCoursier[index].updatedAt!.day}/${courseConciergerieScreenController.courseConciergerieListEnCoursByCoursier[index].updatedAt!.month}/${courseConciergerieScreenController.courseConciergerieListEnCoursByCoursier[index].updatedAt!.year} ${courseConciergerieScreenController.courseConciergerieListEnCoursByCoursier[index].updatedAt!.hour}:${courseConciergerieScreenController.courseConciergerieListEnCoursByCoursier[index].updatedAt!.minute}",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.nunito()
                                                              .fontFamily,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                itemCount: courseConciergerieScreenController
                                    .courseConciergerieListEnCoursByCoursier
                                    .length,
                              ),
                            )),
                    )
                  ],
                ),
              ),
              const CourseEnAttenteComponent(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: controller.navigationBarColor.value,
        onItemSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
          pageController.animateToPage(selectedIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad);
        },
        selectedIndex: selectedIndex,
        waterDropColor: selectedIndex == 0
            ? ConstColors.alertSuccess
            : selectedIndex == 1
                ? ConstColors.alertWarnig
                : controller.colorPrimary.value,
        inactiveIconColor: Colors.grey,
        barItems: <BarItem>[
          BarItem(
            filledIcon: Icons.check_box, //terminer
            outlinedIcon: Icons.check_box_outline_blank,
          ),
          BarItem(
              filledIcon: Icons.warning, //en cours
              outlinedIcon: Icons.check_box_outline_blank),
          BarItem(
              filledIcon: Icons.access_time_filled_outlined, //en attente
              outlinedIcon: Icons.check_box_outline_blank),
        ],
      ),
    );
  }
}
