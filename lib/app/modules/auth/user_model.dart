
import 'dart:convert';
// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET ACTUALITE
List<User> userFromJson(String str) => List<User>.from(json.decode(str)['data'].map((x) => User.fromJson(x)));
// RETOURNE UN OBJET MESSAGE
String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  int? id;
  int? code;
  int? isActif;
  int? account_exist;
  String? token;
  String? nom;
  String? prenom;
  String? pseudo;
  String? email;
  String? contact;

  User(
      {this.id,
      this.code,
      this.isActif,
      this.account_exist,
      this.token,
      this.nom,
      this.prenom,
      this.pseudo,
      this.email,
      this.contact});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? null;
    code = json['code'] ?? null;
    isActif = json['is_actif'] ?? 0;
    isActif = json['account_exist'] ?? null;
    token = json['token'] ?? null;
    nom = json['nom'] ?? null;
    prenom = json['prenom'] ?? null;
    pseudo = json['pseudo'] ?? null;
    email = json['email'] ?? null;
    contact = json['contact'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['is_actif'] = isActif;
    data['token'] = token;
    data['nom'] = nom;
    data['prenom'] = prenom;
    data['pseudo'] = pseudo;
    data['email'] = email;
    data['contact'] = contact;
    return data;
  }
}
