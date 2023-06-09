import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/Utils/app_colors.dart';

import '../controllers/hotel_controller.dart';

class HotelView extends GetView<HotelController> {
  const HotelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HotelController hotelController = Get.put(HotelController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('HotelView'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (hotelController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: hotelController.hotelList.length,
            itemBuilder: (context, index) {
              final hotelData = hotelController.hotelList[index];


              return Column(
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        width: 120,
                        height: 80,
                        margin: EdgeInsets.fromLTRB(16, 8.0, 8.0, 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          // child: Image.network(
                          //   hotelData.NomHotel ?? '',
                          //   width: 120,
                          //   height: 80,
                          //   fit: BoxFit.fill,
                          //   color: AppColors.vert_colorFonce,
                          //   colorBlendMode: BlendMode.color,
                          // ),
                        ),
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(hotelData.nomHotel ?? 'No Name'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }
      }),
    );
  }
}
