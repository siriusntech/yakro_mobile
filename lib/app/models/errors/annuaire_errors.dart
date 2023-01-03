import 'dart:convert';

AnnuaireError annuaireErrorFromJson(String str) => AnnuaireError.fromJson(json.decode(str)['data']);

String annuaireErrorToJson(AnnuaireError data) => json.encode(data.toJson());

class AnnuaireError {
  AnnuaireError({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory AnnuaireError.fromJson(Map<String, dynamic> json) => AnnuaireError(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}