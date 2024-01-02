import 'dart:convert';

List<HotelModel> hotelModelFromJson(String str) => List<HotelModel>.from(json.decode(str).map((x) => HotelModel.fromJson(x)));

String hotelModelToJson(List<HotelModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HotelModel {
    int? id;
    String? nomHotel;
    int? prix;
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
    int? userId;
    double? moyenneHotel;
    List<dynamic>? commentairesHotel;
    List<dynamic>? userIds;
    List<HotelsMedia?>? hotelsMedias;

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
        this.moyenneHotel,
        this.commentairesHotel,
        this.userIds,
        this.hotelsMedias,
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
        moyenneHotel: (json["moyenneHotel"] is double) ? json["moyenneHotel"] : double.tryParse(json["moyenneHotel"].toString()),
        commentairesHotel:json["commentairesHotel"],
        userIds:json["user_ids"],
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
        "moyenneHotel":moyenneHotel,
        "commentairesHotel":commentairesHotel,
        "userIds":userIds,
        "hotels_medias": List<dynamic>.from(hotelsMedias!.map((x) => x?.toJson())),
    };
}

class HotelsMedia {
    int? hotelId;
    String? url;

    HotelsMedia({
        this.hotelId,
        this.url,
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
