import 'package:flutter/material.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Boutique/path_boutique.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

class BoutiqueSearchComponent extends SearchDelegate<String> {
  BoutiqueScreenController boutiqueScreenController =
      Get.put(BoutiqueScreenController());


  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        primaryColor: boutiqueScreenController.colorPrimary.value,
        // textTheme: GoogleFonts.nunitoTextTheme(),
        textTheme: const TextTheme(
          // Use this to change the query's text style
          titleLarge: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
            color: boutiqueScreenController.colorPrimary.value,
            titleTextStyle: const TextStyle(color: Colors.white)),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 15, right: 15),
          labelStyle: TextStyle(color: Colors.white),
        ));
  }

  @override
  String get searchFieldLabel => 'Recherche';

  // These methods are mandatory you cannot skip them.

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.white),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Navigator.of(context).pop(),
      // Exit from the search screen.
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<ProduitBoutiqueModel> searchResults = boutiqueScreenController
        .controllerBoutique
        .produitBoutiqueControllerGetter
        .produitBoutiqueListGetter
        .where(
            (item) => item.libelle!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 0.7,
      physics: const NeverScrollableScrollPhysics(),
      children: query == ''
          ? [
              ...boutiqueScreenController.controllerBoutique
                  .produitBoutiqueControllerGetter.produitBoutiqueListGetter
                  .map((produit) => CardProduitElement(
                        produitBoutiqueModel: produit,
                        onTap: () {
                          // controller.setFloatingDisable(true);
                          // controller.floatingDisable.value = true;
                          // showBottomSheet(
                          //     context: context,
                          //     builder: (_) => );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SingleProduitSearchComponent(
                                        produitBoutiqueModel: produit,
                                      )));
                        },
                      ))
            ]
          : [
              ...searchResults.map((produit) => CardProduitElement(
                    produitBoutiqueModel: produit,
                    onTap: () {
                      // controller.setFloatingDisable(true);
                      // controller.floatingDisable.value = true;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SingleProduitSearchComponent(
                                    produitBoutiqueModel: produit,
                                  )));
                    },
                  ))
            ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<ProduitBoutiqueModel> suggestionList = query.isEmpty
        ? boutiqueScreenController.controllerBoutique
        .produitBoutiqueControllerGetter.produitBoutiqueListGetter
        : boutiqueScreenController.controllerBoutique
            .produitBoutiqueControllerGetter.produitBoutiqueListGetter
            .where((item) =>
                item.libelle!.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return query != '' && suggestionList.isEmpty ?
    Center(child: Text('Aucun résultat trouvé', style: TextStyle(color: boutiqueScreenController.colorPrimary.value, fontSize: 20),))
        : GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        childAspectRatio: 0.7,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ...suggestionList.map((produit) => CardProduitElement(
                produitBoutiqueModel: produit,
                onTap: () {
                  // controller.setFloatingDisable(true);
                  // controller.floatingDisable.value = true;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SingleProduitSearchComponent(
                                produitBoutiqueModel: produit,
                              )));
                },
              ))
        ]);
  }
}
