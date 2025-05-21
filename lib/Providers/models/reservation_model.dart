// To parse this JSON data, do
//
//     final reservationModel = reservationModelFromJson(jsonString);

import 'dart:convert';

List<ReservationModel> reservationModelFromJson(String str) =>
    List<ReservationModel>.from(
        json.decode(str).map((x) => ReservationModel.fromJson(x)));

String reservationModelToJson(List<ReservationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReservationModel {
  int? id;
  int? clientId;
  String? hotelCode;
  dynamic reductionClientId;
  String? nom;
  String? prenoms;
  String? telephone;
  DateTime? dateDebut;
  DateTime? dateFin;
  int? nuitees;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Client? client;
  int? nbrChambre;
  int? prixUnitaire;
  int? prixTotal;
  int? prixTotalAPayer;
  int? reduction;
  dynamic note;
  dynamic hotel;

  ReservationModel(
      {this.id,
      this.clientId,
      this.hotelCode,
      this.reductionClientId,
      this.nom,
      this.prenoms,
      this.telephone,
      this.dateDebut,
      this.dateFin,
      this.nuitees,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.client,
      this.hotel,
      this.note,
      this.nbrChambre,
      this.prixTotal,
      this.prixTotalAPayer,
      this.prixUnitaire,
      this.reduction});

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      ReservationModel(
        id: json["id"],
        clientId: json["client_id"],
        hotelCode: json["hotel_code"],
        reductionClientId: json["reduction_client_id"],
        nom: json["nom"],
        prenoms: json["prenoms"],
        telephone: json["telephone"],
        dateDebut: DateTime.parse(json["date_debut"]),
        dateFin: DateTime.parse(json["date_fin"]),
        nuitees: json["nuitees"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        client: Client.fromJson(json["client"]),
        hotel: json["hotel"],
        nbrChambre: json["nbr_chambre"],
        note: json["note"],
        prixUnitaire: int.parse(json["prix_unitaire"].toString()),
        prixTotal: int.parse(json["total"].toString()), //json["total"],
        prixTotalAPayer: int.parse(json["total_a_payer"].toString()),
        reduction: int.parse(json["reduction"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "hotel_code": hotelCode,
        "reduction_client_id": reductionClientId,
        "nom": nom,
        "prenoms": prenoms,
        "telephone": telephone,
        "date_debut":
            "${dateDebut!.year.toString().padLeft(4, '0')}-${dateDebut!.month.toString().padLeft(2, '0')}-${dateDebut!.day.toString().padLeft(2, '0')}",
        "date_fin":
            "${dateFin!.year.toString().padLeft(4, '0')}-${dateFin!.month.toString().padLeft(2, '0')}-${dateFin!.day.toString().padLeft(2, '0')}",
        "nuitees": nuitees,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "client": client!.toJson(),
        "hotel": hotel,
        "note": note,
      };
}

class Client {
  int? id;
  dynamic equipeId;
  dynamic nom;
  dynamic prenom;
  dynamic pseudo;
  dynamic contact;
  int? code;
  int? isActif;
  int? accountExist;
  dynamic photo;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic twoFactorSecret;
  dynamic twoFactorRecoveryCodes;
  int? source;
  dynamic role;
  String? cloudMessagingToken;
  int? idNotifPush;
  String? deviceId;
  String? deviceModel;
  dynamic poste;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Client({
    this.id,
    this.equipeId,
    this.nom,
    this.prenom,
    this.pseudo,
    this.contact,
    this.code,
    this.isActif,
    this.accountExist,
    this.photo,
    this.email,
    this.emailVerifiedAt,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    this.source,
    this.role,
    this.cloudMessagingToken,
    this.idNotifPush,
    this.deviceId,
    this.deviceModel,
    this.poste,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        equipeId: json["equipe_id"],
        nom: json["nom"],
        prenom: json["prenom"],
        pseudo: json["pseudo"],
        contact: json["contact"],
        code: json["code"],
        isActif: json["is_actif"],
        accountExist: json["account_exist"],
        photo: json["photo"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        twoFactorSecret: json["two_factor_secret"],
        twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
        source: json["source"],
        role: json["role"],
        cloudMessagingToken: json["cloud_messaging_token"],
        idNotifPush: json["id_notif_push"],
        deviceId: json["device_id"],
        deviceModel: json["device_model"],
        poste: json["poste"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "equipe_id": equipeId,
        "nom": nom,
        "prenom": prenom,
        "pseudo": pseudo,
        "contact": contact,
        "code": code,
        "is_actif": isActif,
        "account_exist": accountExist,
        "photo": photo,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "two_factor_secret": twoFactorSecret,
        "two_factor_recovery_codes": twoFactorRecoveryCodes,
        "source": source,
        "role": role,
        "cloud_messaging_token": cloudMessagingToken,
        "id_notif_push": idNotifPush,
        "device_id": deviceId,
        "device_model": deviceModel,
        "poste": poste,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
