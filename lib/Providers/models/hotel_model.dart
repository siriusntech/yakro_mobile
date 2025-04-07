import 'dart:convert';

import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class HotelModel {
  final int? id;
  final String? nomHotel;
  final int? typeQuartierId;
  final String? typeQuartierLieu;
  final int? typeHotelId;
  final String? typeHotelLibelle;
  final String? prix;
  RxInt countFavoris;
  final String? description;
  final String? numeroHotel;
  final String? contact;
  final String? imageUrl;
  final List<MediaModel>? mediasModel;
  final String? pubUrl;
  final String? lienMap;
  final String? siteInternet;
  final String? adresseEmail;
  final String? facebook;
  final String? whatsApp;
  final String? youtube;
  final String? instagram;
  final FavorisModel? favorisModel;
  final double? reduction;
  final double? reductionNegoce;
  final String? code;
  final List<TypeChambreHotel>? typeChambreHotels;
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
  HotelModel({
    this.id,
    this.nomHotel,
    this.typeQuartierId,
    this.typeQuartierLieu,
    this.typeHotelId,
    this.typeHotelLibelle,
    this.prix,
    this.description,
    this.numeroHotel,
    int countFavoris = 0,
    this.contact,
    this.imageUrl,
    this.mediasModel,
    this.pubUrl,
    this.lienMap,
    this.siteInternet,
    this.adresseEmail,
    this.facebook,
    this.whatsApp,
    this.youtube,
    this.instagram,
    this.favorisModel,
    this.reduction,
    this.reductionNegoce,
    this.code,
    this.typeChambreHotels,
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

  factory HotelModel.fromRawJson(String str) =>
      HotelModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
        id: json["id"],
        nomHotel: json["nom_hotel"],
        typeQuartierId: json["type_quartier_id"],
        typeQuartierLieu: json["type_quartier_lieu"],
        typeHotelId: json["type_hotel_id"],
        typeHotelLibelle: json["type_hotel_libelle"],
        prix: json["prix"],
        description: json["description"],
        numeroHotel: json["numero_hotel"],
        countFavoris: json["count_favoris"],
        contact: json["contact"],
        imageUrl: json["imageUrl"],
        mediasModel: List<MediaModel>.from(
            json["medias"].map((x) => MediaModel.fromJson(x))),
        pubUrl: json["pubUrl"],
        lienMap: json["lien_map"],
        siteInternet: json["site_internet"],
        adresseEmail: json["adresse_email"],
        facebook: json["facebook"],
        whatsApp: json["linkedIn"],
        youtube: json["youtube"],
        instagram: json["instagram"],
        favorisModel: json["favoris"] == null
            ? null
            : FavorisModel.fromJson(json["favoris"]),
      reduction: json["reduction"]==null?null:double.parse(json["reduction"].toString()),
      reductionNegoce: json["reductionNegoce"]==null?null:double.parse(json["reductionNegoce"].toString()),
      code: json["code"],
      typeChambreHotels: List<TypeChambreHotel>.from(
          json["type_chambre_hotels"].map((x) => TypeChambreHotel.fromJson(x))),
        isFavorite: json["favoris"] == null
            ? false
            : FavorisModel.fromJson(json["favoris"]).fav == "1"
                ? true
                : false,
        countDislike: json["count_dislikes"],
        countLike: json["count_likes"],
        like: json["likes"],
        dislike: json["dislikes"],
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
        "nom_hotel": nomHotel,
        "type_quartier_id": typeQuartierId,
        "type_quartier_lieu": typeQuartierLieu,
        "type_hotel_id": typeHotelId,
        "type_hotel_libelle": typeHotelLibelle,
        "prix": prix,
        "description": description,
        "numero_hotel": numeroHotel,
        "count_favoris": countFavoris,
        "contact": contact,
        "imageUrl": imageUrl,
        "medias": List<dynamic>.from(mediasModel!.map((x) => x.toJson())),
        "lien_map": lienMap,
        "site_internet": siteInternet,
        "adresse_email": adresseEmail,
        "facebook": facebook,
        "linkedIn": whatsApp,
        "youtube": youtube,
        "instagram": instagram,
        "favoris": favorisModel == null ? null : favorisModel!.toJson(),
      };
}

class FavorisModel {
  final int? id;
  final String? fav;
  final String? typeCategorie;
  final dynamic hotelId;
  final dynamic commerceId;
  final dynamic visiteTouristiqueId;
  final dynamic pharmacieId;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FavorisModel({
    this.id,
    this.fav,
    this.typeCategorie,
    this.hotelId,
    this.commerceId,
    this.visiteTouristiqueId,
    this.pharmacieId,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory FavorisModel.fromRawJson(String str) =>
      FavorisModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FavorisModel.fromJson(Map<String, dynamic> json) => FavorisModel(
        id: json["id"],
        fav: json["fav"],
        typeCategorie: json["type_categorie"],
        hotelId: json["hotel_id"],
        commerceId: json["commerce_id"],
        visiteTouristiqueId: json["visite_touristique_id"],
        pharmacieId: json["pharmacie_id"],
        userId: int.parse(json["user_id"].toString()),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fav": fav,
        "type_categorie": typeCategorie,
        "hotel_id": hotelId,
        "commerce_id": commerceId,
        "visite_touristique_id": visiteTouristiqueId,
        "pharmacie_id": pharmacieId,
        "user_id": userId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
