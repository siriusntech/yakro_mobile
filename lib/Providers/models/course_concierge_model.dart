// To parse this JSON data, do
//
//     final courseConciergeModel = courseConciergeModelFromJson(jsonString);

import 'dart:convert';

import 'package:jaime_yakro/Providers/path_providers.dart';

CourseConciergeModel courseConciergeModelFromJson(String str) =>
    CourseConciergeModel.fromJson(json.decode(str));

String courseConciergeModelToJson(CourseConciergeModel data) =>
    json.encode(data.toJson());

class CourseConciergeModel {
  int? id;
  String? reference;
  dynamic coursierConciergeId;
  int? tarifCourseConciergeId;
  int? userConciergeId;
  String? etat;
  DateTime? createdAt;
  DateTime? updatedAt;
  CoursierConciergeModel? cousierConcierges;
  TarifCourseConciergerie? tarifCourseConciergerie;
  List<TacheConciergeModel>? tacheConcierges;
  UserConcierge? userConcierge;

  CourseConciergeModel(
      {this.id,
      this.reference,
      this.coursierConciergeId,
      this.tarifCourseConciergeId,
      this.userConciergeId,
      this.etat,
      this.createdAt,
      this.updatedAt,
      this.cousierConcierges,
      this.tarifCourseConciergerie,
      this.tacheConcierges,
      this.userConcierge});

  factory CourseConciergeModel.fromJson(Map<String, dynamic> json) =>
      CourseConciergeModel(
        id: json["id"],
        reference: json["reference"],
        coursierConciergeId: json["coursier_concierge_id"],
        tarifCourseConciergeId: json["tarif_course_concierge_id"],
        userConciergeId: json["user_concierge_id"],
        etat: json["etat"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        cousierConcierges: json["cousier_concierges"] == null
            ? null
            : CoursierConciergeModel.fromJson(json["cousier_concierges"]),
        userConcierge: json["user_concierge"] == null
            ? null
            : UserConcierge.fromJson(json["user_concierge"]),
        tarifCourseConciergerie:
            TarifCourseConciergerie.fromJson(json["tarif_course_conciergerie"]),
        tacheConcierges: List<TacheConciergeModel>.from(json["tache_concierges"]
            .map((x) => TacheConciergeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reference": reference,
        "coursier_concierge_id": coursierConciergeId,
        "tarif_course_concierge_id": tarifCourseConciergeId,
        "user_concierge_id": userConciergeId,
        "etat": etat,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "cousier_concierges": cousierConcierges,
        "tarif_course_conciergerie": tarifCourseConciergerie!.toJson(),
        "tache_concierges":
            List<dynamic>.from(tacheConcierges!.map((x) => x.toJson())),
      };
}

class TacheConciergeModel {
  int? id;
  String? libelle;
  dynamic description;
  int? courseConciergeId;
  String? etat;
  DateTime? createdAt;
  DateTime? updatedAt;

  TacheConciergeModel({
    this.id,
    this.libelle,
    this.description,
    this.courseConciergeId,
    this.etat,
    this.createdAt,
    this.updatedAt,
  });

  factory TacheConciergeModel.fromJson(Map<String, dynamic> json) =>
      TacheConciergeModel(
        id: json["id"],
        libelle: json["libelle"],
        description: json["description"],
        courseConciergeId: json["course_concierge_id"],
        etat: json["etat"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
        "description": description,
        "course_concierge_id": courseConciergeId,
        "etat": etat,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class TarifCourseConciergerie {
  int? id;
  String? libelle;
  String? tarif;
  DateTime? createdAt;
  DateTime? updatedAt;

  TarifCourseConciergerie({
    this.id,
    this.libelle,
    this.tarif,
    this.createdAt,
    this.updatedAt,
  });

  factory TarifCourseConciergerie.fromJson(Map<String, dynamic> json) =>
      TarifCourseConciergerie(
        id: json["id"],
        // libelle: json["libelle"],
        // tarif: json["tarif"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: json["updated_at"]==null?null: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
        "tarif": tarif,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt,
      };
}

class UserConcierge {
  int? id;
  String? nom;
  String? prenoms;
  dynamic email;
  String? pseudo;
  String? telephone;
  String? quartier;
  dynamic photo;
  String? deviceId;
  String? deviceModel;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserConcierge({
    this.id,
    this.nom,
    this.prenoms,
    this.email,
    this.pseudo,
    this.telephone,
    this.quartier,
    this.photo,
    this.deviceId,
    this.deviceModel,
    this.createdAt,
    this.updatedAt,
  });

  factory UserConcierge.fromJson(Map<String, dynamic> json) => UserConcierge(
        id: json["id"],
        nom: json["nom"],
        prenoms: json["prenoms"],
        email: json["email"],
        pseudo: json["pseudo"],
        telephone: json["telephone"],
        quartier: json["quartier"],
        photo: json["photo"],
        deviceId: json["device_id"],
        deviceModel: json["device_model"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "prenoms": prenoms,
        "email": email,
        "pseudo": pseudo,
        "telephone": telephone,
        "quartier": quartier,
        "photo": photo,
        "device_id": deviceId,
        "device_model": deviceModel,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
