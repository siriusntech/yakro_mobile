import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Helpers/helpers.dart';
import 'package:jaime_yakro/Screens/Modules/Reduction/reduction_path.dart';
import 'package:jaime_yakro/routes/path_route.dart';

class TypeChambreHotelScreen extends GetView<TypeChambreHotelScreenController> {
  const TypeChambreHotelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: controller.colorPrimary.value,
        centerTitle: true,
        title: Text(
          'Type de chambre',
          style: TextStyle(
            fontSize: 25,
            fontFamily: GoogleFonts.nunito().fontFamily,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() =>  Padding(
        padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
        child: SizedBox(
            height: height,
            width: width,
            child: Column(
              children: [
                Text('(${controller.selectedIndex})', style: const TextStyle(color: Colors.white),),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        final isSelected = controller.selectedIndex.value == controller.hotelModel.typeChambreHotels![index].id;
                        return  GestureDetector(
                            onTap: () {
                              controller.selectIndex(int.parse(controller.hotelModel.typeChambreHotels![index].id.toString()));
                              controller.setChambreHotel(controller.hotelModel.typeChambreHotels![index]);
                            },
                            child: SizedBox(
                              height: 200,
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side:  BorderSide(
                                    color: isSelected ? controller.colorPrimary.value : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                        child: Image.network(
                                          "${controller.hotelModel.typeChambreHotels![index].medias!.first.url}",
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${controller.hotelModel.typeChambreHotels![index].typeChambres!.libelle} (${Helpers.formatPrice(double.parse(controller.hotelModel.typeChambreHotels![index].prix.toString()))} Frs)",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: isSelected ? controller.colorPrimary.value : Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                            )
                        );

                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                      itemCount: controller.hotelModel.typeChambreHotels!.length),
                ),
                controller.selectedIndex!=null? SizedBox(
                  height: 50,
                  width: width,
                  child: ElevatedButton(
                    onPressed: () {

                     controller.controllerReservation.setAuthModel(controller.controllerHotelScreeen.authController.authModel.value);
                     controller.controllerReservation.setModuledata({
                        "Module": "hotel_code",
                        "IdModule": controller.hotelModel.code,
                       "TypeChambreHotel": controller.selectedIndex.value
                      });
                     controller.controllerReservation.onInit();
                     // controller.controllerReservation.getPrix();
                      Get.toNamed(AppRoutes.reservationScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.colorPrimary.value,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Valider',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: GoogleFonts.nunito().fontFamily,
                      ),
                    ),
                  ),
                ):const SizedBox()


              ],
            )),
      )));

  }
}
