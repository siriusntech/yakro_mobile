import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/routes/path_route.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewEvenementSingle extends StatefulWidget {
  const PageViewEvenementSingle({super.key});

  @override
  State<PageViewEvenementSingle> createState() =>
      _PageViewEvenementSingleState();
}

class _PageViewEvenementSingleState extends State<PageViewEvenementSingle> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  final List<String> _pages = [
    "assets/images/resto_3.jpg",
    "assets/images/resto_3.jpg",
    "assets/images/resto_3.jpg",
    "assets/images/resto_3.jpg"
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }
  //

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _pages.length - 1) {
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
    return PageView.builder(
      controller: _pageController,
      itemCount: _pages.length,
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
                          image: AssetImage(
                            _pages[index],
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
                                Get.arguments['color'].withOpacity(0.5),
                            child: IconButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.evenementScreen,
                                      arguments: {
                                        "color": const Color(0xFF673C0A),
                                        "title": "Evenement"
                                      });
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
                              count: _pages.length, // number of pages
                              onDotClicked: (index) {
                                _pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              },
                              effect: WormEffect(
                                  activeDotColor: Get.arguments['color'],
                                  dotColor: Colors.white), // animation effect
                            ),
                            Container(
                              height: 20,
                              width: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color:
                                      Get.arguments['color'].withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(
                                      AppConfig.borderRadius)),
                              child: Text('${index + 1} / ${_pages.length}',
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
