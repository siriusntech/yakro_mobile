import 'dart:convert';

AuthError alerteErrorFromJson(String str) => AuthError.fromJson(json.decode(str)['data']);

String alerteErrorToJson(AuthError data) => json.encode(data.toJson());

class AuthError {
  AuthError({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory AuthError.fromJson(Map<String, dynamic> json) => AuthError(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}