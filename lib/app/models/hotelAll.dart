// To parse this JSON data, do
//
//     final hotelModel = hotelModelFromJson(jsonString);

import 'dart:convert';

HotelModel hotelModelFromJson(String str) => HotelModel.fromJson(json.decode(str));

String hotelModelToJson(HotelModel data) => json.encode(data.toJson());

class HotelModel {
    int? id;
    String? nomHotel;
    String? typeQuartierId;
    String? typeHotelId;
    int? prix;
    String? description;
    String? numeroHotel;
    String? contact;
    String? imageUrl;
    List<Media>? medias;
    String? lienMap;
    String? siteInternet;
    String? adresseEmail;
    String? facebook;
    String? linkedIn;
    String? youtube;
    String? instagram;

    HotelModel({
        this.id,
        this.nomHotel,
        this.typeQuartierId,
        this.typeHotelId,
        this.prix,
        this.description,
        this.numeroHotel,
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
    });

    factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
        id: json["id"],
        nomHotel: json["nom_hotel"],
        typeQuartierId: json["type_quartier_id"],
        typeHotelId: json["type_hotel_id"],
        prix: json["prix"],
        description: json["description"],
        numeroHotel: json["numero_hotel"],
        contact: json["contact"],
        imageUrl: json["imageUrl"],
        medias: json["medias"] == null ? [] : List<Media>.from(json["medias"]!.map((x) => Media.fromJson(x))),
        lienMap: json["lien_map"],
        siteInternet: json["site_internet"],
        adresseEmail: json["adresse_email"],
        facebook: json["facebook"],
        linkedIn: json["linkedIn"],
        youtube: json["youtube"],
        instagram: json["instagram"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nom_hotel": nomHotel,
        "type_quartier_id": typeQuartierId,
        "type_hotel_id": typeHotelId,
        "prix": prix,
        "description": description,
        "numero_hotel": numeroHotel,
        "contact": contact,
        "imageUrl": imageUrl,
        "medias": medias == null ? [] : List<dynamic>.from(medias!.map((x) => x.toJson())),
        "lien_map": lienMap,
        "site_internet": siteInternet,
        "adresse_email": adresseEmail,
        "facebook": facebook,
        "linkedIn": linkedIn,
        "youtube": youtube,
        "instagram": instagram,
    };
}

class Media {
    int? id;
    String? url;
    String? type;

    Media({
        this.id,
        this.url,
        this.type,
    });

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        url: json["url"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "type": type,
    };
}
