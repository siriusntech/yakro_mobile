import 'dart:convert';
VisiteTouristique visiteTouristiqueFromJson(String str) => VisiteTouristique.fromJson(json.decode(str));
String visiteTouristiqueToJson(VisiteTouristique data) => json.encode(data.toJson());

class VisiteTouristique {
  bool? success;
  List<DataVisiteTouristiqueModel>? data;
  dynamic message;

  VisiteTouristique({
    this.success,
    this.data,
    this.message,
  });

  factory VisiteTouristique.fromJson(Map<String, dynamic> json) => VisiteTouristique(
    success: json["success"],
    data: List<DataVisiteTouristiqueModel>.from(json["data"].map((x) => DataVisiteTouristiqueModel.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class DataVisiteTouristiqueModel {
  int? id;
  String? nomVt;
  String? typeQuartierVtLieu;
  String? prix;
  String? description;
  String? avis;
  String? numeroVisitesTouristique;
  dynamic imageUrl;
  List<dynamic>? medias;

  DataVisiteTouristiqueModel({
    this.id,
    this.nomVt,
    this.typeQuartierVtLieu,
    this.prix,
    this.description,
    this.avis,
    this.numeroVisitesTouristique,
    this.imageUrl,
    this.medias,
  });

  factory DataVisiteTouristiqueModel.fromJson(Map<String, dynamic> json) => DataVisiteTouristiqueModel(
    id: json["id"],
    nomVt: json["nom_vt"],
    typeQuartierVtLieu: json["type_quartier_vt_lieu"],
    prix: json["prix"],
    description: json["description"],
    avis: json["avis"],
    numeroVisitesTouristique: json["numero_visitesTouristique"],
    imageUrl: json["imageUrl"],
    medias: List<dynamic>.from(json["medias"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nom_vt": nomVt,
    "type_quartier_vt_lieu": typeQuartierVtLieu,
    "prix": prix,
    "description": description,
    "avis": avis,
    "numero_visitesTouristique": numeroVisitesTouristique,
    "imageUrl": imageUrl,
    "medias": List<dynamic>.from(medias!.map((x) => x)),
  };
}
