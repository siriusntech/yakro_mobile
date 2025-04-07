import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Commerce/path_commerce.dart';
import 'package:jaime_yakro/Screens/Modules/Hotel/path_hotel.dart';
import 'package:jaime_yakro/Screens/Modules/Pharmacie/path_pharmacie.dart';
import 'package:jaime_yakro/Screens/Modules/SiteTourisme/path_tourisme.dart';

/// FILTRE HOTEL
class FiltreHotel extends StatefulWidget {
  FiltreHotel({super.key, this.typeHotelsList});
  List<TypeHotelModel>? typeHotelsList = [];
  @override
  State<FiltreHotel> createState() => _FiltreHotelState();
}

class _FiltreHotelState extends State<FiltreHotel> {
  final HotelScreenController controller = Get.put(HotelScreenController());
  TypeHotelModel? typeHotelModel;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choisissez'),
      content: Container(
        padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        child: Obx(() => controller.isLoading.value == false
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        // color: Colors.amber,
                        ),
                    child: Column(
                      children: [
                        Text(
                          'Prix',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: GoogleFonts.nunito().fontFamily),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              RangeSlider(
                                values: controller
                                    .hotelController.currentRangeValues.value,
                                min: 0,
                                max: 300000,
                                divisions: 5000,
                                activeColor: const Color(0xff3D81B0),
                                labels: RangeLabels(
                                  controller.hotelController.currentRangeValues
                                      .value.start
                                      .round()
                                      .toString(),
                                  controller.hotelController.currentRangeValues
                                      .value.end
                                      .round()
                                      .toString(),
                                ),
                                onChanged: (RangeValues values) {
                                  // setState(() {
                                  controller.hotelController.currentRangeValues
                                      .value = values;
                                  // print(controller
                                  //     .hotelController.currentRangeValues);
                                  // });
                                },
                              ),
                              Text(
                                '${controller.hotelController.currentRangeValues.value.start.ceil()} - ${controller.hotelController.currentRangeValues.value.end.ceil()} (FCFA)',
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(),
                    child: Column(children: [
                      Text(
                        'Type Hotel',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: GoogleFonts.nunito().fontFamily),
                      ),
                      Expanded(
                          child: widget.typeHotelsList!.isNotEmpty
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButton<TypeHotelModel>(
                                    isExpanded: true,
                                    value: typeHotelModel,
                                    items: widget.typeHotelsList!
                                        .map((TypeHotelModel? type) {
                                      return DropdownMenuItem<TypeHotelModel>(
                                        value: type,
                                        child: Text(type!.libelle!),
                                      );
                                    }).toList(),
                                    onChanged: (TypeHotelModel? newValue) {
                                      setState(() {
                                        typeHotelModel = newValue!;
                                      });
                                    },
                                  ),
                                )
                              : SizedBox(
                                  child: Text(
                                    'Aucun type trouvé',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontFamily:
                                            GoogleFonts.nunito().fontFamily),
                                  ),
                                ))
                    ]),
                  )
                ],
              )
            : const Center(
                child: SpinKitDoubleBounce(
                  color: Color(0xff3D81B0),
                  size: 50,
                  duration: Duration(seconds: 1),
                ),
              )),
      ),
      actions: [
        MaterialButton(
            color: ConstColors.alertDanger,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Fermer',
              style: TextStyle(color: ConstColors.appbarTextColor),
            )),
        MaterialButton(
            color: controller.colorPrimary.value,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              controller.isLoading.value = true;
              // print([
              //   typeHotelModel,
              //   controller.hotelController.currentRangeValues.value
              // ]);
              Future.delayed(const Duration(seconds: 3), () {
                if (typeHotelModel != null) {
                  controller.hotelController
                      .postFiltreParTypeHotel(typeHotelModel!.id.toString());
                } else if (typeHotelModel == null) {
                  controller.hotelController.postFiltreParPrix();
                }
                controller.isLoading.value = false;
                Get.back();
              });
            },
            child: const Text(
              'Rechercher',
              style: TextStyle(color: ConstColors.appbarTextColor),
            ))
      ],
    );
  }
}

/// FILTRE COMMERCE

class FiltreCommerce extends StatefulWidget {
  FiltreCommerce(
      {super.key, this.typeCommercesList, this.specialiteCommerceListFilter});
  List<TypeCommerceModel>? typeCommercesList = [];
  List<SpecialiteCommerceModel>? specialiteCommerceListFilter = [];
  @override
  State<FiltreCommerce> createState() => _FiltreCommerceState();
}

