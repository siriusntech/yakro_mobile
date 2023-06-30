// To parse this JSON data, do
//
//     final typeHotelByHotels = typeHotelByHotelsFromJson(jsonString);

import 'dart:convert';

List<TypeHotelByHotels> typeHotelByHotelsFromJson(String str) => List<TypeHotelByHotels>.from(json.decode(str).map((x) => TypeHotelByHotels.fromJson(x)));

String typeHotelByHotelsToJson(List<TypeHotelByHotels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TypeHotelByHotels {
  int? id;
  String? lieu;
  dynamic description;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<TypeByHotel> typeByHotels;

  TypeHotelByHotels({
    this.id,
    this.lieu,
    this.description,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
   required this.typeByHotels,
  });

  factory TypeHotelByHotels.fromJson(Map<String, dynamic> json) => TypeHotelByHotels(
    id: json["id"],
    lieu: json["lieu"],
    description: json["description"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    typeByHotels: List<TypeByHotel>.from(json["type_by_hotels"].map((x) => TypeByHotel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lieu": lieu,
    "description": description,
    "deleted_at": deletedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "type_by_hotels": List<dynamic>.from(typeByHotels.map((x) => x.toJson())),
  };
}

class TypeByHotel {
  int? id;
  String? nomHotel;
  String? prix;
  String? description;
  dynamic avis;
  String? numeroHotel;
  String? contact;
  String? lienMap;
  String? siteInternet;
  String? adresseEmail;
  String? facebook;
  String? linkedIn;
  String? youtube;
  String? instagram;
  String? typeQuartierHotelsId;
  String? typeHotelId;
  String? userId;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  TypeByHotel({
    this.id,
    this.nomHotel,
    this.prix,
    this.description,
    this.avis,
    this.numeroHotel,
    this.contact,
    this.lienMap,
    this.siteInternet,
    this.adresseEmail,
    this.facebook,
    this.linkedIn,
    this.youtube,
    this.instagram,
    this.typeQuartierHotelsId,
    this.typeHotelId,
    this.userId,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TypeByHotel.fromJson(Map<String, dynamic> json) => TypeByHotel(
    id: json["id"],
    nomHotel: json["nom_hotel"],
    prix: json["prix"],
    description: json["description"],
    avis: json["avis"],
    numeroHotel: json["numero_hotel"],
    contact: json["contact"],
    lienMap: json["lien_map"],
    siteInternet: json["site_internet"],
    adresseEmail: json["adresse_email"],
    facebook: json["facebook"],
    linkedIn: json["linkedIn"],
    youtube: json["youtube"],
    instagram: json["instagram"],
    typeQuartierHotelsId: json["type_quartier_hotels_id"],
    typeHotelId: json["type_hotel_id"],
    userId: json["user_id"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nom_hotel": nomHotel,
    "prix": prix,
    "description": description,
    "avis": avis,
    "numero_hotel": numeroHotel,
    "contact": contact,
    "lien_map": lienMap,
    "site_internet": siteInternet,
    "adresse_email": adresseEmail,
    "facebook": facebook,
    "linkedIn": linkedIn,
    "youtube": youtube,
    "instagram": instagram,
    "type_quartier_hotels_id": typeQuartierHotelsId,
    "type_hotel_id": typeHotelId,
    "user_id": userId,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
