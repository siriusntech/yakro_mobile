
// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET ACTUALITE
import 'dart:convert';

List<Actualite> actualiteFromJson(String str) => List<Actualite>.from(json.decode(str)['data'].map((x) => Actualite.fromJson(x)));
// RETOURNE UN OBJET ACTUALITE
String actualiteToJson(List<Actualite> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Actualite {
  int? id;
  String? type;
  String? titre;
  String? description;
  String? date;
  String? imageUrl;

  Actualite(
      {this.id,
      this.type,
      this.titre,
      this.description,
      this.date,
      this.imageUrl});

  Actualite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    titre = json['titre'];
    description = json['description'];
    date = json['date'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['titre'] = titre;
    data['description'] = description;
    data['date'] = date;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
