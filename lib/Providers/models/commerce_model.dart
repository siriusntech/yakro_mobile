import 'dart:convert';

import 'package:get/get.dart';
import 'package:jaime_yakro/Providers/models/path_mdels.dart';

class CommerceModel {
  final int? id;
  final String? type;
  final String? zone;
  final String? nom;
  final String? responsable;
  final String? description;
  final String? contact;
  final String? lien;
  final String? site;
  final String? email;
  final String? facebook;
  final String? linkedln;
  final dynamic instagram;
  final String? youtube;
  final String? imageUrl;
  final List<MediaModel>? mediasModel;
  final List<SpecialiteModel>? specialites;
  final FavorisModel? favorisModel;
  RxBool isFavorite;
  RxInt countFavoris;
  RxBool isRating;
  RxInt rating_1;
  RxInt rating_2;
  RxInt rating_3;
  RxInt rating_4;
  RxInt rating_5;
  RxInt moyenneRating;
  RxInt countRating;

  CommerceModel({
    this.id,
    this.type,
    this.zone,
    this.nom,
    this.responsable,
    this.description,
    this.contact,
    this.lien,
    this.site,
    this.email,
    this.facebook,
    this.linkedln,
    this.instagram,
    this.youtube,
    this.imageUrl,
    this.mediasModel,
    this.specialites,
    this.favorisModel,
    bool? isFavorite = false,
    bool isRating = false,
    int countFavoris = 0,
    int rating_1 = 0,
    int rating_2 = 0,
    int rating_3 = 0,
    int rating_4 = 0,
    int rating_5 = 0,
    int moyenneRating = 0,
    int countRating = 0,
  })  : rating_1 = RxInt(rating_1),
        rating_2 = RxInt(rating_2),
        rating_3 = RxInt(rating_3),
        rating_4 = RxInt(rating_4),
        rating_5 = RxInt(rating_5),
        moyenneRating = RxInt(moyenneRating),
        countRating = RxInt(countRating),
        isRating = RxBool(isRating),
        isFavorite = RxBool(isFavorite!),
        countFavoris = RxInt(countFavoris);

  factory CommerceModel.fromRawJson(String str) =>
      CommerceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommerceModel.fromJson(Map<String, dynamic> json) => CommerceModel(
        id: json["id"],
        type: json["type"],
        zone: json["zone"] == null ? "" : json["zone"],
        nom: json["nom"] == null ? "" : json["nom"],
        responsable: json["responsable"],
        description: json["description"],
        contact: json["contact"],
        lien: json["lien"],
        site: json["site"],
        email: json["email"],
        facebook: json["facebook"],
        linkedln: json["linkedln"],
        instagram: json["instagram"],
        youtube: json["youtube"],
        imageUrl: json["imageUrl"],
        mediasModel: List<MediaModel>.from(
            json["medias"].map((x) => MediaModel.fromJson(x))),
        favorisModel: json["favoris"] == null
            ? null
            : FavorisModel.fromJson(json["favoris"]),
        isFavorite: json["favoris"] == null
            ? false
            : FavorisModel.fromJson(json["favoris"]).fav == "1"
                ? true
                : false,
        countFavoris: json["count_favoris"] ?? 0,
        rating_1: json["rating"]['1'],
        rating_2: json["rating"]['2'],
        rating_3: json["rating"]['3'],
        rating_4: json["rating"]['4'],
        rating_5: json["rating"]['5'],
        moyenneRating: json["rating"]["moyenne"],
        countRating: json["rating"]["count"],
        isRating: json["rating"]["isRating"],
        specialites: List<SpecialiteModel>.from(
            json["specialite"].map((x) => SpecialiteModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "zone": zone,
        "nom": nom,
        "responsable": responsable,
        "description": description,
        "contact": contact,
        "lien": lien,
        "site": site,
        "email": email,
        "facebook": facebook,
        "linkedln": linkedln,
        "instagram": instagram,
        "youtube": youtube,
        "imageUrl": imageUrl,
        "medias": List<dynamic>.from(mediasModel!.map((x) => x.toJson())),
      };
}

class SpecialiteModel {
  final int? id;
  final int? specialiteCommerceId;
  final int? commerceId;
  final SpecialiteCommerceModel? specialiteCommerceModel;
  final DateTime createdAt;
  final DateTime updatedAt;

  SpecialiteModel({
    this.id,
    this.specialiteCommerceId,
    this.commerceId,
    this.specialiteCommerceModel,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SpecialiteModel.fromRawJson(String str) =>
      SpecialiteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SpecialiteModel.fromJson(Map<String, dynamic> json) =>
      SpecialiteModel(
        id: json["id"],
        specialiteCommerceId: json["specialite_commerce_id"],
        commerceId: json["commerce_id"],
        specialiteCommerceModel: json["specialite_commerces"] == null
            ? null
            : SpecialiteCommerceModel.fromJson(json["specialite_commerces"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "specialite_commerce_id": specialiteCommerceId,
        "commerce_id": commerceId,
        "specialite_commerce": specialiteCommerceModel?.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
