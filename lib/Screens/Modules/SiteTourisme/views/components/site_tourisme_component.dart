import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Screens/Modules/SiteTourisme/path_tourisme.dart';

class SiteTourismeComponent extends StatefulWidget {
  const SiteTourismeComponent({super.key});

  @override
  State<SiteTourismeComponent> createState() => _SiteTourismeComponentState();
}

class _SiteTourismeComponentState extends State<SiteTourismeComponent> {
  final SiteTourismeScreenController controller =
      Get.put(SiteTourismeScreenController());
  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      height: height,
      width: width,
      decoration: const BoxDecoration(),
      child: RefreshIndicator(
        color: controller.colorPrimary.value,
        onRefresh: () {
          controller.siteTouristiqueApiControllerGetter.getAllSiteTouristique();
          return Future.value();
        },
        child: Obx(() => controller
                .siteTouristiqueApiControllerGetter.siteTouriqueLoading.value
            ? Center(
                child: SpinKitDoubleBounce(
                color: controller.colorPrimary.value,
              ))
            : controller.siteTouristiqueApiControllerGetter.siteTouristiqueList
                    .isNotEmpty
                ? ListView.separated(
                    itemBuilder: (context, index) => CardSiteTourismeElement(
                          siteTouristiqueModel: controller
                              .siteTouristiqueApiControllerGetter
                              .siteTouristiqueList[index],
                          onTap: () {
                            controller.siteTourismeSingleScreenControllerGetter
                                .setSiteTourismeModel(controller
                                    .siteTouristiqueApiControllerGetter
                                    .siteTouristiqueList[index]);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SiteTourismeSingleScreen(
                                          hotelModel: controller
                                              .siteTouristiqueApiControllerGetter
                                              .siteTouristiqueList[index],
                                        )));
                          },
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                    itemCount: controller.siteTouristiqueApiControllerGetter
                        .siteTouristiqueList.length)
                : Center(
                    child: Text("Aucun site Touristique disponible",
                        style: TextStyle(
                            color: controller.colorPrimary.value,
                            fontFamily: GoogleFonts.nunito().fontFamily,
                            fontSize: 25)),
                  )),
      ),
    );
  }
}
