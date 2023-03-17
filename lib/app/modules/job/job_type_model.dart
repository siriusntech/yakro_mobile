
import 'dart:convert';

List<JobTypeModel> jobTypeModelFromJson(String str) => List<JobTypeModel>.from(json.decode(str)['data'].map((x) => JobTypeModel.fromJson(x)));
// RETOURNE UN OBJET JOB TYPE
String jobTypeModelToJson(List<JobTypeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobTypeModel {
  int? id;
  String? nom;

  JobTypeModel({this.id, this.nom});

  JobTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nom'] = nom;
    return data;
  }
}
