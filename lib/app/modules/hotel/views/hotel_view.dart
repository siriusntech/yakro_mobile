import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/widgets/text_widget.dart';
import '../../../controllers/main_controller.dart';
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
        title: TextWidget(
            text: 'Hotels',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white),
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
      body: Column(
        children: [
          SizedBox(height: 5.0),
          Obx(() => controller.isDataProcessingTypeHotel.value
              ? LoadingWidget()
              : controller.hotelAllTypeHotel.isEmpty
                  ? NoDataWidget()
                  : Row(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(height: 15.0),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FilterChip(
                                  label: Text("Tout"),
                                  onSelected: (onSelected) {
                                    controller.currentRangeValues.value =
                                        RangeValues(0, 200000);
                                    hotelController.type_hotel_selected.value =
                                        0;
                                    hotelController.getHotelsFiltragePrix();
                                  },
                                  selected: hotelController
                                          .type_hotel_selected.value ==
                                      0,
                                ),
                              ),
                              ...controller.hotelAllTypeHotel
                                  .map((typeHotels) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: FilterChip(
                                          label:
                                              Text(typeHotels.lieu!.toString()),
                                          onSelected: (onSelected) {
                                            controller.currentRangeValues
                                                .value = RangeValues(0, 200000);
                                            hotelController.type_hotel_selected
                                                .value = typeHotels.id!;
                                            hotelController
                                                .getHotelsFiltragePrix();
                                          },
                                          selected: hotelController
                                                  .type_hotel_selected.value ==
                                              typeHotels.id!,
                                        ),
                                      ))
                            ],
                          ),
                        ),
                        // IconButton(
                        //   onPressed: () {
                        //     showModalBottomSheet(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return StatefulBuilder(
                        //           builder: (BuildContext context, setState) {
                        //             return Container(
                        //               height: 150,
                        //               color: Colors.white,
                        //               child: Column(
                        //                 children: [
                        //                   Text('Choisissez Votre Prix',
                        //                       style: TextStyle(
                        //                           fontSize: 26.0,
                        //                           fontWeight: FontWeight.bold)),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     hotelController
                        //         .getHotelsFiltragePrix();
                        //     Navigator.pop(context);
                        //   },
                        //   child: Text('Valider'),
                        // ),
                        //                 ],
                        //               ),
                        //             );
                        //           },
                        //         );
                        //       },
                        //     );
                        //   },
                        //   icon: Icon(Icons.add),
                        // ),
                      ],
                    )),
          Obx(() => RangeSlider(
                values: hotelController.currentRangeValues.value,
                min: 0,
                max: 200000,
                divisions: 50000,
                labels: RangeLabels(
                  hotelController.currentRangeValues.value.start
                      .round()
                      .toString(),
                  hotelController.currentRangeValues.value.end
                      .round()
                      .toString(),
                ),
                onChanged: (RangeValues values) {
                  // setState(() {
                  hotelController.currentRangeValues.value = values;
                  // });
                },
              )),
          ElevatedButton(
            onPressed: () {
              hotelController.getHotelsFiltragePrix();
              Navigator.pop(context);
            },
            child: Text('Valider'),
          ),
          Obx(() => controller.isDataProcessing.value
              ? LoadingWidget()
              : controller.hotelListAllFiltragePrix.isEmpty
                  ? NoDataWidget()
                  : Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount:
                            hotelController.hotelListAllFiltragePrix.length,
                        itemBuilder: (context, index) {
                          final hotelData =
                              hotelController.hotelListAllFiltragePrix[index];
                          final firstMediaUrl = hotelData.medias!.isNotEmpty
                              ? hotelData.medias![0].url
                              : '';
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                onTap: () {
                                  Get.to(
                                    DetailHotelView(
                                      data: hotelData,
                                    ),
                                  );
                                },
                                title: TextWidget(
                                  text: hotelData.nomHotel!,
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  alignement: TextAlign.center,
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
                                          firstMediaUrl.toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )),
        ],
      ),
    );
  }
}
