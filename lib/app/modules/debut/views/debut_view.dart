import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/app/Utils/app_colors.dart';
import 'package:jaime_yakro/app/Utils/app_constantes.dart';
import 'package:jaime_yakro/app/widgets/text_widget.dart';

import '../../../Utils/app_routes.dart';
import '../controllers/debut_controller.dart';

class DebutView extends GetView<DebutController> {
  @override
  Widget build(BuildContext context) {

    final PageController pageController = PageController();

    final List<Widget> pages = [
      NewPage(image: SLIDE_NEWS, titre: 'Actualités',
          desc: "Suivez l'actualité de votre commune."),
      NewPage(image: SLIDE_STORE, titre: 'Restaurants et autres',
          desc: "Retrouvez les restaurants, bars, maquis et autres espaces de la commune."),
      // NewPage(image: SLIDE_KNOWN, titre: 'Bon à savoir',
      //     desc: "Apprenez à connaitre votre commune."),
      NewPage(image: SLIDE_ALERTE, titre: 'Alertes',
          desc: "Envoyez des alertes sur les incidents de la commune."),
      NewPage(image: VT, titre: 'Sites Touristiques',
          desc: "Découvrez les sites touristiques de la commune"),
      NewPage(image: HOTEL, titre: 'Hotels',
          desc: "Localisez les hôtels de la commune."),
    ];
     
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: AppColors.vert_colorFonce
          ),
          child: Column(
            children: [
               Expanded(
                   flex: 7,
                   child: Container(
                     width: 140,
                     child: Image.asset(LOGO_BLANC, fit: BoxFit.contain,),
                   )
               ),
               Expanded(
                   flex: 15,
                   child: Center(
                     child: Stack(
                       children: [
                         // the page view
                         PageView.builder(
                           controller: pageController,
                           onPageChanged: (int page) {
                             controller.changeActivePage(page);
                           },
                           itemCount: pages.length,
                           itemBuilder: (BuildContext context, int index) {
                             return pages[index % pages.length];
                           },
                         ),
                         // Display the dots indicator
                         Positioned(
                           bottom: 10,
                           left: 0,
                           right: 0,
                           height: 50,
                           child: Container(
                             color: Colors.black12,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: List<Widget>.generate(
                                     pages.length,
                                     (index) => Padding(
                                     padding: const EdgeInsets.symmetric(horizontal: 10),
                                     child: InkWell(
                                       onTap: () {
                                         pageController.animateToPage(index,
                                             duration: const Duration(milliseconds: 250),
                                             curve: Curves.easeIn);
                                       },
                                       child: Obx(() => CircleAvatar(
                                         radius: 8,
                                         // check if a dot is connected to the current page
                                         // if true, give it a different color
                                         backgroundColor: controller.activePage.value == index
                                             ? Color(0xFFD3D3D3)
                                             : Colors.grey,
                                       )),
                                     ),
                                   )),
                             ),
                           ),
                         ),
                       ],
                     ),
                   )
               ),
              // Expanded(
              //     flex: 1,
              //     child: SizedBox(
              //       width: 160,
              //       height: 40,
              //       child: ElevatedButton(
              //         style: ButtonStyle(
              //           shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              //         ),
              //         onPressed: (){
              //           Get.offAllNamed(AppRoutes.AUTH);
              //         },
              //         child: TextWidget(text: 'Commencer >>', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),
              //       ),
              //     )
              // ),
              Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: 160,
                    height: 40,
                    child: ElevatedButton(
  onPressed: () async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: CircularProgressIndicator(),
        );
      },
    );

    int score = await Future.delayed(
      const Duration(milliseconds: 1500),
      () => 35,
    );

    Navigator.pop(context); // Fermer la boîte de dialogue

    Get.offAllNamed(AppRoutes.AUTH);
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFFA2B4AC),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    minimumSize: Size(200, 50),
  ),
  child: Text(
    'Commencer >>',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
),

                   )
                ),
            ],
          ),
        ),
      ),
    );
  }



  NewPage({image, titre, desc}){
    return Padding(
        padding: EdgeInsets.only(bottom:75),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 240,
                child: Image.asset(image,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 5,),
              TextWidget(text: titre, fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, alignement: TextAlign.center),
              TextWidget(text: desc, fontSize: 18, color: Colors.white, alignement: TextAlign.center),
            ],
          ),
        ),
    );
  }

}
