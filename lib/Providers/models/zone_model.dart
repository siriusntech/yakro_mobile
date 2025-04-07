import 'dart:convert';

class ZoneModel {
  final int? id;
  final String? nom;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ZoneModel({
    this.id,
    this.nom,
    this.createdAt,
    this.updatedAt,
  });

  factory ZoneModel.fromRawJson(String str) =>
      ZoneModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ZoneModel.fromJson(Map<String, dynamic> json) => ZoneModel(
        id: json["id"],
        nom: json["nom"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
