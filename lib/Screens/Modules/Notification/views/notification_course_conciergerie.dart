import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/controllers/path_controller.dart';
import 'package:jaime_yakro/routes/path_route.dart';

class NotificationCourseConciergerie extends StatefulWidget {
  const NotificationCourseConciergerie({super.key});

  @override
  State<NotificationCourseConciergerie> createState() =>
      _NotificationCourseConciergerieState();
}

class _NotificationCourseConciergerieState
    extends State<NotificationCourseConciergerie> {
  //vool var
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final controller = Get.put(NotificationController());
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child:
                    Get.arguments['sub_type'] == '/conciergerie_course_terminer'
                        ? Image.asset(
                            'assets/images/colis-livre.png',
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/colis_new.png',
                            fit: BoxFit.cover,
                          ),
              ),
              const SizedBox(
                height: 100,
              ),
              Text(
                '${Get.arguments['title']}',
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Nunito-Regular',
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "${Get.arguments['body']}",
                style: const TextStyle(
                    fontFamily: 'Nunito-Light',
                    color: Colors.black,
                    fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Text('${Get.arguments['body']}', style: TextStyle(fontSize: 20, color: Colors.black),),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Get.arguments['sub_type'] == '/conciergerie_new_course'
                  ? InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.registerCoursierScreen);
                      },
                      child: Container(
                        height: 50,
                        width: width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppConfig.cardRadius),
                            color: ConstColors.vertColorFonce,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 5))
                            ]),
                        child: const Text(
                          'Voir Plus',
                          style: TextStyle(
                            color: ConstColors.appbarTextColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  : Get.arguments['sub_type'] == '/conciergerie_course_accepted'
                      ? InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.courseConciergerieScreen);
                          },
                          child: Container(
                            height: 50,
                            width: width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppConfig.cardRadius),
                                color: ConstColors.vertColorFonce,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      offset: Offset(0, 5))
                                ]),
                            child: const Text(
                              'Vois Plus',
                              style: TextStyle(
                                color: ConstColors.appbarTextColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      : Get.arguments['sub_type'] ==
                              '/conciergerie_course_terminer'
                          ? InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.courseConciergerieScreen);
                              },
                              child: Container(
                                height: 50,
                                width: width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppConfig.cardRadius),
                                    color: ConstColors.vertColorFonce,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 5,
                                          offset: Offset(0, 5))
                                    ]),
                                child: const Text(
                                  'Retour',
                                  style: TextStyle(
                                    color: ConstColors.appbarTextColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            )
                          : Get.arguments['sub_type'] ==
                                  '/conciergerie_course_refuser'
                              ? InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                        AppRoutes.courseConciergerieScreen);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: width,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppConfig.cardRadius),
                                        color: ConstColors.vertColorFonce,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 5,
                                              offset: Offset(0, 5))
                                        ]),
                                    child: const Text(
                                      'Retour',
                                      style: TextStyle(
                                        color: ConstColors.appbarTextColor,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                        AppRoutes.courseConciergerieScreen);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: width,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppConfig.cardRadius),
                                        color: ConstColors.vertColorFonce,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 5,
                                              offset: Offset(0, 5))
                                        ]),
                                    child: const Text(
                                      'Retour',
                                      style: TextStyle(
                                        color: ConstColors.appbarTextColor,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )
            ],
          ),
        ),
      ),
    );
  }
}
