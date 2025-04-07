import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Pharmacie/path_pharmacie.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../pharmacie_single_screen.dart';

class PharmacieSearchComponent extends SearchDelegate<String> {
  PharmacieScreenController hotelScreenController =
      Get.put(PharmacieScreenController());
  final PharmacieApiController controllerHotel =
      Get.put(PharmacieApiController());
  // Dummy list

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        primaryColor: hotelScreenController.colorPrimary.value,
        // textTheme: GoogleFonts.nunitoTextTheme(),
        textTheme: const TextTheme(
          // Use this to change the query's text style
          titleLarge: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
        iconButtonTheme: const IconButtonThemeData(
            style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(Colors.white),
        )),
        appBarTheme: AppBarTheme(
            color: hotelScreenController.colorPrimary.value,
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

  @override
  InputDecorationTheme? get searchFieldDecorationTheme => InputDecorationTheme(
        hintStyle: TextStyle(color: hotelScreenController.colorPrimary.value),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red)),
      );

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
    final List<PharmacieModel> searchResults = controllerHotel.pharmacieList
        .where((item) => item.nom!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return Padding(
      padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
        itemCount: query == ''
            ? controllerHotel.pharmacieList.length
            : searchResults.length,
        itemBuilder: (context, index) {
          return CardPharmacieElement(
            pharmacieModel: searchResults[index],
            onTap: () {
              hotelScreenController.pharmacieSingleScreenControllerGetter
                  .setPharmcieModel(searchResults[index]);
              showBottomSheet(
                  context: context,
                  builder: (context) => const PharmacieSingleScreen());
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<PharmacieModel> suggestionList = query.isEmpty
        ? []
        : controllerHotel.pharmacieList
            .where(
                (item) => item.nom!.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return suggestionList.isEmpty
        ? Center(
            child: Text("Aucun Pharmacie disponible",
                style: TextStyle(
                    color: const Color(0xff2F536E),
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontSize: 25)),
          )
        : Padding(
            padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                return CardPharmacieElement(
                  pharmacieModel: suggestionList[index],
                  onTap: () {
                    hotelScreenController.pharmacieSingleScreenControllerGetter
                        .setPharmcieModel(suggestionList[index]);
                    showBottomSheet(
                        context: context,
                        builder: (context) => const PharmacieSingleScreen());
                  },
                );
              },
            ),
          );

    // ListTile(
    //       title: Text(suggestionList[index].nomHotel!),
    //       onTap: () {
    //         query = suggestionList[index].nomHotel!;
    //         // Show the search results based on the selected suggestion.
    //       },
    //     )
  }
}
