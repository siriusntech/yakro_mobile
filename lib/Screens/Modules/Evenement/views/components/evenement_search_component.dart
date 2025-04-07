import 'package:flutter/material.dart';
import 'package:jaime_yakro/Config/app_config.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';
import 'package:jaime_yakro/Screens/Modules/Evenement/path_evenement.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EvenementSearchComponent extends SearchDelegate<String> {
  EvenementSearchComponent({Key? key, required this.evenementList});
  List<BonPlanModel> evenementList = [];
  EvenementScreenController evenementScreenController =
      Get.put(EvenementScreenController());
  // final BonPlanApiController bonPlanApiController = BonPlanApiController();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        primaryColor: evenementScreenController.colorPrimary.value,
        textTheme: const TextTheme(
          // Use this to change the query's text style
          titleLarge: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
        iconButtonTheme: const IconButtonThemeData(
            style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(Colors.white),
        )),
        appBarTheme: AppBarTheme(
            color: evenementScreenController.colorPrimary.value,
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final List<BonPlanModel> searchResults = evenementScreenController
        .bonPlanApiControllerGetter.bonPlanList
        .where(
            (item) => item.objet!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return Padding(
      padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
      child: ListView.builder(
        itemCount: query == ''
            ? evenementScreenController
                .bonPlanApiControllerGetter.bonPlanList.length
            : searchResults.length,
        itemBuilder: (context, index) {
          return CardEvenementElement(
            bonPlanModel: searchResults[index],
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
                                              evenementScreenController
                                                  .bonPlanApiControllerGetter
                                                  .bonPlanList[index]
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
                                              topLeft: Radius.circular(
                                                  AppConfig.cardRadius),
                                              topRight: Radius.circular(
                                                  AppConfig.cardRadius))),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  evenementScreenController
                                                      .bonPlanApiControllerGetter
                                                      .bonPlanList[index]
                                                      .objet!,
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xFF673C0A),
                                                      fontFamily:
                                                          GoogleFonts.nunito()
                                                              .fontFamily,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                  child: Text(
                                                    evenementScreenController
                                                        .bonPlanApiControllerGetter
                                                        .bonPlanList[index]
                                                        .message!,
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xFF673C0A),
                                                        fontFamily:
                                                            GoogleFonts.nunito()
                                                                .fontFamily,
                                                        fontSize: 18),
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
                                      borderRadius: BorderRadius.circular(
                                          AppConfig.cardRadius)),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: const Color(0xFF673C0A)
                                          .withOpacity(0.7),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  )))
                        ],
                      ));
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final List<BonPlanModel> suggestionList =
        evenementScreenController.bonPlanApiControllerGetter.bonPlanList.isEmpty
            ? []
            : evenementScreenController.bonPlanApiControllerGetter.bonPlanList
                .where((item) =>
                    item.objet!.toLowerCase().contains(query.toLowerCase()))
                .toList();

    return suggestionList.isEmpty
        ? Center(
            child: Text(
                "Aucun Bon Plans disponible ${evenementScreenController.bonPlanApiControllerGetter.bonPlanList.length}",
                style: TextStyle(
                    color: const Color(0xFF673C0A),
                    fontFamily: GoogleFonts.nunito().fontFamily,
                    fontSize: 25)),
          )
        : ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(AppConfig.paddingBodySimple),
                child: CardEvenementElement(
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
                                                      evenementScreenController
                                                          .bonPlanApiControllerGetter
                                                          .bonPlanList[index]
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
                                                      topLeft: Radius.circular(
                                                          AppConfig.cardRadius),
                                                      topRight: Radius.circular(
                                                          AppConfig
                                                              .cardRadius))),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 20),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          evenementScreenController
                                                              .bonPlanApiControllerGetter
                                                              .bonPlanList[
                                                                  index]
                                                              .objet!,
                                                          style: TextStyle(
                                                              color: const Color(
                                                                  0xFF673C0A),
                                                              fontFamily: GoogleFonts
                                                                      .nunito()
                                                                  .fontFamily,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 25),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Expanded(
                                                            child:
                                                                SingleChildScrollView(
                                                          child: Text(
                                                            evenementScreenController
                                                                .bonPlanApiControllerGetter
                                                                .bonPlanList[
                                                                    index]
                                                                .message!,
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xFF673C0A),
                                                                fontFamily: GoogleFonts
                                                                        .nunito()
                                                                    .fontFamily,
                                                                fontSize: 18),
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
                                                      AppConfig.cardRadius)),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color: const Color(0xFF673C0A)
                                                  .withOpacity(0.7),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          )))
                                ],
                              ));
                    },
                    bonPlanModel: suggestionList[index]),
              );
            },
          );
  }
}
