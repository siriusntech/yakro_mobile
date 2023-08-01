import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/app/modules/sitetouristiques/controllers/sitetouristiques_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controllers/main_controller.dart';
import '../../../models/site_touristique.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../home/views/home_view.dart';
import '../widgets/visiteTouristique_card_widget.dart';

class DetailSitetouristiquesView extends GetView {
  final DataVisiteTouristiqueModel data;
  const DetailSitetouristiquesView({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SitetouristiquesController sitetouristiquesController = Get.put(SitetouristiquesController());
    final MainController settingsCtrl = Get.find();
     List listMedia =  data.medias.map((element) {
     return element?.url;
    }).toList();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        title: TextWidget(text: 'Details sur la Visite Touristique', fontSize: 17.5, fontWeight: FontWeight.bold, color: Colors.white),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await controller.refreshData();
            },
            icon: Icon(Icons.refresh, color: Colors.white, size: 30),
          )
        ],
      ),
      body:Obx(() {
          return sitetouristiquesController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                SizedBox(height: 3),
               CarouselSlider(
                      options: CarouselOptions(
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(milliseconds: 3500),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                      ),
                      items: generateSlider(listMedia),
                    ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.nomVt!,
                      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(data.description!, style: TextStyle(fontSize: 16.0),),
                    SizedBox(height: 35),
                    TextField(
                      controller: TextEditingController(text: '${data.typeQuartierVtLieu}'),
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Lieu',
                        prefixIcon: Icon(Icons.map_sharp),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: TextEditingController(text: '${data.prix} CFA'),
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Prix',
                        prefixIcon: Icon(Icons.price_change),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              // Action à effectuer lorsque le TextField est tapé
                              // Insérez votre code ici
                              print('TextField tapé !');
                              sitetouristiquesController.showAlerte(data.numeroVisitesTouristique.toString());
                            },
                            child:   TextField(
                      controller: TextEditingController(text: data.numeroVisitesTouristique),
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'contact1',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    )
                          ),
                      SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              // Action à effectuer lorsque le TextField est tapé
                              // Insérez votre code ici
                              print('TextField tapé !');
                              sitetouristiquesController.showAlerte(data.contact.toString());

                            },
                      child: TextField(
                      controller: TextEditingController(text: data.contact),
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Contact2',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    )
                ),
                     SizedBox(height: 20),
                              InkWell(
                            onTap: () {
                              // Action à effectuer lorsque le TextField est tapé
                              // Insérez votre code ici
                              print('TextField tapé !');
                                launchUrl(Uri.parse(data.siteInternet.toString()));
                            },
                      child: TextField(
                      controller: TextEditingController(text: data.siteInternet),
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Site Internet',
                        prefixIcon: Icon(Icons.web),
                        border: OutlineInputBorder(),
                      ),
                    )
                ),
                     SizedBox(height: 20),
                        InkWell(
                            onTap: () {
                              // Action à effectuer lorsque le TextField est tapé
                              // Insérez votre code ici
                              print('TextField tapé !');
                              launchUrl(Uri.parse(data.adresseEmail.toString()));
                            },
                            child:   TextField(
                      controller: TextEditingController(text: data.adresseEmail),
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Adresse Email',
                        prefixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(),
                      ),
                    )
                ),
                    SizedBox(height: 20),
                        InkWell(
                            onTap: () {
                              // Action à effectuer lorsque le TextField est tapé
                              // Insérez votre code ici
                              print('TextField tapé !');
                              launchUrl(Uri.parse(data.facebook.toString()));
                            },
                            child:   TextField(
                      controller: TextEditingController(text: data.facebook),
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Facebook',
                        prefixIcon: Icon(Icons.social_distance),
                        border: OutlineInputBorder(),
                      ),
                    )
                ),
                     SizedBox(height: 20),
                       InkWell(
                            onTap: () {
                              // Action à effectuer lorsque le TextField est tapé
                              // Insérez votre code ici
                              print('TextField tapé !');
                              launchUrl(Uri.parse(data.lienMap.toString()));
                            },
                            child: TextField(
                      controller: TextEditingController(text:' '),
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Lien de Map',
                        prefixIcon: Icon(Icons.map),
                        border: OutlineInputBorder(),
                           prefixText: 'Itinéraire',
                                prefixStyle: TextStyle(
                                  color: Colors.red, // Couleur du texte
                                  fontSize: 17.0, // Taille de la police
                                  fontWeight: FontWeight.bold, // Style de la police en gras
                                  // Vous pouvez ajouter d'autres propriétés de style ici si nécessaire
                                ),
                        ),
                      )
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
  ),
   
   
   
   
   
    );
  }
  _ui() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          if (controller.isDataProcessing.value == true) {
            return LoadingWidget();
          } else {
            if (controller.visiteTouristiquesList.length == 0) {
              return NoDataWidget();
            } else {
              return Expanded(
                  child: ListView.builder(
                      itemCount: controller.visiteTouristiquesList.length,
                      itemBuilder: (context, index) {
                        var visiteTouristique = controller.visiteTouristiquesList[index];
                        return SiteTouristiqueCardWidget(visiteTouristique: visiteTouristique);
                      }
                  )
              );
            }
          }
        })
      ],
    );
  }
}