class _FiltreCommerceState extends State<FiltreCommerce> {
  final CommerceScreenController controller =
      Get.put(CommerceScreenController());
  TypeCommerceModel? typeCommerceModel;
  SpecialiteCommerceModel? specialiteCommerceModel;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choisissez'),
      content: Container(
        padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        child: Obx(() => controller.isLoading.value == false
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(),
                    child: Column(children: [
                      Text(
                        'Type Commerce',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: GoogleFonts.nunito().fontFamily),
                      ),
                      Expanded(
                          child: widget.typeCommercesList!.isNotEmpty
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButton<TypeCommerceModel>(
                                    isExpanded: true,
                                    value: typeCommerceModel,
                                    items: widget.typeCommercesList!
                                        .map((TypeCommerceModel? type) {
                                      return DropdownMenuItem<
                                          TypeCommerceModel>(
                                        value: type,
                                        child: Text(type!.nomType!),
                                      );
                                    }).toList(),
                                    onChanged: (TypeCommerceModel? newValue) {
                                      setState(() {
                                        typeCommerceModel = newValue!;
                                      });
                                    },
                                  ),
                                )
                              : SizedBox(
                                  child: Text(
                                    'Aucun type trouvé',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontFamily:
                                            GoogleFonts.nunito().fontFamily),
                                  ),
                                ))
                    ]),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(),
                    child: Column(children: [
                      Text(
                        'Spécialite',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: GoogleFonts.nunito().fontFamily),
                      ),
                      Expanded(
                          child: widget.specialiteCommerceListFilter!.isNotEmpty
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child:
                                      DropdownButton<SpecialiteCommerceModel>(
                                    isExpanded: true,
                                    value: specialiteCommerceModel,
                                    items: widget.specialiteCommerceListFilter!
                                        .map((SpecialiteCommerceModel? type) {
                                      return DropdownMenuItem<
                                          SpecialiteCommerceModel>(
                                        value: type,
                                        child: Text(type!.libelle!),
                                      );
                                    }).toList(),
                                    onChanged:
                                        (SpecialiteCommerceModel? newValue) {
                                      setState(() {
                                        specialiteCommerceModel = newValue!;
                                      });
                                    },
                                  ),
                                )
                              : SizedBox(
                                  child: Text(
                                    'Aucune Spécialité trouvé',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontFamily:
                                            GoogleFonts.nunito().fontFamily),
                                  ),
                                ))
                    ]),
                  )
                ],
              )
            : Center(
                child: SpinKitDoubleBounce(
                  color: controller.colorPrimary.value,
                  size: 50,
                  duration: const Duration(seconds: 1),
                ),
              )),
      ),
      actions: [
        MaterialButton(
            color: ConstColors.alertDanger,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Fermer',
              style: TextStyle(color: ConstColors.appbarTextColor),
            )),
        MaterialButton(
            color: controller.colorPrimary.value,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              controller.isLoading.value = true;

              Future.delayed(const Duration(seconds: 3), () {
                if (specialiteCommerceModel != null &&
                    typeCommerceModel != null) {
                  controller.commerceController
                      .postFiltreParSpecialiteEtTypeCommerce(
                          specialiteCommerceModel!.id.toString(),
                          typeCommerceModel!.id.toString());
                } else if (specialiteCommerceModel != null) {
                  controller.commerceController.postFiltreParSpecialite(
                    specialiteCommerceModel!.id.toString(),
                  );
                } else if (typeCommerceModel != null) {
                  controller.commerceController.postFiltreParTypeCommerce(
                      typeCommerceModel!.id.toString());
                }
                controller.isLoading.value = false;
                Get.back();
              });
            },
            child: const Text(
              'Rechercher',
              style: TextStyle(color: ConstColors.appbarTextColor),
            ))
      ],
    );
  }
}

/// FILTRE PHARMACIE

class FiltrePharmacie extends StatefulWidget {
  FiltrePharmacie({super.key, this.zoneList});
  List<ZoneModel>? zoneList = [];
  @override
  State<FiltrePharmacie> createState() => _FiltrePharmacieState();
}

class _FiltrePharmacieState extends State<FiltrePharmacie> {
  final PharmacieScreenController controller =
      Get.put(PharmacieScreenController());
  ZoneModel? zoneModel;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choisissez'),
      content: Container(
        padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width,
        child: Obx(() => controller.pharmacieLoading.value == false
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(),
                    child: Column(children: [
                      Text(
                        'Zone',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: GoogleFonts.nunito().fontFamily),
                      ),
                      Expanded(
                          child: widget.zoneList!.isNotEmpty
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButton<ZoneModel>(
                                    isExpanded: true,
                                    value: zoneModel,
                                    items:
                                        widget.zoneList!.map((ZoneModel? type) {
                                      return DropdownMenuItem<ZoneModel>(
                                        value: type,
                                        child: Text(type!.nom!),
                                      );
                                    }).toList(),
                                    onChanged: (ZoneModel? newValue) {
                                      setState(() {
                                        zoneModel = newValue!;
                                      });
                                    },
                                  ),
                                )
                              : SizedBox(
                                  child: Text(
                                    'Aucun type trouvé',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontFamily:
                                            GoogleFonts.nunito().fontFamily),
                                  ),
                                ))
                    ]),
                  )
                ],
              )
            : Center(
                child: SpinKitDoubleBounce(
                  color: controller.colorPrimary.value,
                  size: 50,
                  duration: const Duration(seconds: 1),
                ),
              )),
      ),
      actions: [
        MaterialButton(
            color: ConstColors.alertDanger,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Fermer',
              style: TextStyle(color: ConstColors.appbarTextColor),
            )),
        MaterialButton(
            color: controller.colorPrimary.value,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              controller.pharmacieLoading.value = true;

              Future.delayed(const Duration(seconds: 3), () {
                if (zoneModel != null) {
                  controller.pharmacieApiControllerGetter
                      .getAllPharmacieByZone(zoneModel!.id!);
                }
                controller.pharmacieLoading.value = false;
                Get.back();
              });
            },
            child: const Text(
              'Rechercher',
              style: TextStyle(color: ConstColors.appbarTextColor),
            ))
      ],
    );
  }
}

