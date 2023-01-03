import 'dart:convert';

AgendaError agendaErrorFromJson(String str) => AgendaError.fromJson(json.decode(str)['data']);

String agendaErrorToJson(AgendaError data) => json.encode(data.toJson());

class AgendaError {
  AgendaError({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory AgendaError.fromJson(Map<String, dynamic> json) => AgendaError(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}