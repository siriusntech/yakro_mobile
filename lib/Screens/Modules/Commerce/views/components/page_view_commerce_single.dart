import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Commerce/path_commerce.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewRestaurantSingle extends StatefulWidget {
  const PageViewRestaurantSingle({super.key, required this.commerceModel});
  final CommerceModel? commerceModel;
  @override
  State<PageViewRestaurantSingle> createState() =>
      _PageViewRestaurantSingleState();
}

class _PageViewRestaurantSingleState extends State<PageViewRestaurantSingle> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  // final List<String> _pages = [
  //   "assets/images/resto_1.jpg",
  //   "assets/images/resto_1.jpg",
  //   "assets/images/resto_1.jpg",
  //   "assets/images/resto_1.jpg",
  // ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.commerceModel!.mediasModel!.length - 1) {
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
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CommerceSingleScreenController controller = Get.find();
    // print("model: ${widget.commerceModel!.mediasModel!.length}");
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.commerceModel!.mediasModel!.length,
      itemBuilder: (context, index) => Container(
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppConfig.borderRadius),
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.commerceModel!.mediasModel![index].url!,
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 0,
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                controller.colorPrimary.value.withOpacity(0.5),
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(Icons.chevron_left)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SmoothPageIndicator(
                              controller:
                                  _pageController, // PageController instance
                              count: widget.commerceModel!.mediasModel!
                                  .length, // number of pages
                              onDotClicked: (index) {
                                _pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              },
                              effect: WormEffect(
                                  activeDotColor: controller.colorPrimary.value,
                                  dotColor: Colors.white), // animation effect
                            ),
                            Container(
                              height: 20,
                              width: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: controller.colorPrimary.value
                                      .withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(
                                      AppConfig.borderRadius)),
                              child: Text(
                                  '${index + 1} / ${widget.commerceModel!.mediasModel!.length}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily)),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
            ],
          )),
    );
  }
}
