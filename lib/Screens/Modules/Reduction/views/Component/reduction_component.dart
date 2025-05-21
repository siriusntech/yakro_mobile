import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Providers/controllers/reservation_api_controller.dart';
// import 'package:jaime_yakro/Screens/Modules/Reduction/reduction_path.dart';
import 'package:jaime_yakro/Screens/Widgets/alert_dialog_windget.dart';
import 'package:quickalert/quickalert.dart';
// import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class ReductionComponent extends StatefulWidget {
  const ReductionComponent({super.key});

  @override
  State<ReductionComponent> createState() => _ReductionComponentState();
}

class _ReductionComponentState extends State<ReductionComponent> {
  final Color navigationBarColor = Colors.white;
  final controller = Get.put(ReservationApiController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
            // color: Colors.amber
            ),
        child: SizedBox(
            height: height,
            width: width,
            child: Obx(
              () => controller.listeReservationLoading.value
                  ? const Center(
                      child: SpinKitDoubleBounce(
                      color: Color(0xFF0D5CCC),
                    ))
                  : controller.listReservationModel.isEmpty
                      ? Center(
                          child: Text(
                            'Aucune réservation disponible',
                            style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 6,
                          ),
                          itemCount: controller.listReservationModel.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text('Information',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: GoogleFonts.taprom()
                                                    .fontFamily,
                                                fontSize: 30)),
                                        content: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.5,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                '${controller.listReservationModel[index]!.hotel['nom_hotel']}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        GoogleFonts.nunito()
                                                            .fontFamily,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                '${controller.listReservationModel[index]!.nom} ${controller.listReservationModel[index]!.prenoms}',
                                                style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        GoogleFonts.nunito()
                                                            .fontFamily,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                'du ${controller.listReservationModel[index]!.dateDebut!.day}/${controller.listReservationModel[index]!.dateDebut!.month}/${controller.listReservationModel[index]!.dateDebut!.year} au ${controller.listReservationModel[index]!.dateFin!.day}/${controller.listReservationModel[index]!.dateFin!.month}/${controller.listReservationModel[index]!.dateFin!.year}',
                                                style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        GoogleFonts.nunito()
                                                            .fontFamily,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                  "${controller.listReservationModel[index]!.nuitees} nuitees",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.nunito()
                                                            .fontFamily,
                                                    fontSize: 18,
                                                  )),
                                              Text(
                                                  "${controller.listReservationModel[index]!.nbrChambre} chambre(s)",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.nunito()
                                                            .fontFamily,
                                                    fontSize: 18,
                                                  )),
                                              Text(
                                                'Prix Unitaire: ${controller.listReservationModel[index]!.prixUnitaire} F CFA',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        GoogleFonts.nunito()
                                                            .fontFamily,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                'Prix Total: ${controller.listReservationModel[index]!.prixTotal} F CFA',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        GoogleFonts.nunito()
                                                            .fontFamily,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                'Reduction: ${controller.listReservationModel[index]!.reduction} %',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        GoogleFonts.nunito()
                                                            .fontFamily,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                'Total à Payer: ${controller.listReservationModel[index]!.prixTotalAPayer} F CFA',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        GoogleFonts.nunito()
                                                            .fontFamily,
                                                    fontSize: 18),
                                              ),
                                              Container(
                                                height: 40,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: controller
                                                              .listReservationModel[
                                                                  index]!
                                                              .status ==
                                                          "en attente"
                                                      ? Colors.amber
                                                      : controller
                                                                  .listReservationModel[
                                                                      index]!
                                                                  .status ==
                                                              'validé'
                                                          ? Colors.green
                                                          : Colors.red,
                                                ),
                                                child: Text(
                                                  '${controller.listReservationModel[index]!.status}',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          controller
                                                      .listReservationModel[
                                                          index]!
                                                      .status ==
                                                  'en attente'
                                              ? MaterialButton(
                                                  color: Color(0xFF0D5CCC),
                                                  onPressed: () =>
                                                      quickAlertDialog(
                                                        context,
                                                        QuickAlertType.confirm,
                                                        color:
                                                            Color(0xFF0D5CCC),
                                                        message:
                                                            "Voulez-vous annuler cette reservation ?",
                                                        title: "Annuler",
                                                        onConfirmBtnTap: () =>
                                                            controller.cancelReservation(
                                                                controller
                                                                    .listReservationModel[
                                                                        index]!
                                                                    .id!),
                                                      ),
                                                  child: Text(
                                                      'Annuler la reservation',
                                                      style: TextStyle(
                                                          color: Colors.white)))
                                              : Text(""),
                                          TextButton(
                                              onPressed: () => Get.back(),
                                              child: Text('Fermer',
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xFF0D5CCC)))),
                                        ],
                                      ));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                height: height / 7,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: Colors.red,
                                ),
                                child: Row(children: [
                                  Container(
                                    height: height / 8,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: controller
                                                  .listReservationModel[index]!
                                                  .status ==
                                              "en attente"
                                          ? Colors.amber
                                          : controller
                                                      .listReservationModel[
                                                          index]!
                                                      .status ==
                                                  'validé'
                                              ? Colors.green
                                              : Colors.red,
                                    ),
                                    child: Text(
                                      '${controller.listReservationModel[index]!.status}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily:
                                              GoogleFonts.nunito().fontFamily,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  '${controller.listReservationModel[index]!.nom} ${controller.listReservationModel[index]!.prenoms}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.nunito()
                                                            .fontFamily,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              Text(
                                                  '${controller.listReservationModel[index]!.hotel['nom_hotel']}'),
                                              Text(
                                                  '${controller.listReservationModel[index]!.dateDebut!.day}-${controller.listReservationModel[index]!.dateDebut!.month}-${controller.listReservationModel[index]!.dateDebut!.year} - ${controller.listReservationModel[index]!.dateFin!.day}-${controller.listReservationModel[index]!.dateFin!.month}-${controller.listReservationModel[index]!.dateFin!.year}'),
                                              Text(
                                                  'Reductions: ${controller.listReservationModel[index]!.hotel['reductions']}%'),
                                            ])),
                                  )
                                ]),
                              ),
                            ),
                          ),
                        ),
            )),
      ),
    );
  }
}
