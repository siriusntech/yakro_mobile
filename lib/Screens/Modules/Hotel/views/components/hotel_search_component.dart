import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Hotel/path_hotel.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

class HotelSearchComponent extends SearchDelegate<String> {
  HotelScreenController hotelScreenController =
      Get.put(HotelScreenController());
  final HotelController controllerHotel = Get.put(HotelController());
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
    final List<HotelModel> searchResults = controllerHotel.hotelsList.value
        .where((item) =>
            item.nomHotel!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return Padding(
      padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
      child: ListView.builder(
        itemCount: query == ''
            ? controllerHotel.hotelsList.value.length
            : searchResults.length,
        itemBuilder: (context, index) {
          return CardHotelElement(
            hotelModel: searchResults[index],
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HotelSingleScreen(
                            hotelModel: searchResults[index],
                          )));
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<HotelModel> suggestionList = controllerHotel
            .hotelsList.value.isEmpty
        ? []
        : controllerHotel.hotelsList.value
            .where((item) =>
                item.nomHotel!.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return suggestionList.isEmpty
        ? Center(
            child: Text("Aucun hotel disponible",
                style: TextStyle(
                    color: Colors.amber,
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontSize: 25)),
          )
        : Padding(
            padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
            child: ListView.builder(
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                return CardHotelElement(
                  hotelModel: suggestionList[index],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HotelSingleScreen(
                                  hotelModel: suggestionList[index],
                                )));
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
