import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Hotel/path_hotel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelSingleScreen extends StatefulWidget {
  const HotelSingleScreen({super.key, this.hotelModel});
  final HotelModel? hotelModel;
  @override
  State<HotelSingleScreen> createState() => _HotelSingleScreenState();
}

class _HotelSingleScreenState extends State<HotelSingleScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // final HotelController controllerHotel = Get.put(HotelController());
    final HotelScreenController controllerHotelScreeen =
        Get.put(HotelScreenController());
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Container(
              height: height / 3,
              width: width,
              decoration: const BoxDecoration(),
              child: PageViewHotelSingle(
                hotelModel: widget.hotelModel,
              ),
            ),
            DetailHotelSingleComponent(
              hotelModel: widget.hotelModel,
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppConfig.paddingBody),
        height: 80,
        width: width,
        decoration: BoxDecoration(
            color: controllerHotelScreeen.colorPrimary.value,
            borderRadius: BorderRadius.circular(AppConfig.bottomRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Text(
                'A partir de ${widget.hotelModel!.prix.toString()} FCFA',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: GoogleFonts.nunito().fontFamily,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                launchUrl(
                  Uri.parse("tel:${widget.hotelModel!.numeroHotel}"),
                );
              },
              child: Text(
                'Contactez',
                style: TextStyle(
                    color: controllerHotelScreeen.colorPrimary.value,
                    fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}
