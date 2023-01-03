import 'dart:convert';

ActualiteError actualiteErrorFromJson(String str) => ActualiteError.fromJson(json.decode(str)['data']);

String actualiteErrorToJson(ActualiteError data) => json.encode(data.toJson());

class ActualiteError {
  ActualiteError({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory ActualiteError.fromJson(Map<String, dynamic> json) => ActualiteError(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}