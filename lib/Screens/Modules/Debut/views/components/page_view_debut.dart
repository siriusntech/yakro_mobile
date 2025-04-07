import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/Theme/Constant/const_colors.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:google_fonts/google_fonts.dart';

class PageViewDebut extends StatefulWidget {
  const PageViewDebut({super.key});

  @override
  State<PageViewDebut> createState() => _PageViewDebutState();
}

class _PageViewDebutState extends State<PageViewDebut> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  final List<String> _pages = [
    'assets/images/news_slide.jpg',
    'assets/images/restaurant_slide.jpg',
    'assets/images/boutique_slide.jpg',
    'assets/images/vt.jpg'
  ];

  final List<String> _titles = [
    "Suivez l'actualité de votre commune",
    "Découvrez les restaurants de votre commune",
    "Faites vos achats en toute tranquillité",
    "Découvrez les Site touristiques"
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

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
          decoration: BoxDecoration(
              color: ConstColors.vertColorFonce.withOpacity(0.3),
              borderRadius: BorderRadius.circular(AppConfig.borderRadius)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConfig.borderRadius),
                  image: DecorationImage(
                      image: AssetImage(
                        _pages[index],
                      ),
                      fit: BoxFit.cover),
                ),
              )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                // height: 90,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          _titles[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: GoogleFonts.nunitoSans().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
// []