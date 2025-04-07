class TypeChambresModel {
  int? id;
  String? libelle;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;

  TypeChambresModel({
    this.id,
    this.libelle,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  factory TypeChambresModel.fromJson(Map<String, dynamic> json) => TypeChambresModel(
    id: json["id"],
    libelle: json["libelle"],
    slug: json["slug"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "libelle": libelle,
    "slug": slug,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}