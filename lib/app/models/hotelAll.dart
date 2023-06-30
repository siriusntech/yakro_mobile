// To parse this JSON data, do
//
//     final hotelModel = hotelModelFromJson(jsonString);

import 'dart:convert';

List<HotelModel> hotelModelFromJson(String str) => List<HotelModel>.from(json.decode(str).map((x) => HotelModel.fromJson(x)));

String hotelModelToJson(List<HotelModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HotelModel {
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
    DateTime? createdAt;
    DateTime? updatedAt;
    TypeHotel? typeHotel;
    TypeHotel? typeQuartierHotel;
    List<HotelsMedia?> hotelsMedias;

    HotelModel({
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
        this.createdAt,
        this.updatedAt,
        this.typeHotel,
        this.typeQuartierHotel,
        required this.hotelsMedias,
    });

    factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
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
        typeHotel: TypeHotel.fromJson(json["type_hotel"]),
        typeQuartierHotel: TypeHotel.fromJson(json["type_quartier_hotel"]),
        hotelsMedias: List<HotelsMedia>.from(json["hotels_medias"].map((x) => HotelsMedia.fromJson(x))),
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "type_hotel": typeHotel?.toJson(),
        "type_quartier_hotel": typeQuartierHotel?.toJson(),
        "hotels_medias": List<dynamic>.from(hotelsMedias.map((x) => x?.toJson())),
    };
}

class HotelsMedia {
    String hotelId;
    String url;

    HotelsMedia({
        required this.hotelId,
        required this.url,
    });

    factory HotelsMedia.fromJson(Map<String, dynamic> json) => HotelsMedia(
        hotelId: json["hotel_id"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "hotel_id": hotelId,
        "url": url,
    };
}

class TypeHotel {
    int? id;
    String? lieu;

    TypeHotel({
        this.id,
        this.lieu,
    });

    factory TypeHotel.fromJson(Map<String, dynamic> json) => TypeHotel(
        id: json["id"],
        lieu: json["lieu"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "lieu": lieu,
    };
}
