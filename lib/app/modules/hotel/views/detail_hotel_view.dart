import 'dart:developer';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/data/repository/data/Env.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/text_widget.dart';
import '../../home/views/home_view.dart';
import '../controllers/hotel_controller.dart';
import '../hotel_model_model.dart';

class DetailHotelView extends GetView {
  final DataHotelModel data;
  const DetailHotelView({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HotelController hotelController = Get.put(HotelController());
    final MainController settingsCtrl = Get.find();
   List listMedia =  data.medias!.map((element) {
     return element.url!;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        title: TextWidget(
          text: 'Détail de l\'hotel',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await hotelController.refreshData();
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: Obx(() {
        return hotelController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 3500),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                      ),
                      items: generateSlider(listMedia),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.nomHotel!,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            data.description!,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 35),
                          TextField(
                            controller: TextEditingController(
                                text: '${data.typeQuartierId} CFA'),
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Lieu',
                              prefixIcon: Icon(Icons.map_sharp),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: TextEditingController(
                                text: '${data.typeHotelId}'),
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Type d`\'hotel',
                              prefixIcon: Icon(Icons.type_specimen_rounded),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller:
                                TextEditingController(text: '${data.prix} CFA'),
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Prix',
                              prefixIcon: Icon(Icons.price_change),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller:
                                TextEditingController(text: data.numeroHotel),
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Numéro 1',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller:
                                TextEditingController(text: data.contact),
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Numéro 2',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
