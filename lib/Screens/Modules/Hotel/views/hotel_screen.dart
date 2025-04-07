import 'package:flutter/material.dart';
import 'package:jaime_yakro/Screens/Modules/Hotel/path_hotel.dart';
import 'package:jaime_yakro/Screens/Widgets/dialog.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HotelScreen extends GetView<HotelScreenController> {
  const HotelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: controller.colorPrimary.value,
        title: Text('${controller.title.value} Yakro',
            style: TextStyle(
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.taprom().fontFamily)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await showSearch(
                  context: context,
                  delegate: HotelSearchComponent(),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.typeHotelController.onInit();
          showDialog(
              context: context,
              builder: (_) => FiltreHotel(
                  typeHotelsList:
                      controller.typeHotelController.typeHotelsList.value));
        },
        backgroundColor: controller.colorSecondary.value,
        child: const Icon(
          Icons.filter_alt_outlined,
          color: Colors.white,
        ),
      ),
      body: const HotelComponent(),
    );
  }
}
