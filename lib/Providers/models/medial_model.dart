import 'dart:convert';

import 'package:jaime_yakro/Config/app_config.dart';

class MediaModel {
  final int? id;
  final String? url;
  final String? type;

  MediaModel({
    this.id,
    this.url,
    this.type,
  });

  factory MediaModel.fromRawJson(String str) =>
      MediaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
        id: json["id"],
        url: AppConfig.baseUrl + json["url"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "type": type,
      };
}
