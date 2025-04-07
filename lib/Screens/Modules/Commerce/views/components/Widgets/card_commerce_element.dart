import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Commerce/path_commerce.dart';

class CardCommerceElement extends StatefulWidget {
  const CardCommerceElement(
      {super.key, required this.onTap, this.index, this.commerceModel});
  final Callback onTap;
  final int? index;
  final CommerceModel? commerceModel;
  @override
  State<CardCommerceElement> createState() => _CardCommerceElementState();
}

class _CardCommerceElementState extends State<CardCommerceElement> {
  CommerceScreenController controller = Get.put(CommerceScreenController());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        // height: height / 2.5,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConfig.cardRadius),
            color: controller.colorPrimary.value.withOpacity(0.17)),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height / 3.5,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppConfig.cardRadius),
                      color: controller.colorPrimary.value,
                      image: DecorationImage(
                          image: NetworkImage(
                              "${widget.commerceModel!.mediasModel![0].url}"),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                    right: 0,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: controller.colorPrimary.value.withOpacity(0.7),
                          borderRadius:
                              BorderRadius.circular(AppConfig.cardRadius)),
                      child: Obx(() => IconButton(
                            icon: Icon(
                              widget.commerceModel!.isFavorite.value
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: widget.commerceModel!.isFavorite.value
                                  ? Colors.white
                                  : Colors.white,
                            ),
                            onPressed: () => controller.commerceControllerGetter
                                .toggleFavorite(widget.commerceModel!),
                          )),
                    ))
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
                          '${widget.commerceModel!.nom}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunito().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        // width: 60,
                        // color: Colors.amber,
                        child: Row(
                          children: [
                            const Icon(Icons.favorite),
                            Text('',
                                style: TextStyle(
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            Obx(() => Text(
                                '(${widget.commerceModel!.countFavoris.value})',
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
                    'contact: ${widget.commerceModel!.contact}',
                    style: TextStyle(
                      fontFamily: GoogleFonts.nunito().fontFamily,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
