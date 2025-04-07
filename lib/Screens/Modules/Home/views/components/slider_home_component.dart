import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class SliderHomeComponent extends StatefulWidget {
  const SliderHomeComponent({super.key});

  @override
  State<SliderHomeComponent> createState() => _SliderHomeComponentState();
}

class _SliderHomeComponentState extends State<SliderHomeComponent> {
  final SliderApiController sliderApiController = Get.find();
  final ModuleController moduleController = Get.find();
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < sliderApiController.sliderList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void initState() {
    sliderApiController.onInit();
    moduleController.onInit();
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sliderApiController.getAllSlider();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Obx(
      () => Container(
        height: height / 4.3,
        width: width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: sliderApiController.sliderLoading.value
            ? const Center(
                child: SpinKitDoubleBounce(
                  color: Colors.amber,
                ),
              )
            : PageView.builder(
                controller: _pageController,
                itemCount: sliderApiController.sliderList.length,
                itemBuilder: (context, index) {
                  moduleController.getModules();
                  return InkWell(
                    onTap: () {
                      AnalyticsService().logScreenView(
                          'SliderHomeScreen', 'SliderHomeScreen', {
                        'screen_name': 'SliderHomeScreen',
                        'user_id': sliderApiController
                            .mainController.userId.value
                            .toString(),
                        'device_id': sliderApiController
                            .mainController.deviceId.value
                            .toString(),
                      });
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
                                                      sliderApiController
                                                          .sliderList[index]
                                                          .imageUrl!),
                                                  fit: BoxFit.contain)),
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
                                                      AppConfig.cardRadius)),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.black,
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          )))
                                ],
                              ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image: NetworkImage(sliderApiController
                                  .sliderList[index].imageUrl!),
                              fit: BoxFit.fill,
                            )),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
