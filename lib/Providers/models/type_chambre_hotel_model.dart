import 'package:jaime_yakro/Providers/path_providers.dart';

class TypeChambreHotel {
  int? id;
  int? hotelId;
  int? typeChambreId;
  String? prix;
  DateTime? createdAt;
  DateTime? updatedAt;
  TypeChambresModel? typeChambres;
  List<MediaModel>? medias;

  TypeChambreHotel({
    this.id,
    this.hotelId,
    this.typeChambreId,
    this.prix,
    this.createdAt,
    this.updatedAt,
    this.typeChambres,
    this.medias,
  });

  factory TypeChambreHotel.fromJson(Map<String, dynamic> json) => TypeChambreHotel(
    id: json["id"],
    hotelId: json["hotel_id"],
    typeChambreId: json["type_chambre_id"],
    prix: json["prix"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    typeChambres: TypeChambresModel.fromJson(json["type_chambres"]),
    medias: List<MediaModel>.from(json["medias"].map((x) => MediaModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hotel_id": hotelId,
    "type_chambre_id": typeChambreId,
    "prix": prix,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "type_chambres": typeChambres!.toJson(),
    "medias": List<dynamic>.from(medias!.map((x) => x.toJson())),
  };
}