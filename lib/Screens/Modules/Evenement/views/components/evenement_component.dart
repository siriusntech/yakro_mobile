import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/app_config.dart';

// import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Screens/Modules/Evenement/path_evenement.dart';

// import 'package:jaime_yakro/routes/path_route.dart';
import 'package:get/get.dart';

class EvenementComponent extends StatefulWidget {
  const EvenementComponent({super.key});

  @override
  State<EvenementComponent> createState() => _EvenementComponentState();
}

class _EvenementComponentState extends State<EvenementComponent> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final EvenementScreenController controller =
        Get.put(EvenementScreenController());
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
      height: height,
      width: width,
      decoration: const BoxDecoration(),
      child: RefreshIndicator(
        color: controller.colorPrimary.value,
        onRefresh: () {
          controller.bonPlanApiControllerGetter.getAllBonPlans();
          return Future.value();
        },
        child: Obx(() => controller
                .bonPlanApiControllerGetter.bonPlanLoading.value
            ? Center(
                child: SpinKitDoubleBounce(
                  color: controller.colorPrimary.value,
                ),
              )
            : controller.bonPlanApiControllerGetter.bonPlanList.isEmpty
                ? Center(
                    child: Text(
                    "Aucun Bon Plans disponible",
                    style: TextStyle(
                        color: controller.colorPrimary.value,
                        fontFamily: GoogleFonts.nunito().fontFamily,
                        fontSize: 25),
                  ))
                : ListView.separated(
                    itemBuilder: (context, index) => CardEvenementElement(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => Stack(
                                      children: [
                                        const SizedBox(
                                          height: 100,
                                        ),
                                        SizedBox(
                                          height: height,
                                          width: width,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: height / 2,
                                                width: width,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            controller
                                                                .bonPlanApiControllerGetter
                                                                .bonPlanList[
                                                                    index]
                                                                .medias![0]
                                                                .url!),
                                                        fit: BoxFit.contain)),
                                              ),
                                              const SizedBox(
                                                height: 50,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                    width: width,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(AppConfig
                                                                    .cardRadius),
                                                            topRight: Radius
                                                                .circular(AppConfig
                                                                    .cardRadius))),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 20,
                                                                right: 20),
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Text(
                                                                controller
                                                                    .bonPlanApiControllerGetter
                                                                    .bonPlanList[
                                                                        index]
                                                                    .objet!,
                                                                style: TextStyle(
                                                                    color: controller
                                                                        .colorPrimary
                                                                        .value,
                                                                    fontFamily:
                                                                        GoogleFonts.nunito()
                                                                            .fontFamily,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        25),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      SingleChildScrollView(
                                                                child: Text(
                                                                  controller
                                                                      .bonPlanApiControllerGetter
                                                                      .bonPlanList[
                                                                          index]
                                                                      .message!,
                                                                  style: TextStyle(
                                                                      color: controller
                                                                          .colorPrimary
                                                                          .value,
                                                                      fontFamily:
                                                                          GoogleFonts.nunito()
                                                                              .fontFamily,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ))
                                                            ]))),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                            right: 0,
                                            child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppConfig
                                                                .cardRadius)),
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: controller
                                                        .colorPrimary.value
                                                        .withOpacity(0.7),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                )))
                                      ],
                                    ));
                            // Get.toNamed(AppRoutes.evenementSingleScreen, arguments: {
                            //   "color": controller.colorPrimary.value,
                            //   "title": "Restaurant"
                            // }
                            // );
                          },
                          bonPlanModel: controller
                              .bonPlanApiControllerGetter.bonPlanList[index],
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                    itemCount: controller
                        .bonPlanApiControllerGetter.bonPlanList.length)),
      ),
    );
  }
}
