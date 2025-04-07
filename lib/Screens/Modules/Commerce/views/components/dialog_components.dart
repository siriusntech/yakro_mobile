// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// class DialogComponents {

//   static void showAlertDialog(BuildContext context, String title, String message, Color color, GetxController controller, Callback callback) {
//     showDialog(
//               context: context,
//               builder: (_) => AlertDialog(
//                     title: const Text('Filtre'),
//                     content: Container(
//                       padding:
//                           const EdgeInsets.all(AppConfig.paddingBodySimple),
//                       height: MediaQuery.of(context).size.height / 4,
//                       width: MediaQuery.of(context).size.width,
//                       child: Obx(() => controller.isLoading.value == false
//                           ? Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SizedBox(
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                         'Tarif',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 20,
//                                             fontFamily: GoogleFonts.nunito()
//                                                 .fontFamily),
//                                       ),
//                                       RangeSlider(
//                                         values:
//                                             controller.currentRangeValues.value,
//                                         min: 0,
//                                         max: 100000,
//                                         divisions: 4000,
//                                         activeColor: const Color(0xff3D81B0),
//                                         labels: RangeLabels(
//                                           controller
//                                               .currentRangeValues.value.start
//                                               .round()
//                                               .toString(),
//                                           controller
//                                               .currentRangeValues.value.end
//                                               .round()
//                                               .toString(),
//                                         ),
//                                         onChanged: (RangeValues values) {
//                                           // setState(() {
//                                           controller.currentRangeValues.value =
//                                               values;
//                                           // });
//                                         },
//                                       ),
//                                       Text(
//                                         '${controller.currentRangeValues.value.start.ceil()} - ${controller.currentRangeValues.value.end.ceil()} (FCFA)',
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 SizedBox(
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                         "Date : ${controller.date.value.day}-${controller.date.value.month}-${controller.date.value.year}",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 20,
//                                             fontFamily: GoogleFonts.nunito()
//                                                 .fontFamily),
//                                       ),
//                                       ElevatedButton(
//                                         onPressed: () {
//                                           showDatePicker(
//                                               context: context,
//                                               firstDate: DateTime(1999),
//                                               lastDate: DateTime.now());
//                                         },
//                                         child: Text(
//                                           'Choisir une date',
//                                           style: TextStyle(
//                                               fontFamily: GoogleFonts.nunito()
//                                                   .fontFamily,
//                                               color: Get.arguments),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             )
//                           : const Center(
//                               child: SpinKitDoubleBounce(
//                                 color: Color(0xff3D81B0),
//                                 size: 50,
//                                 duration: Duration(seconds: 1),
//                               ),
//                             )),
//                     ),
//                     actions: [
//                       TextButton(
//                           onPressed: () {
//                             Get.back();
//                           },
//                           child: const Text(
//                             'Fermer',
//                             style: TextStyle(color: Color(0xff3D81B0)),
//                           )),
//                       TextButton(
//                           onPressed: () {
//                             controller.isLoading.value = true;
//                             Future.delayed(const Duration(seconds: 6), () {
//                               controller.isLoading.value = false;
//                               Get.back();
//                             });
//                           },
//                           child: const Text(
//                             'Rechercher',
//                             style: TextStyle(color: Color(0xff3D81B0)),
//                           ))
//                     ],
//                   ));
//   }
// }