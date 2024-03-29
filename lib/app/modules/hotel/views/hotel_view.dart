import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/app/widgets/text_widget.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../controllers/hotel_controller.dart';
import 'detail_hotel_view.dart';
import 'package:intl/intl.dart';
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
                                        RangeValues(0, 100000);
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
                                                .value = RangeValues(0, 100000);
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
                        //   },
                        //   child: Text('Valider'),
                        // ),
                        //                 ],
                        //               ),
                        //             );
                        //           },
                        //f         );
                        //       },
                        //     );
                        //   },
                        //   icon: Icon(Icons.add),
                        // ),
                      ],
                    )),
                    SizedBox(height: 15.0,),
                    Text('Choisissez Votre Prix',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold)),
          Obx(() => RangeSlider(
                values: hotelController.currentRangeValues.value,
                min: 0,
                max: 100000,
                divisions: 4000,
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
                          final firstMediaUrl = hotelData.hotelsMedias!.isNotEmpty
                              ? hotelData.hotelsMedias![0]!.url
                              : '';
                          hotelController.note.value = hotelData.id!;
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
                                  alignement: TextAlign.left,
                                ),
                                trailing: Icon(Icons.arrow_right),
                                subtitle: Row(
                                  children: <Widget>[
                                    TextWidget(
                                  text: '${NumberFormat.decimalPattern('fr_FR').format(hotelData.prix)} FCFA ',
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  alignement: TextAlign.left,
                                ),
                                SizedBox(width: 5.0),
                                 Visibility(
                                  visible:hotelData.moyenneHotel!=null ,
                                  child: TextWidget(
                                  text: ' - ',
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  alignement: TextAlign.left,
                                  ) ,
                                ),
                                SizedBox(width: 5.0),
                                 Visibility(
                                  visible:hotelData.moyenneHotel!=null ,
                                  child: TextWidget( 
                                  text: '${hotelData.moyenneHotel}',
                                  color: Colors.green,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                  alignement: TextAlign.left,
                                  ) ,
                                ),
                               Visibility(
                                  visible:hotelData.moyenneHotel!=null ,
                                  child:  Icon(Icons.star_half_sharp, color:Colors.amber[800], size:25)
                                 )     
                                       
                                ],),
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
