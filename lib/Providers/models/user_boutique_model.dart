import 'dart:convert';

class UserBoutiqueModel {
  final String? nom;
  final String? prenoms;
  final String? telephone;
  final String? email;
  final String? quartier;
  final String? pseudo;
  final String? deviceId;
  final String? deviceModel;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  UserBoutiqueModel({
    this.nom,
    this.prenoms,
    this.telephone,
    this.email,
    this.quartier,
    this.pseudo,
    this.deviceId,
    this.deviceModel,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory UserBoutiqueModel.fromRawJson(String str) =>
      UserBoutiqueModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserBoutiqueModel.fromJson(Map<String, dynamic> json) =>
      UserBoutiqueModel(
        nom: json["nom"],
        prenoms: json["prenoms"],
        telephone: json["telephone"],
        email: json["email"],
        quartier: json["quartier"],
        pseudo: json["pseudo"],
        deviceId: json["device_id"],
        deviceModel: json["device_model"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "nom": nom,
        "prenoms": prenoms,
        "telephone": telephone,
        "email": email,
        "quartier": quartier,
        "pseudo": pseudo,
        "device_id": deviceId,
        "device_model": deviceModel,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
      };
}
