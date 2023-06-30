// To parse this JSON data, do
//
//     final visiteTouristique = visiteTouristiqueFromJson(jsonString);

import 'dart:convert';

VisiteTouristique visiteTouristiqueFromJson(String str) => VisiteTouristique.fromJson(json.decode(str));

String visiteTouristiqueToJson(VisiteTouristique data) => json.encode(data.toJson());

class VisiteTouristique {
    bool? success;
    List<DataVisiteTouristiqueModel?> data;
    dynamic message;

    VisiteTouristique({
        this.success,
        required this.data,
        this.message,
    });

    factory VisiteTouristique.fromJson(Map<String, dynamic> json) => VisiteTouristique(
        success: json["success"],
        data: List<DataVisiteTouristiqueModel>.from(json["data"].map((x) => DataVisiteTouristiqueModel.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x?.toJson())),
        "message": message,
    };
}

class DataVisiteTouristiqueModel {
    int? id;
    String? nomVt;
    String? typeQuartierVtLieu;
    String? prix;
    String? description;
    String? numeroVisitesTouristique;
    String? contact;
    String? imageUrl;
    List<Media?> medias;
    String? lienMap;
    String? siteInternet;
    String? adresseEmail;
    String? facebook;
    String? linkedIn;
    String? youtube;
    String? instagram;

    DataVisiteTouristiqueModel({
        this.id,
        this.nomVt,
        this.typeQuartierVtLieu,
        this.prix,
        this.description,
        this.numeroVisitesTouristique,
        this.contact,
        this.imageUrl,
        required this.medias,
        this.lienMap,
        this.siteInternet,
        this.adresseEmail,
        this.facebook,
        this.linkedIn,
        this.youtube,
        this.instagram,
    });

    factory DataVisiteTouristiqueModel.fromJson(Map<String, dynamic> json) => DataVisiteTouristiqueModel(
        id: json["id"],
        nomVt: json["nom_vt"],
        typeQuartierVtLieu: json["type_quartier_vt_lieu"],
        prix: json["prix"],
        description: json["description"],
        numeroVisitesTouristique: json["numero_visitesTouristique"],
        contact: json["contact"],
        imageUrl: json["imageUrl"],
        medias: List<Media>.from(json["medias"].map((x) => Media.fromJson(x))),
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
        "nom_vt": nomVt,
        "type_quartier_vt_lieu": typeQuartierVtLieu,
        "prix": prix,
        "description": description,
        "numero_visitesTouristique": numeroVisitesTouristique,
        "contact": contact,
        "imageUrl": imageUrl,
        "medias": List<dynamic>.from(medias.map((x) => x?.toJson())),
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
