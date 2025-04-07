import 'dart:convert';

import 'package:jaime_yakro/Providers/path_providers.dart';

class ProduitBoutiqueModel {
  final int? id;
  final int? categorieBoutiqueId;
  final String? libelle;
  final String? description;
  final List<MediaModel>? mediasModel;
  final String? imageUrl;
  final String? prix;
  final int? quantite;
  final CatBoutiqModel? catBoutiqModel;
  final String? createdAt;
  final String? updatedAt;

  const ProduitBoutiqueModel({
    this.id,
    this.categorieBoutiqueId,
    this.libelle,
    this.description,
    this.mediasModel,
    this.imageUrl,
    this.prix,
    this.quantite,
    this.catBoutiqModel,
    this.createdAt,
    this.updatedAt,
  });

  factory ProduitBoutiqueModel.fromRawJson(String str) =>
      ProduitBoutiqueModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProduitBoutiqueModel.fromJson(Map<String, dynamic> json) =>
      ProduitBoutiqueModel(
        id: json["id"],
        categorieBoutiqueId: json["categorie_boutique_id"],
        libelle: json["libelle"],
        description: json["description"],
        mediasModel: json["medias"] == null
            ? null
            : List<MediaModel>.from(
                json["medias"].map((x) => MediaModel.fromJson(x))),
        imageUrl: json["imageUrl"],
        prix: json["prix"],
        quantite: json["quantite"],
        catBoutiqModel: json["categorie_boutiques"] == null
            ? null
            : CatBoutiqModel.fromJson(json["categorie_boutiques"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categorie_boutique_id": categorieBoutiqueId,
        "libelle": libelle,
        "description": description,
        "medias": List<dynamic>.from(mediasModel!.map((x) => x.toJson())),
        "imageUrl": imageUrl,
        "prix": prix,
        "quantite": quantite,
        "categorie_boutiques":
            catBoutiqModel == null ? null : catBoutiqModel!.toJson(),
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class CatBoutiqModel {
  final int? id;
  final String? libelle;
  final String? description;
  final String? slug;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CatBoutiqModel({
    this.id,
    this.libelle,
    this.description,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  factory CatBoutiqModel.fromRawJson(String str) =>
      CatBoutiqModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CatBoutiqModel.fromJson(Map<String, dynamic> json) => CatBoutiqModel(
        id: json["id"],
        libelle: json["libelle"],
        description: json["description"],
        slug: json["slug"],
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
        "description": description,
        "slug": slug,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
