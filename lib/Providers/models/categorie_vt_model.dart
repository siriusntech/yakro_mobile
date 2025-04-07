// To parse this JSON data, do
//
//     final categorieVtModel = categorieVtModelFromJson(jsonString);

import 'dart:convert';

CategorieVtModel categorieVtModelFromJson(String str) =>
    CategorieVtModel.fromJson(json.decode(str));

String categorieVtModelToJson(CategorieVtModel data) =>
    json.encode(data.toJson());

class CategorieVtModel {
  int? id;
  String? libelle;
  String? description;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  CategorieVtModel({
    this.id,
    this.libelle,
    this.description,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory CategorieVtModel.fromJson(Map<String, dynamic> json) =>
      CategorieVtModel(
        id: json["id"],
        libelle: json["libelle"],
        description: json["description"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
        "description": description,
        "deleted_at": deletedAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
