import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
// import 'package:jaime_yakro/Screens/Modules/Hotel/path_hotel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Screens/Modules/SiteTourisme/path_tourisme.dart';
import 'package:url_launcher/url_launcher.dart';

class SiteTourismeSingleScreen extends StatefulWidget {
  const SiteTourismeSingleScreen({super.key, this.hotelModel});
  final SiteTouristiqueModel? hotelModel;
  @override
  State<SiteTourismeSingleScreen> createState() =>
      _SiteTourismeSingleScreenState();
}

class _SiteTourismeSingleScreenState extends State<SiteTourismeSingleScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // final HotelController controllerHotel = Get.put(HotelController());
    final SiteTourismeScreenController controllerHotelScreeen =
        Get.put(SiteTourismeScreenController());
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
              child: PageViewSiteTourismeSingle(
                hotelModel: widget.hotelModel,
              ),
            ),
            DetailSiteTourismeComponent(
              siteTourismeModel: widget.hotelModel,
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
                'A partir de ${NumberFormat.currency(locale: 'fr', symbol: 'F').format(widget.hotelModel!.prix)}',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: GoogleFonts.nunito().fontFamily,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: widget.hotelModel!.contact == null
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Contact non disponible'),
                        ),
                      );
                    }
                  : () {
                      launchUrl(
                        Uri.parse("tel:${widget.hotelModel!.contact}"),
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
