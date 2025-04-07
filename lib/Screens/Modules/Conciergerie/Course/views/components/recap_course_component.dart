import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Screens/Modules/Conciergerie/Course/path_course.dart';

class RecapCourseComponent extends StatefulWidget {
  List<TextEditingController> controllers = [];
  RecapCourseComponent({super.key, required this.controllers});

  @override
  State<RecapCourseComponent> createState() => _RecapCourseComponentState();
}

class _RecapCourseComponentState extends State<RecapCourseComponent> {
  final controllerCourseConciergerie =
      Get.find<CourseConciergerieScreenController>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(10),
      height: height,
      width: width,
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          SizedBox(
            child: Row(
              children: [
                Text('Recapitulatif de votre Course',
                    style: GoogleFonts.taprom(
                      fontSize: 30,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      color: controllerCourseConciergerie.colorPrimary.value,
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.separated(
            itemCount: widget.controllers.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 5,
            ),
            itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: controllerCourseConciergerie.colorPrimary.value
                        .withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color:
                            controllerCourseConciergerie.colorPrimary.value)),
                child: Text(
                  'Tache ${index + 1}:  ${widget.controllers[index].text}',
                  style: TextStyle(fontFamily: GoogleFonts.nunito().fontFamily),
                )),
          )),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          Obx(() => Column(
                children: [
                  Text(
                      'Compte: ${controllerCourseConciergerie.userConciergeValue.value?.nom} ${controllerCourseConciergerie.userConciergeValue.value?.prenoms}'),
                  Text(
                      'Informations: ${controllerCourseConciergerie.userConciergeValue.value?.quartier} / ${controllerCourseConciergerie.userConciergeValue.value?.telephone}'),
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            width: width,
            child: Row(
              children: [
                Container(
                    height: 50,
                    width: width / 2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ConstColors.alertDanger,
                    ),
                    child: Text(
                      'Montant: ${controllerCourseConciergerie.amountCourse.value} FCFA',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontSize: 18),
                    )),
                SizedBox(
                  width: width / 30,
                ),
                Obx(() => controllerCourseConciergerie.userConcierge.value ==
                        null
                    ? Expanded(
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => const ListeLocationComponent());
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber,
                            ),
                            child: Text('Suivant',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontSize: 20)),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                controllerCourseConciergerie
                                    .createNewCourseConciergerie(context);
                              },
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                child: Text('Validez',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily:
                                            GoogleFonts.nunito().fontFamily,
                                        fontSize: 20)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width / 50,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: controllerCourseConciergerie
                                  .colorPrimary.value,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) =>
                                          const ListeLocationComponent());
                                },
                                icon: const Icon(Icons.person)),
                          )
                        ],
                      )))
              ],
            ),
          )
        ],
      ),
    );
  }
}
