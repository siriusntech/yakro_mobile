import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Hotel/path_hotel.dart';
import 'package:jaime_yakro/Screens/Modules/Reduction/controllers/reservation_screen_controller.dart';

import '../../../../../../routes/path_route.dart';

class CardHotelElement extends StatefulWidget {
  const CardHotelElement(
      {super.key, required this.onTap, required this.hotelModel});

  final Callback onTap;
  final HotelModel hotelModel;
  @override
  State<CardHotelElement> createState() => _CardHotelElementState();
}

class _CardHotelElementState extends State<CardHotelElement> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final HotelScreenController controllerHotelScreeen =
        Get.put(HotelScreenController());
    final HotelController controllerHotel = Get.put(HotelController());
    final ReservationScreenController controllerReservation =
        Get.put(ReservationScreenController());
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConfig.cardRadius),
            color: controllerHotelScreeen.colorPrimary.value.withOpacity(0.17)),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height / 3.5,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppConfig.cardRadius),
                      color: controllerHotelScreeen.colorPrimary.value,
                      image: DecorationImage(
                          image: NetworkImage(
                            "${widget.hotelModel.mediasModel![0].url}",
                          ),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                    right: 0,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: controllerHotelScreeen.colorPrimary.value
                              .withOpacity(0.7),
                          borderRadius:
                              BorderRadius.circular(AppConfig.cardRadius)),
                      child: Obx(() => IconButton(
                            icon: Icon(
                              widget.hotelModel.isFavorite.value
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: widget.hotelModel.isFavorite.value
                                  ? Colors.white
                                  : Colors.white,
                            ),
                            onPressed: () => controllerHotel
                                .toggleFavorite(widget.hotelModel),
                          )),
                    )),
                Obx(() => controllerHotelScreeen
                                .mainController.hotelReductionEnable.value ==
                            true &&
                        widget.hotelModel.reduction!.ceil() != 0
                    ? Positioned(
                        left: 10,
                        top: 10,
                        child: InkWell(
                          onTap: () {
                            controllerHotelScreeen.hotelSingleScreenController
                                .setHotelModel(widget.hotelModel);
                            controllerReservation.setAuthModel(
                                controllerHotelScreeen
                                    .authController.authModel.value);
                            controllerReservation.setModuledata({
                              "Module": "hotel_code",
                              "IdModule": widget.hotelModel.code,
                            });
                            controllerReservation.onInit();
                            Get.toNamed(AppRoutes.typeChambreHotelScreen);
                          },
                          child: Container(
                            height: 35,
                            // width: 140,
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: ConstColors.alertDanger.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(
                                    AppConfig.cardRadius)),
                            child: Text(
                                "Profitez ${controllerHotelScreeen.mainController.hotelReductionEnable.value.toString()} de - ${widget.hotelModel.reduction!.ceil()}%",
                                style: TextStyle(
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white)),
                          ),
                        ))
                    : Container())
              ],
            ),
            Container(
              padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width / 1.5,
                        child: Text(
                          widget.hotelModel.nomHotel.toString(),
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        // width: 60,
                        // color: Colors.amber,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                            ),
                            Text('',
                                style: TextStyle(
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            Obx(() => Text(
                                '(${widget.hotelModel.countFavoris.value})',
                                style: TextStyle(
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17)))
                          ],
                        ),
                      )
                    ],
                  ),
                  Text(
                    'contact: ${widget.hotelModel.numeroHotel.toString()}',
                    style: TextStyle(
                      fontFamily: GoogleFonts.nunito().fontFamily,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    'A partir de ${widget.hotelModel.prix.toString()} FCFA',
                    style: TextStyle(
                      fontFamily: GoogleFonts.anuphan().fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
