import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Hotel/path_hotel.dart';
import 'package:get/get.dart';

class HotelComponent extends StatefulWidget {
  const HotelComponent({super.key});

  @override
  State<HotelComponent> createState() => _HotelComponentState();
}

class _HotelComponentState extends State<HotelComponent> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final HotelController controllerHotel = Get.put(HotelController());
    final HotelScreenController controllerHotelScreeen = Get.put(HotelScreenController());
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      height: height,
      width: width,
      decoration: const BoxDecoration(),
      child: RefreshIndicator(
        color: controllerHotelScreeen.colorPrimary.value,
        onRefresh: () {
          controllerHotel.getAllHotel();
          return Future.value();
        },
        child: Column(
          children: [
            const SliderHotelComponent(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Obx(() => controllerHotel.hotelLoading.value
                    ? Center(
                        child: SpinKitDoubleBounce(
                        color: controllerHotelScreeen.colorPrimary.value,
                      ))
                    : controllerHotel.hotelsList.value.isNotEmpty
                        ? ListView.separated(
                            itemBuilder: (context, index) => CardHotelElement(
                                  hotelModel:
                                      controllerHotel.hotelsList.value[index],
                                  onTap: () {

                                    controllerHotelScreeen
                                        .hotelSingleScreenController
                                        .setHotelModel(controllerHotel
                                            .hotelsList.value[index]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HotelSingleScreen(
                                                  hotelModel: controllerHotel
                                                      .hotelsList.value[index],
                                                )));
                                  },
                                ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 20,
                                ),
                            itemCount: controllerHotel.hotelsList.value.length)
                        : Center(
                            child: Text("Aucun hotel disponible",
                                style: TextStyle(
                                    color: controllerHotelScreeen
                                        .colorPrimary.value,
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontSize: 25)),
                          )))
          ],
        ),
      ),
    );
  }
}
