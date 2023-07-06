import 'dart:developer';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/main_controller.dart';
import '../../../models/hotelAll.dart';
import '../../../widgets/text_widget.dart';
import '../../home/views/home_view.dart';
import '../controllers/hotel_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class DetailHotelView extends GetView {
  final HotelModel data;
  const DetailHotelView({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HotelController hotelController = Get.put(HotelController());
    final MainController settingsCtrl = Get.find();
   List listMedia =  data.medias!.map((element) {
     return element.url;
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
                        autoPlayInterval: Duration(seconds: 5),
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
                              fontSize: 30,
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
                          SizedBox(height: 20),
                          TextField(
                            controller: TextEditingController(
                                text: '${data.typeQuartierId?.toString()}'),
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Lieu',
                              prefixIcon: Icon(FontAwesomeIcons.map),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: TextEditingController(
                                text: '${data.typeHotelId?.toString()}'),
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Type d`\'hotel',
                              prefixIcon: Icon(FontAwesomeIcons.hotel),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller:
                                TextEditingController(text: '${data.prix} CFA'),
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Prix',
                              prefixIcon: Icon(FontAwesomeIcons.moneyBillWave),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),

                          InkWell(
                            onTap: () {
                              // Action à effectuer lorsque le TextField est tapé
                              // Insérez votre code ici
                              print('TextField tapé !');
                              hotelController.showAlerte(data.numeroHotel.toString());

                            },
                            child: TextField(
                              controller: TextEditingController(text: data.numeroHotel),
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'Numéro 1',
                                prefixIcon: Icon(FontAwesomeIcons.phone),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              // Action à effectuer lorsque le TextField est tapé
                              // Insérez votre code ici
                              print('TextField tapé !');
                              hotelController.showAlerte(data.contact.toString());

                            },
                            child: TextField(
                              controller: TextEditingController(text: data.contact),
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'Numéro 2',
                                prefixIcon: Icon(FontAwesomeIcons.mobile),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              // Action à effectuer lorsque le TextField est tapé
                              // Insérez votre code ici
                              print('TextField tapé !');
                              launchUrl(Uri.parse(data.lienMap.toString()));

                            },
                            child: TextField(
                              controller:  TextEditingController(text: data.lienMap),
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'Lien de map',
                                prefixIcon: Icon(FontAwesomeIcons.mapLocation),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),

                           SizedBox(height: 10),
                           TextField(
                            controller:
                            TextEditingController(text: data.linkedIn),
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'LinkedIn',
                              prefixIcon: Icon(FontAwesomeIcons.linkedinIn),
                              border: OutlineInputBorder(),
                            ),
                          ),
                           SizedBox(height: 10),
                           TextField(
                            controller:
                            TextEditingController(text: data.instagram),
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Instagram',
                              prefixIcon: Icon(FontAwesomeIcons.instagram),
                              border: OutlineInputBorder(),
                            ),          
                          ),
                           SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              // Action à effectuer lorsque le TextField est tapé
                              // Insérez votre code ici
                              print('TextField tapé !');
                              launchUrl(Uri.parse(data.siteInternet.toString()));
                            },
                            child:  TextField(

                              controller:
                              TextEditingController(text: data.siteInternet),
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'Site Internet',
                                prefixIcon: Icon(FontAwesomeIcons.internetExplorer),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),

                      SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              // Action à effectuer lorsque le TextField est tapé
                              // Insérez votre code ici
                              print('TextField tapé !');
                              launchUrl(Uri.parse(data.facebook.toString()));
                            },
                            child:TextField(
                                controller:
                                TextEditingController(text: data.facebook),
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Facebook',
                                  prefixIcon: Icon(FontAwesomeIcons.facebook),
                                  border: OutlineInputBorder(),
                                )
                            )
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
