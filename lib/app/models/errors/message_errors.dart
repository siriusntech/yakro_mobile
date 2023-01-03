import 'dart:convert';

MessageError messageErrorFromJson(String str) => MessageError.fromJson(json.decode(str)['data']);

String messageErrorToJson(MessageError data) => json.encode(data.toJson());

class MessageError {
  MessageError({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory MessageError.fromJson(Map<String, dynamic> json) => MessageError(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}