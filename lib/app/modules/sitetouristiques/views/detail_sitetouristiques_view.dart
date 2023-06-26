import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaime_cocody/app/data/repository/data/Env.dart';
import '../../../controllers/main_controller.dart';
import '../../../models/site_touristique.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../widgets/visiteTouristique_card_widget.dart';

class DetailSitetouristiquesView extends GetView {
  final DataVisiteTouristiqueModel data;
  const DetailSitetouristiquesView({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MainController settingsCtrl = Get.find();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                     siteUrl+data.imageUrl),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.nomVt!,
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
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
                  TextField(
                    controller: TextEditingController(text: data.numeroVisitesTouristique),
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Numéro',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Expanded(
                      flex: 16,
                      child: _ui()
                  )
                ],
              ),
            ),
          )
        ],
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
