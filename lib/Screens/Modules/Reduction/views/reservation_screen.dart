import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jaime_yakro/Helpers/helpers.dart';
import 'package:jaime_yakro/Screens/Modules/Reduction/reduction_path.dart';

import '../../../../Providers/path_providers.dart';

class ReservationScreen extends GetView<ReservationScreenController>{
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {


    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: controller.colorPrimary.value,
        centerTitle: true,
        title: Text(
          'Faire une Réservation',
          style: TextStyle(
          fontSize: 25,
              fontFamily: GoogleFonts.nunito().fontFamily,
              color: Colors.white,
        ),),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width,
                padding:
                const EdgeInsets
                    .all(10),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      'Nom',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      // height:
                      //     height / 14,
                      width: width,
                      decoration:
                      BoxDecoration(
                        borderRadius:
                        BorderRadius
                            .circular(
                            10),
                        border: Border.all(
                            color: controller
                                .colorPrimary
                                .value
                                .withOpacity(
                                0.3),
                            width: 1),
                      ),
                      child:
                      TextFormField(
                        controller:
                        controller
                            .nomController
                            .value,
                        decoration:
                        InputDecoration(
                          border:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                                10),
                            borderSide: BorderSide(
                                color: controller
                                    .colorPrimary
                                    .value),
                          ),
                          enabledBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius
                                .circular(0),
                            borderSide: BorderSide(
                                color: controller
                                    .colorPrimary
                                    .value),
                          ),
                          focusedBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                                10),
                            borderSide: BorderSide(
                                color: controller
                                    .colorPrimary
                                    .value),
                          ),
                          hintText:
                          'Konan',
                          suffixIcon:
                          const Icon(
                            Icons
                                .person,
                            color: Colors
                                .amber,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // height: height/9,
                width: width,
                // color: controller.colorPrimary.value.withOpacity(0.5),
                padding:
                const EdgeInsets
                    .all(10),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      'Prénoms',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: GoogleFonts
                              .nunito()
                              .fontFamily,
                          fontWeight:
                          FontWeight
                              .bold),
                    ),
                    Container(
                      // height:
                      //     height / 14,
                      width: width,
                      decoration:
                      BoxDecoration(
                        borderRadius:
                        BorderRadius
                            .circular(
                            10),
                        border: Border.all(
                            color: controller
                                .colorPrimary
                                .value
                                .withOpacity(
                                0.3),
                            width: 1),
                      ),
                      child:
                      TextFormField(
                        controller:
                        controller
                            .prenomController
                            .value,
                        decoration:
                        InputDecoration(
                          border:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                                10),
                            borderSide: BorderSide(
                                color: controller
                                    .colorPrimary
                                    .value),
                          ),
                          enabledBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius
                                .circular(0),
                            borderSide: BorderSide(
                                color: controller
                                    .colorPrimary
                                    .value),
                          ),
                          focusedBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                                10),
                            borderSide: BorderSide(
                                color: controller
                                    .colorPrimary
                                    .value),
                          ),
                          hintText:
                          'Arnaud Ndong',
                          suffixIcon:
                          const Icon(
                            Icons
                                .person,
                            color: Colors
                                .amber,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                // height: height/9,
                width: width,
                // color: controller.colorPrimary.value.withOpacity(0.5),
                padding:
                const EdgeInsets
                    .all(10),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      'Téléphone',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: GoogleFonts
                              .nunito()
                              .fontFamily,
                          fontWeight:
                          FontWeight
                              .bold),
                    ),
                    Container(
                      // height:
                      //     height / 14,
                      width: width,
                      decoration:
                      BoxDecoration(
                        borderRadius:
                        BorderRadius
                            .circular(
                            10),
                        border: Border.all(
                            color: controller
                                .colorPrimary
                                .value
                                .withOpacity(
                                0.3),
                            width: 1),
                      ),
                      child:
                      TextFormField(
                        controller:
                        controller
                            .telephoneController
                            .value,
                        keyboardType:  TextInputType.phone,
                        maxLength: 10,
                        decoration:
                        InputDecoration(
                          border:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                                10),
                            borderSide: BorderSide(
                                color: controller
                                    .colorPrimary
                                    .value),
                          ),
                          enabledBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius
                                .circular(0),
                            borderSide: BorderSide(
                                color: controller
                                    .colorPrimary
                                    .value),
                          ),
                          focusedBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                                10),
                            borderSide: BorderSide(
                                color: controller
                                    .colorPrimary
                                    .value),
                          ),
                          hintText:
                          '01 02 03 05 06',
                          suffixIcon:
                          const Icon(
                            Icons
                                .phone,
                            color: Colors
                                .amber,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // height: height/9,
                width: width,
                // color: controller.colorPrimary.value.withOpacity(0.5),
                padding:
                const EdgeInsets
                    .all(10),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      'Nombre de Chambre',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: GoogleFonts
                              .nunito()
                              .fontFamily,
                          fontWeight:
                          FontWeight
                              .bold),
                    ),
                    Container(
                      // height:
                      //     height / 14,
                      width: width,
                      decoration:
                      BoxDecoration(
                        borderRadius:
                        BorderRadius
                            .circular(
                            10),
                        border: Border.all(
                            color: controller
                                .colorPrimary
                                .value
                                .withOpacity(
                                0.3),
                            width: 1),
                      ),
                      child:
                      TextFormField(
                        controller:
                        controller
                            .nbrChambre
                            .value,
                        keyboardType:  TextInputType.number,
                        maxLength: 4,
                        decoration:
                        InputDecoration(
                          border:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                                10),
                            borderSide: BorderSide(
                                color: controller
                                    .colorPrimary
                                    .value),
                          ),
                          enabledBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius
                                .circular(0),
                            borderSide: BorderSide(
                                color: controller
                                    .colorPrimary
                                    .value),
                          ),
                          focusedBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(
                                10),
                            borderSide: BorderSide(
                                color: controller
                                    .colorPrimary
                                    .value),
                          ),
                          hintText:
                          '5',
                          suffixIcon:
                          const Icon(
                            Icons
                                .hotel,
                            color: Colors
                                .amber,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // height: height/9,
                width: width,
                // color: controller.colorPrimary.value.withOpacity(0.5),
                padding:
                const EdgeInsets
                    .all(10),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      'Date Arrivée & Départ',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: GoogleFonts
                              .nunito()
                              .fontFamily,
                          fontWeight:
                          FontWeight
                              .bold),
                    ),
                    Container(
                      height:
                          height / 16,
                      width: width,
                        alignment: Alignment.center,
                      decoration:
                      BoxDecoration(
                        borderRadius:
                        BorderRadius
                            .circular(
                            10),
                        border: Border.all(
                            color: controller
                                .colorPrimary
                                .value,
                            width: 1),
                      ),
                      child:Row(
                        children: [
                          Expanded(
                              child: Obx(() => Text(" ${DateFormat('dd/MM/yyyy').format(controller.dateRangeController.value.start)} - ${DateFormat('dd/MM/yyyy').format(controller.dateRangeController.value.end)}", style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.nunito().fontFamily),))),

                          IconButton(
                              onPressed: (){
                                showDateRangePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                    builder: (BuildContext context, Widget? widget) => Theme(
                                      data: ThemeData(
                                          colorScheme: const ColorScheme.light(primary: Colors.amber),
                                          datePickerTheme: const DatePickerThemeData(
                                            backgroundColor: Colors.white,
                                            dividerColor: Colors.amber,
                                            headerBackgroundColor: Colors.amber,
                                            headerForegroundColor: Colors.white,
                                            rangeSelectionOverlayColor: WidgetStatePropertyAll(Colors.amber),
                                            rangeSelectionBackgroundColor:Color(
                                                0xF1FFD591),
                                          )
                                      ), child: widget!,
                                    )
                                ).then((value) => controller.setDateRange(value!));
                              },
                              icon: Icon(Icons.calendar_month, color: controller.colorPrimary.value,))

                        ],
                      )
                    ),
                    Container(
                      // height: height/9,
                      width: width,
                      // color: controller.colorPrimary.value.withOpacity(0.5),
                      padding:
                      const EdgeInsets
                          .all(10),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          Text(
                            'Nombre de Nuits',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts
                                    .nunito()
                                    .fontFamily,
                                fontWeight:
                                FontWeight
                                    .bold),
                          ),
                          Container(
                            height:
                            height / 14,
                            width: width,
                            decoration:
                            BoxDecoration(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  10),
                              border: Border.all(
                                  color: controller
                                      .colorPrimary
                                      .value,
                                  width: 1),
                            ),
                            alignment: Alignment.center,
                            child:Text('${controller.dateRangeController.value.duration.inDays} Nuits', style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.nunito().fontFamily)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // height: height/9,
                      width: width,
                      // color: controller.colorPrimary.value.withOpacity(0.5),
                      padding:
                      const EdgeInsets
                          .all(10),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          Text(
                            'Prix Unitaire',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts
                                    .nunito()
                                    .fontFamily,
                                fontWeight:
                                FontWeight
                                    .bold),
                          ),
                          Container(
                            height:
                            height / 14,
                            width: width,
                            decoration:
                            BoxDecoration(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  10),
                              border: Border.all(
                                  color: controller
                                      .colorPrimary
                                      .value,
                                  width: 1),
                            ),
                            alignment: Alignment.center,
                            child:Text('${Helpers.formatPrice(double.parse(controller.typeChambreHotel!.prix.toString()))} Frs CFA', style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.nunito().fontFamily)),
                          ),
                        ],
                      ),
                    ),
                    Obx(() => Container(
                      // height: height/9,
                      width: width,
                      // color: controller.colorPrimary.value.withOpacity(0.5),
                      padding:
                      const EdgeInsets
                          .all(10),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts
                                    .nunito()
                                    .fontFamily,
                                fontWeight:
                                FontWeight
                                    .bold),
                          ),
                          Container(
                            height:
                                height / 14,
                            width: width,
                            decoration:
                            BoxDecoration(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  10),
                              border: Border.all(
                                  color: controller
                                      .colorPrimary
                                      .value,
                                  width: 1),
                            ),
                            alignment: Alignment.center,
                            child:Text('${Helpers.formatPrice(controller.getTotal())} Frs CFA', style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.nunito().fontFamily)),
                          ),
                        ],
                      ),
                    )),
                    Container(
                      // height: height/9,
                      width: width,
                      // color: controller.colorPrimary.value.withOpacity(0.5),
                      padding:
                      const EdgeInsets
                          .all(10),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          Text(
                            'Réduction',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts
                                    .nunito()
                                    .fontFamily,
                                fontWeight:
                                FontWeight
                                    .bold),
                          ),
                          Container(
                            height:
                            height / 14,
                            width: width,
                            decoration:
                            BoxDecoration(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  10),
                              border: Border.all(
                                  color: controller
                                      .colorPrimary
                                      .value,
                                  width: 1),
                            ),
                            alignment: Alignment.center,
                            child:Text('${controller.getReduction()} %', style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.nunito().fontFamily)),
                          ),
                        ],
                      ),
                    ),
                    Obx(() => Container(
                      // height: height/9,
                      width: width,
                      // color: controller.colorPrimary.value.withOpacity(0.5),
                      padding:
                      const EdgeInsets
                          .all(10),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          Text(
                            'Total A Payer',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: GoogleFonts
                                    .nunito()
                                    .fontFamily,
                                fontWeight:
                                FontWeight
                                    .bold),
                          ),
                          Container(
                            height:
                                height / 14,
                            width: width,
                            decoration:
                            BoxDecoration(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  10),
                              border: Border.all(
                                  color: controller
                                      .colorPrimary
                                      .value,
                                  width: 1),
                            ),
                            alignment: Alignment.center,
                            child: Text('${Helpers.formatPrice(controller.getTotalaPayer())} Frs CFA', style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.nunito().fontFamily)),
                          ),
                        ],
                      ),
                    )),
                    const SizedBox(
                      height: 50,
                    ),

                    Obx(() => controller.reservationApiController.reservationLoading.value?Card(
                      elevation: 10,
                      child: Container(
                        height: height/15,
                        width: width,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: controller.colorSecondary.value,
                        ),
                        child: const SpinKitWave(
                        color: Colors.white,),
                      ),
                    ): MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: (){
                        controller.storeReservation();
                      }, color: controller.colorSecondary.value,
                      child: Container(
                      height: height/15,
                      width: width,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: controller.colorSecondary.value,
                      ),
                      child: Text("Valider", style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.nunito().fontFamily, fontWeight: FontWeight.bold, color: Colors.white),),
                    ),),)

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}