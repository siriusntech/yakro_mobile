import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Course/path_course.dart';
import 'package:jaime_yakro/Screens/Widgets/path_widget.dart';
import 'package:quickalert/models/quickalert_type.dart';

class CourseEnAttenteComponent
    extends GetView<CourseConciergerieScreenController> {
  const CourseEnAttenteComponent({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          SizedBox(
              child: Text('En Attente',
                  style: GoogleFonts.taprom(
                    fontSize: 30,
                    color: Colors.black,
                  ))),
          Expanded(
            child: Obx(() => controller.courseConciergerieEnAttenteLoading.value
                ? Center(
                    child: SpinKitDoubleBounce(
                    color: controller.colorPrimary.value,
                  ))
                : RefreshIndicator(
                    color: controller.colorPrimary.value,
                    onRefresh: () async {
                      controller.getCourseConciergerieListEnAttenteByCoursier();
                      return Future.value();
                    },
                    child: ListView.separated(
                      separatorBuilder: (_, index) => const Divider(),
                      itemBuilder: (_, index) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          onTap: controller
                                      .courseConciergerieListEnAttenteByCoursier[
                                          index]
                                      .cousierConcierges ==
                                  null
                              ? () {
                                  quickAlertDialog(
                                      context, QuickAlertType.confirm,
                                      color: ConstColors.alertInfo,
                                      title: 'Nouvelle Course',
                                      message:
                                          'Voulez vous accepter cette course',
                                      onConfirmBtnTap: () {
                                    controller.acceptCourseConciergerie(
                                        controller
                                            .courseConciergerieListEnAttenteByCoursier[
                                                index]
                                            .id!,
                                        context);
                                  });
                                }
                              : () {
                                  showBottomSheet(
                                      context: context,
                                      builder: (_) =>
                                          ListeTachesCourseComponent(
                                            tacheConcierges: controller
                                                .courseConciergerieListEnAttenteByCoursier[
                                                    index]
                                                .tacheConcierges!,
                                            courseConciergeModel: controller
                                                    .courseConciergerieListEnAttenteByCoursier[
                                                index],
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
                                      color: controller
                                                  .courseConciergerieListEnAttenteByCoursier[
                                                      index]
                                                  .etat ==
                                              'en_cours'
                                          ? ConstColors.alertInfo
                                          : controller
                                                      .courseConciergerieListEnAttenteByCoursier[
                                                          index]
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
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              height: height / 10,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${controller.courseConciergerieListEnAttenteByCoursier[index].reference}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily:
                                                        GoogleFonts.nunito()
                                                            .fontFamily,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            //${controller.statusToString(controller.stringToStatus(controller.courseConciergerieList[index].etat.toString()))}
                                            Text(
                                              'Etat: ${controller.statusToString(controller.stringToStatus(controller.courseConciergerieListEnAttenteByCoursier[index].etat.toString()))}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: GoogleFonts.nunito()
                                                    .fontFamily,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "${controller.courseConciergerieListEnAttenteByCoursier[index].createdAt!.day}/${controller.courseConciergerieListEnAttenteByCoursier[index].createdAt!.month}/${controller.courseConciergerieListEnAttenteByCoursier[index].createdAt!.year}",
                                        style: TextStyle(
                                          fontFamily:
                                              GoogleFonts.nunito().fontFamily,
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
                      itemCount: controller
                          .courseConciergerieListEnAttenteByCoursier.length,
                    ),
                  )),
          )
        ],
      ),
    );
  }
}
