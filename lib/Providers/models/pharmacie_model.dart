import 'dart:convert';

import 'package:jaime_yakro/Config/app_config.dart';

class PharmacieModel {
  final int? id;
  final String? zone;
  final String? nom;
  final String? medecin;
  final List<Contact>? contacts;
  final String? adresse;
  final String? periode;
  final DateTime? dateDebut;
  final DateTime? dateFin;
  final String? localisation;
  final String? photo;

  PharmacieModel({
    this.id,
    this.zone,
    this.nom,
    this.medecin,
    this.contacts,
    this.adresse,
    this.periode,
    this.dateDebut,
    this.dateFin,
    this.localisation,
    this.photo,
  });

  factory PharmacieModel.fromRawJson(String str) =>
      PharmacieModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PharmacieModel.fromJson(Map<String, dynamic> json) => PharmacieModel(
        id: json["id"],
        zone: json["zone"],
        nom: json["nom"],
        medecin: json["medecin"],
        contacts: List<Contact>.from(
            json["contacts"].map((x) => Contact.fromJson(x))),
        adresse: json["adresse"],
        periode: json["periode"],
        dateDebut: DateTime.parse(json["date_debut"]),
        dateFin: DateTime.parse(json["date_fin"]),
        localisation: json["localisation"],
        photo: AppConfig.baseUrl + json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "zone": zone,
        "nom": nom,
        "medecin": medecin,
        "contacts": List<dynamic>.from(contacts!.map((x) => x.toJson())),
        "adresse": adresse,
        "periode": periode,
        "date_debut":
            "${dateDebut!.year.toString().padLeft(4, '0')}-${dateDebut!.month.toString().padLeft(2, '0')}-${dateDebut!.day.toString().padLeft(2, '0')}",
        "date_fin":
            "${dateFin!.year.toString().padLeft(4, '0')}-${dateFin!.month.toString().padLeft(2, '0')}-${dateFin!.day.toString().padLeft(2, '0')}",
        "localisation": localisation,
        "photo": photo,
      };
}

class Contact {
  final int? id;
  final String? numero;
  final int? pharmacieId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Contact({
    this.id,
    this.numero,
    this.pharmacieId,
    this.createdAt,
    this.updatedAt,
  });

  factory Contact.fromRawJson(String str) => Contact.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        numero: json["numero"],
        pharmacieId: json["pharmacie_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "numero": numero,
        "pharmacie_id": pharmacieId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
