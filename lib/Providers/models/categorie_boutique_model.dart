import 'dart:convert';

import 'package:jaime_yakro/Providers/path_providers.dart';

class CategorieBoutiqueModel {
  final int? id;
  final String? libelle;
  final String? slug;
  final String? description;
  final String? imageUrl;
  final List<MediaModel>? mediasModel;
  final List<ProdBoutiqModel>? produitBoutiques;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CategorieBoutiqueModel({
    this.id,
    this.libelle,
    this.slug,
    this.description,
    this.imageUrl,
    this.mediasModel,
    this.produitBoutiques,
    this.createdAt,
    this.updatedAt,
  });

  factory CategorieBoutiqueModel.fromRawJson(String str) =>
      CategorieBoutiqueModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory CategorieBoutiqueModel.fromJson(Map<String, dynamic> json) =>
      CategorieBoutiqueModel(
        id: json["id"],
        libelle: json["libelle"],
        slug: json["slug"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        mediasModel: json["medias"] == null
            ? null
            : List<MediaModel>.from(
                json["medias"].map((x) => MediaModel.fromJson(x))),
        produitBoutiques: json["produit_boutiques"] == null
            ? null
            : List<ProdBoutiqModel>.from(json["produit_boutiques"]
                .map((x) => ProdBoutiqModel.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
        "slug": slug,
        "description": description,
        "imageUrl": imageUrl,
        "medias": List<dynamic>.from(mediasModel!.map((x) => x.toJson())),
        "produit_boutiques":
            List<dynamic>.from(produitBoutiques!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class ProdBoutiqModel {
  final int? id;
  final String? libelle;
  final String? slug;
  final String? description;
  final int? categorieBoutiqueId;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProdBoutiqModel({
    this.id,
    this.libelle,
    this.slug,
    this.description,
    this.categorieBoutiqueId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });
  factory ProdBoutiqModel.fromRawJson(String str) =>
      ProdBoutiqModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory ProdBoutiqModel.fromJson(Map<String, dynamic> json) =>
      ProdBoutiqModel(
        id: json["id"],
        libelle: json["libelle"],
        slug: json["slug"],
        description: json["description"],
        categorieBoutiqueId: json["categorie_boutique_id"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
        "slug": slug,
        "description": description,
        "categorie_boutique_id": categorieBoutiqueId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
