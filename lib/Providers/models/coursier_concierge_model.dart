// To parse this JSON data, do
//
//     final coursierConcierge = coursierConciergeFromJson(jsonString);

import 'dart:convert';

CoursierConciergeModel coursierConciergeFromJson(String str) => CoursierConciergeModel.fromJson(json.decode(str));

String coursierConciergeToJson(CoursierConciergeModel data) => json.encode(data.toJson());

class CoursierConciergeModel {
  String? nom;
  String? prenoms;
  dynamic email;
  String? telephone1;
  String? telephone2;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? etat;
  String? etatDoc;
  String? profileImg;
  int? id;

  CoursierConciergeModel({
    this.nom,
    this.prenoms,
    this.email,
    this.telephone1,
    this.telephone2,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.etat,
    this.profileImg,
    this.etatDoc,
  });

  factory CoursierConciergeModel.fromJson(Map<String, dynamic> json) => CoursierConciergeModel(
    nom: json["nom"],
    prenoms: json["prenoms"],
    email: json["email"],
    telephone1: json["telephone_1"],
    telephone2: json["telephone_2"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
    etat: json["etat"],
    etatDoc: json["etat_doc"],
    profileImg: json["profileUrl"],
  );

  Map<String, dynamic> toJson() => {
    "nom": nom,
    "prenoms": prenoms,
    "email": email,
    "telephone_1": telephone1,
    "telephone_2": telephone2,
    "updated_at": updatedAt!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "id": id,
  };
}
