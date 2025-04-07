import 'dart:convert';

import 'package:jaime_yakro/Providers/path_providers.dart';

class AuthModel {
  final UserModel? userModel;
  final String? token;
  final List<OrderBoutiqueModel>? orderBoutiqueModelList;

  AuthModel({
    this.userModel,
    this.token,
    this.orderBoutiqueModelList,
  });

  factory AuthModel.fromRawJson(String str) =>
      AuthModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        userModel: UserModel.fromJson(json["user"]),
        token: json["token"],
        orderBoutiqueModelList: json['order_boutiques'] == null
            ? null
            : List<OrderBoutiqueModel>.from(json["order_boutiques"]
                .map((x) => OrderBoutiqueModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": userModel!.toJson(),
        "token": token,
      };
}

class UserModel {
  final int? id;
  final dynamic equipeId;
  final dynamic nom;
  final dynamic prenom;
  final dynamic pseudo;
  final dynamic contact;
  final int? code;
  final int? isActif;
  final int? accountExist;
  final dynamic photo;
  final dynamic email;
  final dynamic emailVerifiedAt;
  final dynamic twoFactorSecret;
  final dynamic twoFactorRecoveryCodes;
  final int? source;
  final dynamic role;
  final String? cloudMessagingToken;
  final String? deviceId;
  final String? deviceModel;
  final dynamic poste;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  UserModel({
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
    this.deviceId,
    this.deviceModel,
    this.poste,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
        "device_id": deviceId,
        "device_model": deviceModel,
        "poste": poste,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
