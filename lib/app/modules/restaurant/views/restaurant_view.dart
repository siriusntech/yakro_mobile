import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_routes.dart';
import '../../../controllers/main_controller.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/no_data_widget.dart';
import '../../../widgets/text_widget.dart';
import '../controllers/restaurant_controller.dart';
import '../widgets/restaurant_card_widget.dart';


class RestaurantView extends GetView<RestaurantController> {
  const RestaurantView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MainController settingsCtrl = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: settingsCtrl.vert_color_fonce,
        title: TextWidget(
          text: 'Restaurants et autres',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
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
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 30,
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshData();
        },
        child: Column(
          children: [
            Expanded(
              flex: context.isLandscape ? 5 : 2,
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Expanded(
                    child: Container(
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: Card(
                        color: AppColors.vert_color,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: TextField(
                          controller: controller.searchTextController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black26,
                              size: 35,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(15)),
                            hintText: "Ex: Plats africains, viande de brousse",
                            contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            // contentPadding: EdgeInsets.all(8)
                          ),
                          style: TextStyle(
                            color: AppColors.appbarTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (val) {
                            if (val.length > 0) {
                              controller.getCommercesByName(val);
                            } else {
                              controller.refreshData();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Obx(() => Row(
                              children: [
                                for (var type in controller.commerceTypesList)
                                  Card(
                                    elevation: 0.0,
                                    child: InkWell(
                                      onTap: () {
                                        if (controller.selectedType.value ==
                                                '' ||
                                            controller.selectedType.value !=
                                                type.nom.toString()) {
                                          controller.setSelectedType(
                                              type.nom.toString());
                                          controller.getCommercesByType(
                                              type.nom.toString());
                                        } else {
                                          controller.setSelectedType('');
                                          controller.refreshData();
                                        }
                                      },
                                      child: Chip(
                                        elevation: 5.0,
                                        backgroundColor: type.nom.toString() ==
                                                controller.selectedType.value
                                            ? AppColors.vert_color
                                            : AppColors.chip_color,
                                        label: TextWidget(
                                          text:
                                              type.nom.toString().toLowerCase(),
                                          color: AppColors.vert_color_fonce,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          scaleFactor: 1.3,
                                        ),
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    color: Colors.transparent,
                                  )
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Expanded(
              flex: context.isLandscape ? 12 : 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    if (controller.isDataProcessing.value == true) {
                      return LoadingWidget();
                    } else {
                      if (controller.commerceList.length == 0) {
                        return NoDataWidget();
                      } else {
                        return Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.only(bottom: 20),
                                itemCount: controller.commerceList.length,
                                itemBuilder: (context, index) {
                                  var commerce = controller.commerceList[index];
                                  return RestaurantCardWidget(
                                    commerce: commerce,
                                    action: () {
                                      controller.setSelectedCommerce(commerce);
                                      Get.toNamed(AppRoutes.SHOW_RESTAURANT);
                                      // Get.toNamed(AppRoutes.SHOW_RESTAURANT, arguments: {'data': commerce});
                                    //    Get.to(
                                    //   ShowRestaurantView(
                                    //  data: commerce,
                                    // ),
                                  // );
                                    },
                                  );
                                }));
                      }
                    }
                  })
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: settingsCtrl.vert_color_fonce,
        onPressed: () {
          Get.toNamed(AppRoutes.HOME);
        },
        child: Icon(
          Icons.home,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
