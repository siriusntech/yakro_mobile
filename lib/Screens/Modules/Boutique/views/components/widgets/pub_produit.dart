import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';

class PubProduit extends StatefulWidget {
  const PubProduit({super.key, this.produitBoutiqueList});
  final List<ProduitBoutiqueModel>? produitBoutiqueList;
  @override
  State<PubProduit> createState() => _PubProduitState();
}

class _PubProduitState extends State<PubProduit> {
  final BoutiqueScreenController controller =
      Get.put(BoutiqueScreenController());
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.produitBoutiqueList!.length - 1) {
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
        itemCount: widget.produitBoutiqueList!.length,
        itemBuilder: (context, index) => Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.amber),
              child: Row(
                children: [
                  Expanded(
                      child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            'Profitez des Meilleurs Produits aux Meilleur Prix',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily:
                                    GoogleFonts.tiroBangla().fontFamily)),
                        ElevatedButton(
                            onPressed: () {
                              controller.setFloatingDisable(true);
                              showBottomSheet(
                                  context: context,
                                  builder: (_) => BoutiqueSingleScreen(
                                        produitBoutiqueModel:
                                            widget.produitBoutiqueList![index],
                                      ));
                            },
                            child: Text(
                              'Acheter',
                              style: TextStyle(
                                  fontFamily: GoogleFonts.amarante().fontFamily,
                                  color: controller.colorPrimary.value),
                            ))
                      ],
                    ),
                  )),
                  Container(
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(80),
                          bottomLeft: Radius.circular(80)),
                      image: DecorationImage(
                          image: NetworkImage(
                              '${AppConfig.baseUrl}${widget.produitBoutiqueList![index].imageUrl!}'),
                          fit: BoxFit.cover),
                    ),
                  )
                ],
              ),
            ));
  }
}
