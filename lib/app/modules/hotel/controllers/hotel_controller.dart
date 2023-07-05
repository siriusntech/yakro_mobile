import 'dart:developer';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/data/repository/hotel_services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Utils/app_constantes.dart';
import '../../../models/hotelAll.dart';
import '../../../models/typeHotel.dart'; 
import '../../../widgets/text_widget.dart';

class HotelController extends GetxController {
  var isLoading = true.obs;

  var currentRangeValues = RangeValues(1,100000).obs;
  // var hotelList = <HotelModel>[].obs;

  // var hotelList = List<HotelModel>.empty(growable: true).obs;
  // var selectedHotels = HotelModel().obs;
  var selectedHotels = <HotelModel>[].obs;
  var isDataProcessing = false.obs;
  var selectedType = ''.obs;
  final count = 0.obs;

  // final hotelList = <DataHotelModel>[] .obs; // Utilisez une RxList pour observer les changements
  final hotelListAllFiltragePrix = <HotelModel>[].obs;
  final hotelAllTypeHotel = <TypeHotelByHotels>[].obs;
  final type_hotel_selected = 0.obs;

  final ButtonStyle buttonStyle = ButtonStyle(
      side: MaterialStateProperty.all(BorderSide(color: Colors.red)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))));

  Future<Null> showAlerte(phoneNumber) async {
    Get.defaultDialog(
        title: "",
        content: Container(
          width: 100,
          height: 100,
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                  makePhoneCall('tel:$phoneNumber');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ICON_TELEPHONE,
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    TextWidget(
                      text: 'Appeler',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      alignement: TextAlign.center,
                    )
                  ],
                ),
                style: buttonStyle,
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  makeCopieNumber(phoneNumber);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ICON_COPIE,
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    TextWidget(
                        text: 'Copier',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        alignement: TextAlign.center)
                  ],
                ),
                style: buttonStyle,
              ),
            ],
          ),
        ),
        contentPadding: EdgeInsets.all(0.0),
        titlePadding: EdgeInsets.all(0.0));
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    // final Uri launchUri = Uri(
    //   scheme: 'tel',
    //   path: phoneNumber,
    // );
    // await launch(launchUri.toString());
    await launchUrl(Uri.parse(phoneNumber));
  }

  Future<void> makeCopieNumber(String phoneNumber) async {
    FlutterClipboard.copy(phoneNumber).then((result) {
      Get.snackbar('', "Contact Copié dans le presse-papier",
          snackPosition: SnackPosition.BOTTOM);
    });
  }


  // SHOW SNACKBAR
  showSnackBar(String title, String message, Color bgColor) {
    Get.snackbar(title, message,
        backgroundColor: bgColor,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white);
  }

void updateCurrentRangeValues(double start, double end) {
  currentRangeValues.value = RangeValues(start, end);
}


  @override
  void onInit() {
    super.onInit();
    // getHotels();
    getHotelsFiltragePrix();
    getButtonTypeHotel();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> getHotelsFiltragePrix() async {
    isDataProcessing(true);
    final response = await HotelServices.getHotelsFiltragePrix(
        type_hotel_selected.value,
        currentRangeValues.value.start.toInt().toString(),
        currentRangeValues.value.end.toInt().toString());
    hotelListAllFiltragePrix.value = response;
    isLoading.value = false;
    isDataProcessing(false);
    // print("Exception  " + ex.toString());
    isLoading.value = false;
  }

  Future<void> getButtonTypeHotel() async {
    isDataProcessing(true);
    final response = await HotelServices.getButtonTypeHotel();
    hotelAllTypeHotel.value = response;
    inspect(response);
    isDataProcessing(false);
    isLoading.value = false;
  }

  // REFRESH PAGE
  refreshData() async {
    // hotelList.clear();
    // await getHotels();
    await getHotelsFiltragePrix();
    await getButtonTypeHotel();
  }
}
