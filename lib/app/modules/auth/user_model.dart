
import 'dart:convert';
// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET ACTUALITE
List<User> userFromJson(String str) => List<User>.from(json.decode(str)['data'].map((x) => User.fromJson(x)));
// RETOURNE UN OBJET MESSAGE
String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  int? id;
  int? code;
  int? is_actif;
  int? account_exist;
  String? token;
  String? nom;
  String? prenom;
  String? pseudo;
  String? email;
  String? contact;
  String? cloud_messaging_token;

  User({this.id,
      this.code,
      this.is_actif,
      this.account_exist,
      this.token,
      this.nom,
      this.prenom,
      this.pseudo,
      this.email,
      this.contact, 
      this.cloud_messaging_token });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? null;
    code = json['code'] ?? null;
    is_actif = json['is_actif'] ?? 0;
    account_exist = json['account_exist'] ?? 0;
    token = json['token'] ?? null;
    nom = json['nom'] ?? null;
    prenom = json['prenom'] ?? null;
    pseudo = json['pseudo'] ?? null;
    email = json['email'] ?? null;
    contact = json['contact'] ?? null;
    cloud_messaging_token= json['cloud_messaging_token'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['is_actif'] = is_actif;
    data['account_exist'] = account_exist;
    data['token'] = token;
    data['nom'] = nom;
    data['prenom'] = prenom;
    data['pseudo'] = pseudo;
    data['email'] = email;
    data['contact'] = contact;
    data['cloud_messaging_token'] = cloud_messaging_token;
    return data;
  }
}
