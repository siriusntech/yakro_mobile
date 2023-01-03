import 'dart:convert';

CommerceTypeModelError commerceErrorFromJson(String str) => CommerceTypeModelError.fromJson(json.decode(str)['data']);

String commerceErrorToJson(CommerceTypeModelError data) => json.encode(data.toJson());

class CommerceTypeModelError {
  CommerceTypeModelError({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory CommerceTypeModelError.fromJson(Map<String, dynamic> json) => CommerceTypeModelError(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}