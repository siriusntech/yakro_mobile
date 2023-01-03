import 'dart:convert';

DiffusionError diffusionErrorFromJson(String str) => DiffusionError.fromJson(json.decode(str)['data']);

String diffusionErrorToJson(DiffusionError data) => json.encode(data.toJson());

class DiffusionError {
  DiffusionError({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory DiffusionError.fromJson(Map<String, dynamic> json) => DiffusionError(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}