/// FILTRE SITE TOURISTIQUE

class FiltreSiteTouristique extends StatefulWidget {
  FiltreSiteTouristique(
      {super.key, this.categorieVTList, this.specialiteCommerceListFilter});
  List<CategorieVtModel>? categorieVTList = [];
  List<SpecialiteCommerceModel>? specialiteCommerceListFilter = [];
  @override
  State<FiltreSiteTouristique> createState() => _FiltreSiteTouristiqueState();
}

class _FiltreSiteTouristiqueState extends State<FiltreSiteTouristique> {
  final SiteTourismeScreenController controller =
      Get.put(SiteTourismeScreenController());
  CategorieVtModel? categorieVtModel;
  SpecialiteCommerceModel? specialiteCommerceModel;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choisissez'),
      content: Container(
        padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
        height: MediaQuery.of(context).size.height / 3.5,
        width: MediaQuery.of(context).size.width,
        child: Obx(() => controller.isLoading.value == false
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(),
                    child: Column(children: [
                      Text(
                        'Categorie',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: GoogleFonts.nunito().fontFamily),
                      ),
                      Expanded(
                          child: widget.categorieVTList!.isNotEmpty
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButton<CategorieVtModel>(
                                    isExpanded: true,
                                    value: categorieVtModel,
                                    items: widget.categorieVTList!
                                        .map((CategorieVtModel? type) {
                                      return DropdownMenuItem<CategorieVtModel>(
                                        value: type,
                                        child: Text(type!.libelle!),
                                      );
                                    }).toList(),
                                    onChanged: (CategorieVtModel? newValue) {
                                      setState(() {
                                        categorieVtModel = newValue!;
                                      });
                                    },
                                  ),
                                )
                              : SizedBox(
                                  child: Text(
                                    'Aucune Categorie trouvé',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontFamily:
                                            GoogleFonts.nunito().fontFamily),
                                  ),
                                ))
                    ]),
                  ),
                  // Container(
                  //   height: 100,
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration: const BoxDecoration(
                  //       // color: Colors.amber,
                  //       ),
                  //   child: Column(
                  //     children: [
                  //       Text(
                  //         'Tarif',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 20,
                  //             fontFamily: GoogleFonts.nunito().fontFamily),
                  //       ),
                  //       Expanded(
                  //         child: Column(
                  //           children: [
                  //             RangeSlider(
                  //               values: controller
                  //                   .siteTouristiqueApiControllerGetter
                  //                   .currentRangeValues
                  //                   .value,
                  //               min: 0,
                  //               max: 100000,
                  //               divisions: 4000,
                  //               activeColor: controller.colorPrimary.value,
                  //               labels: RangeLabels(
                  //                 controller.siteTouristiqueApiControllerGetter
                  //                     .currentRangeValues.value.start
                  //                     .round()
                  //                     .toString(),
                  //                 controller.siteTouristiqueApiControllerGetter
                  //                     .currentRangeValues.value.end
                  //                     .round()
                  //                     .toString(),
                  //               ),
                  //               onChanged: (RangeValues values) {
                  //                 // setState(() {
                  //                 controller.siteTouristiqueApiControllerGetter
                  //                     .currentRangeValues.value = values;
                  //                 // print(controller
                  //                 //     .hotelController.currentRangeValues);
                  //                 // });
                  //               },
                  //             ),
                  //             Text(
                  //               '${controller.siteTouristiqueApiControllerGetter.currentRangeValues.value.start.ceil()} - ${controller.siteTouristiqueApiControllerGetter.currentRangeValues.value.end.ceil()} (FCFA)',
                  //             )
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )
            : Center(
                child: SpinKitDoubleBounce(
                  color: controller.colorPrimary.value,
                  size: 50,
                  duration: const Duration(seconds: 1),
                ),
              )),
      ),
      actions: [
        MaterialButton(
            color: ConstColors.alertDanger,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Fermer',
              style: TextStyle(color: ConstColors.appbarTextColor),
            )),
        MaterialButton(
            color: controller.colorPrimary.value,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              controller.isLoading.value = true;

              Future.delayed(const Duration(seconds: 3), () {
                if (categorieVtModel == null) {
                  controller.siteTouristiqueApiControllerGetter
                      .postFiltreParPrix();
                } else if (categorieVtModel != null) {
                  controller.siteTouristiqueApiControllerGetter
                      .filterByCategory(categorieVtModel!.id.toString());
                }
                controller.isLoading.value = false;
                Get.back();
              });
            },
            child: const Text(
              'Rechercher',
              style: TextStyle(color: ConstColors.appbarTextColor),
            ))
      ],
    );
  }
}
