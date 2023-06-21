// To parse this JSON data, do
//
//     final hotelModel = hotelModelFromJson(jsonString);

import 'dart:convert';

HotelModel hotelModelFromJson(String str) => HotelModel.fromJson(json.decode(str));

String hotelModelToJson(HotelModel data) => json.encode(data.toJson());

class HotelModel {
  bool? success;
  List<DataHotelModel>? data;
  dynamic message;

  HotelModel({
    this.success,
    this.data,
    this.message,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
    success: json["success"],
    data: List<DataHotelModel>.from(json["data"].map((x) => DataHotelModel.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class DataHotelModel {
  int? id;
  String? nomHotel;
  String? typeQuartierId;
  String? typeHotelId;
  String? prix;
  String? description;
  String? avis;
  String? numeroHotel;
  String? contact;
  String? imageUrl;
  List<Media>? medias;

  DataHotelModel({
    this.id,
    this.nomHotel,
    this.typeQuartierId,
    this.typeHotelId,
    this.prix,
    this.description,
    this.avis,
    this.numeroHotel,
    this.contact,
    this.imageUrl,
    this.medias,
  });

  factory DataHotelModel.fromJson(Map<String, dynamic> json) => DataHotelModel(
    id: json["id"],
    nomHotel: json["nom_hotel"],
    typeQuartierId: json["type_quartier_id"],
    typeHotelId: json["type_hotel_id"],
    prix: json["prix"],
    description: json["description"],
    avis: json["avis"],
    numeroHotel: json["numero_hotel"],
    contact: json["contact"],
    imageUrl: json["imageUrl"],
    medias: List<Media>.from(json["medias"].map((x) => Media.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nom_hotel": nomHotel,
    "type_quartier_id": typeQuartierId,
    "type_hotel_id": typeHotelId,
    "prix": prix,
    "description": description,
    "avis": avis,
    "numero_hotel": numeroHotel,
    "contact": contact,
    "imageUrl": imageUrl,
    "medias": List<dynamic>.from(medias!.map((x) => x.toJson())),
  };
}

class Media {
  int? id;
  String? url;
  String? type;

  Media({
    this.id,
    this.url,
    this.type,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json["id"],
    url: json["url"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "type": type,
  };
}
