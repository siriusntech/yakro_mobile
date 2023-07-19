

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET Restaurant
import 'dart:convert';

List<Restaurant> RestaurantFromJson(String str) => List<Restaurant>.from(json.decode(str)['data'].map((x) => Restaurant.fromJson(x)));
// RETOURNE UN OBJET Restaurant
String RestaurantToJson(List<Restaurant> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Restaurant {
  int? id;
  String? type;
  String? nom;
  String? responsable;
  String? description;
  String? contact;
  String? imageUrl;
  String? lien;
  String? site;
  String? email;
  String? facebook;
  String? linkedln;
  String? instagram;
  String? youtube;
  List<Media>? medias;

  Restaurant(
      {this.id,
      this.type,
      this.nom,
      this.responsable,
      this.description,
      this.contact,
      this.imageUrl,
      this.lien,
      this.site,
      this.email,
      this.facebook,
      this.linkedln,
      this.instagram,
      this.youtube,
      this.medias,
      });

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    nom = json['nom'];
    responsable = json['responsable'];
    description = json['description'];
    contact = json['contact'];
    imageUrl = json['imageUrl'];
    lien = json['lien'];
    site = json['site'];
    email = json['email'];
    facebook = json['facebook'];
    linkedln = json['linkedln'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    medias= List<Media>.from(json["medias"].map((x) => Media.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['nom'] = nom;
    data['responsable'] = responsable;
    data['description'] = description;
    data['contact'] = contact;
    data['imageUrl'] = imageUrl;
    data['lien'] = lien;
    data['site'] = site;
    data['email'] = email;
    data['facebook'] = facebook;
    data['linkedln'] = linkedln;
    data['instagram'] = instagram;
    data['youtube'] = youtube;
    data['medias'] = List<dynamic>.from(medias!.map((x) => x.toJson()));
    return data;
  }

  
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