import 'dart:convert';

AlerteError alerteErrorFromJson(String str) => AlerteError.fromJson(json.decode(str)['data']);

String alerteErrorToJson(AlerteError data) => json.encode(data.toJson());

class AlerteError {
  AlerteError({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory AlerteError.fromJson(Map<String, dynamic> json) => AlerteError(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}