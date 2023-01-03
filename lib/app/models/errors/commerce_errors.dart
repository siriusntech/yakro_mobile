import 'dart:convert';

CommerceError commerceErrorFromJson(String str) => CommerceError.fromJson(json.decode(str)['data']);

String commerceErrorToJson(CommerceError data) => json.encode(data.toJson());

class CommerceError {
  CommerceError({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory CommerceError.fromJson(Map<String, dynamic> json) => CommerceError(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}