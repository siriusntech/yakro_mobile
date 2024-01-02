// To parse this JSON data, do
//
//     final affichageHotelRestaurant = affichageHotelRestaurantFromJson(jsonString);

import 'dart:convert';

List<AffichageHotelRestaurant> affichageHotelRestaurantFromJson(String str) => List<AffichageHotelRestaurant>.from(json.decode(str).map((x) => AffichageHotelRestaurant.fromJson(x)));

String affichageHotelRestaurantToJson(List<AffichageHotelRestaurant> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AffichageHotelRestaurant {
    int? id;
    int? restaurantId;
    int? userId;
    String? texte;
    int? valeur;
    User? user;

    AffichageHotelRestaurant({
        this.id,
        this.restaurantId,
        this.userId,
        this.texte,
        this.valeur,
        this.user,
    });

    factory AffichageHotelRestaurant.fromJson(Map<String, dynamic> json) => AffichageHotelRestaurant(
        id: json["id"],
        restaurantId: json["restaurant_id"],
        userId: json["user_id"],
        texte: json["texte"],
        valeur: json["valeur"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "restaurant_id": restaurantId,
        "user_id": userId,
        "texte": texte,
        "valeur": valeur,
        "user": user?.toJson(),
    };
}

class User {
    int? id;
    String? nom;
    String? prenom;
    String? pseudo;
    String? contact;

    User({
        this.id,
        this.nom,
        this.prenom,
        this.pseudo,
        this.contact,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nom: json["nom"],
        prenom: json["prenom"],
        pseudo: json["pseudo"],
        contact: json["contact"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "prenom": prenom,
        "pseudo": pseudo,
        "contact": contact,
    };
}
