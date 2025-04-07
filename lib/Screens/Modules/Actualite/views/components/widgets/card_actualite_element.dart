import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Screens/Modules/Actualite/path_actualite.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';

class CardActualiteElement extends GetView<ActualiteScreenController> {
  const CardActualiteElement({super.key, this.onTap});
  final Callback? onTap;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: height / 2.5,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConfig.cardRadius),
            color: controller.colorPrimary.value.withOpacity(0.10)),
        child: Column(
          children: [
            Container(
              height: 70,
              width: width,
              padding: const EdgeInsets.all(1),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: controller.colorPrimary.value,
                ),
                title: Text(
                  'Edward Elrick',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.nunito().fontFamily,
                      fontSize: 16),
                ),
                subtitle: const Text(
                  '1h ago',
                ),
                trailing: const Icon(Icons.more_vert),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: height / 3.5,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppConfig.cardRadius),
                      color: controller.colorPrimary.value,
                      image: const DecorationImage(
                          image: AssetImage("assets/images/resto_4.jpg"),
                          fit: BoxFit.cover)),
                ),
                // Positioned(
                //   right: 0,
                //   child: Container(
                //     height: 60,
                //     width: 60,
                //     decoration: BoxDecoration(
                //         color: controller.colorPrimary.value
                //             .withOpacity(0.7),
                //         borderRadius: BorderRadius.circular(
                //             AppConfig.cardRadius)),
                //     child: IconButton(
                //         onPressed: () {},
                //         icon: const Icon(Icons.favorite)),
                //   ),
                // )
              ],
            ),
            Container(
                height: 70,
                width: width,
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Edward Elrick et 15 autres personnes ont commenté',
                        style: TextStyle(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                        )),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.thumb_up,
                                            color:
                                                controller.colorPrimary.value,
                                          )),
                                      Text(
                                        '10',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily:
                                                GoogleFonts.nunito().fontFamily,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.thumb_down,
                                            color: Colors.black,
                                          )),
                                      Text(
                                        '5',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily:
                                                GoogleFonts.nunito().fontFamily,
                                            fontSize: 16),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {},
                                borderRadius: const BorderRadius.only(
                                    bottomRight:
                                        Radius.circular(AppConfig.cardRadius)),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Commentaire(s)',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily:
                                            GoogleFonts.nunito().fontFamily,
                                        fontSize: 16),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
