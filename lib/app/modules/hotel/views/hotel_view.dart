import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/widgets/text_widget.dart';
import '../../../controllers/main_controller.dart';
import '../../../data/repository/data/Env.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
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
        title: TextWidget(text: 'Hotels', fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
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
        if(controller.isDataProcessing.value == true){
          return LoadingWidget();
        }else {
          if(controller.hotelList.length == 0){
            return NoDataWidget();
          } else {
            return ListView.builder(
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
                                   hotelData.imageUrl!),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        }
      }),
    );
  }
}
