import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';

class MesCommandeScreen extends StatefulWidget {
  const MesCommandeScreen({super.key});

  @override
  State<MesCommandeScreen> createState() => _MesCommandeScreenState();
}

class _MesCommandeScreenState extends State<MesCommandeScreen>
    with SingleTickerProviderStateMixin {
  final BoutiqueScreenController boutiqueController =
      Get.put(BoutiqueScreenController());
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        boutiqueController.controllerBoutiqueGetter.getAllOrderWithStatus(
            tabController.index == 0 ? 'delivered' : 'new');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: boutiqueController.colorPrimary.value,
        title: Text('Mes Commandes',
            style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.taprom().fontFamily)),
        bottom: TabBar(tabs: [
          Tab(
            child: Text(
              'Terminé',
              style: TextStyle(
                color: Colors.white,
                fontFamily: GoogleFonts.nunito().fontFamily,
                fontSize: 20,
              ),
            ),
          ),
          Tab(
            child: Text(
              'En Cours',
              style: TextStyle(
                color: Colors.white,
                fontFamily: GoogleFonts.nunito().fontFamily,
                fontSize: 20,
              ),
            ),
          ),
        ], controller: tabController),
      ),
      body: TabBarView(controller: tabController, children: [
        Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(),
          child: Obx(() =>
              boutiqueController.controllerBoutiqueGetter.orderListLoading.value
                  ? Center(
                      child: SpinKitDancingSquare(
                          color: boutiqueController.colorPrimary.value))
                  : ListView.builder(
                      itemCount: boutiqueController
                          .controllerBoutiqueGetter.orderList.length,
                      itemBuilder: (context, index) => CardOrderElement(
                          orderBoutiqueModel: boutiqueController
                              .controllerBoutiqueGetter.orderList[index]),
                    )),
        ),
        Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(),
          child: Obx(() =>
              boutiqueController.controllerBoutiqueGetter.orderListLoading.value
                  ? Center(
                      child: SpinKitDancingSquare(
                          color: boutiqueController.colorPrimary.value))
                  : ListView.builder(
                      itemCount: boutiqueController
                          .controllerBoutiqueGetter.orderList.length,
                      itemBuilder: (context, index) => CardOrderElement(
                          orderBoutiqueModel: boutiqueController
                              .controllerBoutiqueGetter.orderList[index]),
                    )),
        ),
      ]),
    );
  }
}
