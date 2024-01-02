import 'dart:convert';

List<Restaurant> restaurantFromJson(String str) => List<Restaurant>.from(json.decode(str).map((x) => Restaurant.fromJson(x)));

String restaurantToJson(List<Restaurant> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Restaurant {
    int? id;
    int? typeCommerceId;
    int? zoneId;
    String? type;
    String? nom;
    String? responsable;
    String? description;
    String? contact;
    String? lien;
    dynamic longitude;
    dynamic latitude;
    String? ordre;
    dynamic site;
    String? email;
    String? facebook;
    dynamic linkedln;
    dynamic youtube;
    dynamic instagram;
    int? userId;
    String? nomType;
    int? prix;
    int? moyenneRestaurant;
    List<Media>? medias;

    Restaurant({
         this.id,
         this.typeCommerceId,
         this.zoneId,
         this.type,
         this.nom,
         this.responsable,
         this.description,
         this.contact,
         this.lien,
         this.longitude,
         this.latitude,
         this.ordre,
         this.site,
         this.email,
         this.facebook,
         this.linkedln,
         this.youtube,
         this.instagram,
         this.userId,
         this.nomType,
         this.prix,
         this.moyenneRestaurant,
         this.medias,
    });

    factory Restaurant.fromJson(Map<String?, dynamic> json) => Restaurant(
        id: json["id"],
        typeCommerceId: json["type_commerce_id"],
        zoneId: json["zone_id"],
        type: json["type"],
        nom: json["nom"],
        responsable: json["responsable"],
        description: json["description"],
        contact: json["contact"],
        lien: json["lien"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        ordre: json["ordre"],
        site: json["site"],
        email: json["email"],
        facebook: json["facebook"],
        linkedln: json["linkedln"],
        youtube: json["youtube"],
        instagram: json["instagram"],
        userId: json["user_id"],
        nomType: json["nom_type"],
        prix: json["prix"],
        moyenneRestaurant: json["moyenneRestaurant"],
        medias: List<Media>.from(json["medias"].map((x) => Media.fromJson(x))),
    );

    Map<String?, dynamic> toJson() => {
        "id": id,
        "type_commerce_id": typeCommerceId,
        "zone_id": zoneId,
        "type": type,
        "nom": nom,
        "responsable": responsable,
        "description": description,
        "contact": contact,
        "lien": lien,
        "longitude": longitude,
        "latitude": latitude,
        "ordre": ordre,
        "site": site,
        "email": email,
        "facebook": facebook,
        "linkedln": linkedln,
        "youtube": youtube,
        "instagram": instagram,
        "user_id": userId,
        "nom_type": nomType,
        "prix": prix,
        "moyenneRestaurant": moyenneRestaurant,
        "medias": List<dynamic>.from(medias!.map((x) => x.toJson())),
    };
}

class Media {
    int commerceId;
    String url;

    Media({
        required this.commerceId,
        required this.url,
    });

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        commerceId: json["commerce_id"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "commerce_id": commerceId,
        "url": url,
    };
}






