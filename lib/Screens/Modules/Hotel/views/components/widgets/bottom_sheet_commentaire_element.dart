import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Screens/Modules/Hotel/path_hotel.dart';
import 'package:jaime_yakro/Screens/Widgets/path_widget.dart';

class BottomSheetCommentaireElement extends StatelessWidget {
  const BottomSheetCommentaireElement({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final HotelScreenController controllerHotelScreeen =
        Get.put(HotelScreenController());
    return Container(
      height: height / 2,
      width: width,
      decoration: BoxDecoration(
        color: controllerHotelScreeen.colorPrimary.value,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Column(
        children: [
          Text(
            "Commentaires",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
                fontFamily: GoogleFonts.nunito().fontFamily),
          ),
          Expanded(
            child: Obx(() => controllerHotelScreeen.hotelSingleScreenController
                    .commentaireHotelListLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                : ListView.builder(
                    itemCount: controllerHotelScreeen
                        .hotelSingleScreenController
                        .commentaireList
                        .value
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return CommentaireElement(
                        index: index,
                        commentaireModel: controllerHotelScreeen
                            .hotelSingleScreenController
                            .commentaireList
                            .value[index],
                      );
                    },
                  )),
          )
        ],
      ),
    );
  }
}
