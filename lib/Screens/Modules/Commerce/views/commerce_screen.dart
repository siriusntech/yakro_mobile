import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
// import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Screens/Modules/Commerce/path_commerce.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Screens/Widgets/dialog.dart';

class CommerceScreen extends GetView<CommerceScreenController> {
  const CommerceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: controller.colorPrimary.value,
        title: Text('${controller.title.value} Yakro',
            style: TextStyle(
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.taprom().fontFamily)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await showSearch(
                  context: context,
                  delegate: CommerceSearchComponent(),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.typeCommerceControllerGetter.onInit();
          controller.specialiteCommerceControllerGetter.onInit();
          showDialog(
              context: context,
              builder: (_) => FiltreCommerce(
                    typeCommercesList: controller
                        .typeCommerceControllerGetter.listTypeCommerce,
                    specialiteCommerceListFilter: controller
                        .specialiteCommerceControllerGetter
                        .listSpecialiteCommerce,
                  ));
        },
        backgroundColor: controller.colorPrimary.value,
        child: const Icon(
          Icons.filter_alt_outlined,
          color: Colors.white,
        ),
      ),
      body: const CommerceComponent(),
    );
  }
}
