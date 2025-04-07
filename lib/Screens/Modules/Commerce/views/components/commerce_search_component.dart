import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Commerce/path_commerce.dart';
import 'package:jaime_yakro/routes/path_route.dart';

class CommerceSearchComponent extends SearchDelegate<String> {
  CommerceScreenController commerceScreenController =
      Get.put(CommerceScreenController());
  // Dummy list
  final List<String> searchList = [
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Fig",
    "Grapes",
    "Kiwi",
    "Lemon",
    "Mango",
    "Orange",
    "Papaya",
    "Raspberry",
    "Strawberry",
    "Tomato",
    "Watermelon",
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        primaryColor: commerceScreenController.colorPrimary.value,
        // textTheme: GoogleFonts.nunitoTextTheme(),
        textTheme: const TextTheme(
          // Use this to change the query's text style
          titleLarge: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
            color: commerceScreenController.colorPrimary.value,
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
          // When pressed here the query will be cleared from the search bar.
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
    final CommerceScreenController controller = Get.find();
    final List<CommerceModel> searchResults = commerceScreenController
        .commerceController.commerceList
        .where((item) => item.nom!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return Padding(
      padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
      child: ListView.builder(
        itemCount: query == '' ? searchList.length : searchResults.length,
        itemBuilder: (context, index) {
          return CardCommerceElement(
              onTap: () {
                controller.commerceSingleScreenController.setCommerceModel(
                    searchResults[index]);
                Get.toNamed(AppRoutes.commerceSingleScreen);
              },
              commerceModel: searchResults[index]);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final CommerceScreenController controller = Get.find();
    final List<CommerceModel> suggestionList = commerceScreenController
            .commerceController.commerceList.isEmpty
        ? []
        : commerceScreenController.commerceController.commerceList
            .where(
                (item) => item.nom!.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return suggestionList.isEmpty
        ? Center(
            child: Text("Aucun Restaurant / Bar disponible",
                style: TextStyle(
                    color: const Color(0xffEEB446),
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontSize: 25)),
          )
        : Padding(
            padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
            child: ListView.separated(
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                return CardCommerceElement(
                    onTap: () {
                      controller.commerceSingleScreenController
                          .setCommerceModel(suggestionList[index]);
                      Get.toNamed(AppRoutes.commerceSingleScreen);
                    },
                    commerceModel: suggestionList[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
            ),
          );
  }
}
