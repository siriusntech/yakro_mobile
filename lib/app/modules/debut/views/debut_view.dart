import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jaime_cocody/app/Utils/app_constantes.dart';
import 'package:jaime_cocody/app/widgets/text_widget.dart';

import '../../../Utils/app_colors.dart';
import '../../../Utils/app_routes.dart';
import '../controllers/debut_controller.dart';

class DebutView extends GetView<DebutController> {
  @override
  Widget build(BuildContext context) {

    final PageController pageController = PageController();

    final List<Widget> pages = [
      NewPage(image: SLIDE_NEWS, titre: 'Actualités',
          desc: "Suivez l'actualités de votre commune."),
      NewPage(image: SLIDE_STORE, titre: 'Commerces et autres',
          desc: "Les restaurants, super marché et autres espaces de la commune."),
      NewPage(image: SLIDE_KNOWN, titre: 'Bon à savoir',
          desc: "Apprenez à connaitre votre commune."),
      NewPage(image: SLIDE_ALERTE, titre: 'Alertes',
          desc: "Envoyez des alertes sur les incidents de la commune."),
      NewPage(image: SLIDE_CHAT, titre: 'Discussions',
          desc: "Echangez et donnez votre avis pour l'évolution de la commune."),
      NewPage(image: SLIDE_PHARMACIE, titre: 'Pharmacies de garde',
          desc: "La liste des pharmacies de garde de la commune."),
    ];
     
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('DebutView'),
      //   centerTitle: true,
      // ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: AppColors.mainColor
          ),
          child: Column(
            children: [
               Expanded(
                   flex: 7,
                   child: Container(
                     width: 175,
                     child: Image.asset(LOGO_BLANC),
                   )
               ),
               Expanded(
                   flex: 14,
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
                           height: 38,
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
                                             duration: const Duration(milliseconds: 300),
                                             curve: Curves.easeIn);
                                       },
                                       child: Obx(() => CircleAvatar(
                                         radius: 8,
                                         // check if a dot is connected to the current page
                                         // if true, give it a different color
                                         backgroundColor: controller.activePage.value == index
                                             ? Colors.amber
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
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 160,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black)
                      ),
                      onPressed: (){
                        Get.offAllNamed(AppRoutes.AUTH);
                      },
                      child: TextWidget(text: 'Commencer >>', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),
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
        padding: EdgeInsets.all(6),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                child: Image.asset(image,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 5,),
              TextWidget(text: titre, fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, alignement: TextAlign.center,),
              TextWidget(text: desc, fontSize: 18, color: Colors.white, alignement: TextAlign.center),
            ],
          ),
        ),
    );
  }

}
