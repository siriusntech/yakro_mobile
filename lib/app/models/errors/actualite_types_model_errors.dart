import 'dart:convert';

ActualiteTypeModelError actualiteErrorFromJson(String str) => ActualiteTypeModelError.fromJson(json.decode(str)['data']);

String actualiteErrorToJson(ActualiteTypeModelError data) => json.encode(data.toJson());

class ActualiteTypeModelError {
  ActualiteTypeModelError({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory ActualiteTypeModelError.fromJson(Map<String, dynamic> json) => ActualiteTypeModelError(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}