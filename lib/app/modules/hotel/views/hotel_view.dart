import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/Utils/app_colors.dart';
import 'package:jaime_cocody/app/widgets/text_widget.dart';
import '../../../controllers/main_controller.dart';
import '../controllers/hotel_controller.dart';
import 'detail_hotel_view.dart';

class HotelView extends GetView<HotelController> {
  const HotelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HotelController hotelController = Get.put(HotelController());
    final MainController settingsCtrl = Get.find();
    return Scaffold(
       appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: settingsCtrl.vert_color_fonce,
      title: TextWidget(text: 'Hotels', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await controller.refreshData();
          },
          icon: Icon(Icons.refresh, color: Colors.white, size: 30),
        )
      ],
    ),
      body: Obx(() {
        return hotelController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: hotelController.hotelList.length,
                itemBuilder: (context, index) {
                  final hotelData = hotelController.hotelList[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () {
                          Get.to(DetailHotelView(
                            data: hotelData,
                          ));
                        },
                        title: TextWidget(
                          text: hotelData.nomHotel!,
                          color: Colors.black,
                          fontSize: 19, fontWeight: FontWeight.bold, alignement: TextAlign.center,
                        ),
                        trailing: Icon(Icons.arrow_right),
                        subtitle: Text(
                          hotelData.description!,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://www.parisinfo.com/var/otcp/sites/images/media/1.-photos/03.-hebergement-630-x-405/hotel-enseigne-neon-630x405-c-thinkstock/31513-1-fre-FR/Hotel-enseigne-neon-630x405-C-Thinkstock.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ],
                  );
                },
              );
      }),
    );
  }
}
