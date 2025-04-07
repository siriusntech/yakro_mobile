import 'dart:convert';

import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class SiteTouristiqueModel {
  int? id;
  String? nomVt;
  String? typeQuartierVtLieu;
  String? typeNomCategorieVt;
  int? prix;
  String? description;
  String? numeroVisitesTouristique;
  dynamic contact;
  String? imageUrl;
  List<MediaModel>? medias;
  String? lienMap;
  dynamic siteInternet;
  String? adresseEmail;
  dynamic facebook;
  dynamic linkedIn;
  dynamic youtube;
  dynamic instagram;
  final FavorisModel? favorisModel;
  RxBool isFavorite;
  RxInt countLike;
  RxInt countDislike;
  RxBool like;
  RxBool dislike;
  RxBool isRating;
  RxInt rating_1;
  RxInt rating_2;
  RxInt rating_3;
  RxInt rating_4;
  RxInt rating_5;
  RxDouble moyenneRating;
  RxInt countRating;
  RxInt countFavoris;

  SiteTouristiqueModel({
    this.id,
    this.nomVt,
    this.typeQuartierVtLieu,
    this.typeNomCategorieVt,
    this.prix,
    this.description,
    this.numeroVisitesTouristique,
    this.contact,
    this.imageUrl,
    this.medias,
    this.lienMap,
    this.siteInternet,
    this.adresseEmail,
    this.facebook,
    this.linkedIn,
    this.youtube,
    this.instagram,
    this.favorisModel,
    int countFavoris = 0,
    bool? isFavorite = false,
    int countLike = 0,
    int countDislike = 0,
    bool like = false,
    bool dislike = false,
    bool isRating = false,
    int rating_1 = 0,
    int rating_2 = 0,
    int rating_3 = 0,
    int rating_4 = 0,
    int rating_5 = 0,
    double moyenneRating = 0,
    int countRating = 0,
  })  : isFavorite = RxBool(isFavorite!),
        countFavoris = RxInt(countFavoris),
        countLike = RxInt(countLike),
        countDislike = RxInt(countDislike),
        like = RxBool(like),
        dislike = RxBool(dislike),
        rating_1 = RxInt(rating_1),
        rating_2 = RxInt(rating_2),
        rating_3 = RxInt(rating_3),
        rating_4 = RxInt(rating_4),
        rating_5 = RxInt(rating_5),
        moyenneRating = RxDouble(moyenneRating),
        countRating = RxInt(countRating),
        isRating = RxBool(isRating);

  factory SiteTouristiqueModel.fromRawJson(String str) =>
      SiteTouristiqueModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SiteTouristiqueModel.fromJson(Map<String, dynamic> json) =>
      SiteTouristiqueModel(
        id: json["id"],
        nomVt: json["nom_vt"],
        typeQuartierVtLieu: json["type_quartier_vt_lieu"],
        typeNomCategorieVt: json["type_nom_categorie_vt"],
        prix: int.tryParse(json["prix"].toString()),
        description: json["description"],
        numeroVisitesTouristique: json["numero_visitesTouristique"],
        contact: json["contact"],
        imageUrl: json["imageUrl"],
        medias: List<MediaModel>.from(
            json["medias"].map((x) => MediaModel.fromJson(x))),
        lienMap: json["lien_map"],
        siteInternet: json["site_internet"],
        adresseEmail: json["adresse_email"],
        facebook: json["facebook"],
        linkedIn: json["linkedIn"],
        youtube: json["youtube"],
        instagram: json["instagram"],
        countFavoris: json["count_favoris"],
        favorisModel: json["favoris"] == null
            ? null
            : FavorisModel.fromJson(json["favoris"]),
        isFavorite: json["favoris"] == null
            ? false
            : FavorisModel.fromJson(json["favoris"]).fav == "1"
                ? true
                : false,
        countDislike: json["count_dislikes"] ?? 0,
        countLike: json["count_likes"] ?? 0,
        like: json["likes"] ?? false,
        dislike: json["dislikes"] ?? false,
        rating_1: json["rating"]['1'],
        rating_2: json["rating"]['2'],
        rating_3: json["rating"]['3'],
        rating_4: json["rating"]['4'],
        rating_5: json["rating"]['5'],
        moyenneRating: double.parse(json["rating"]["moyenne"].toString()),
        countRating: json["rating"]["count"],
        isRating: json["rating"]["isRating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom_vt": nomVt,
        "prix": prix,
        "description": description,
        "numero_visitesTouristique": numeroVisitesTouristique,
        "contact": contact,
        "lien_map": lienMap,
        "site_internet": siteInternet,
        "adresse_email": adresseEmail,
        "facebook": facebook,
        "linkedIn": linkedIn,
        "youtube": youtube,
        "instagram": instagram,
      };
}
