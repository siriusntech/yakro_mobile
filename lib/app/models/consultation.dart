import 'dart:convert';

// RECUPERE STRING ET CONVERTIR EN JSON ET RENVOYER UNE LISTE D'OBJET CONSULTATION
List<Consultation> consultationFromJson(String str) => List<Consultation>.from(json.decode(str)['data'].map((x) => Consultation.fromJson(x)));
// RETOURNE UN OBJET CONSULTATION
String consultationToJson(List<Consultation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Consultation{
   int? un_read_actualite_count;
   int? un_read_alerte_count;
   int? un_read_agenda_count;
   int? un_read_commerce_count;
   int? un_read_discussion_count;
   int? un_read_job_count;
   int? un_read_sujet_count;

   Consultation({this.un_read_actualite_count, this.un_read_alerte_count, this.un_read_agenda_count, this.un_read_commerce_count,
               this.un_read_discussion_count, this.un_read_sujet_count, this.un_read_job_count});

   factory Consultation.fromJson(Map<dynamic, dynamic> json) => Consultation(
       un_read_actualite_count: json["un_read_actualite_count"] ?? 0,
       un_read_alerte_count: json["un_read_alerte_count"] ?? 0,
       un_read_agenda_count: json["un_read_agenda_count"] ?? 0,
       un_read_commerce_count: json["un_read_commerce_count"] ?? 0,
       un_read_discussion_count: json["un_read_discussion_count"] ?? 0,
       un_read_sujet_count: json["un_read_sujet_count"] ?? 0,
       un_read_job_count: json["un_read_job_count"] ?? 0,
   );

   Map<String, dynamic> toJson() => {
      "un_read_actualite_count": un_read_actualite_count,
      "un_read_alerte_count": un_read_alerte_count,
      "un_read_agenda_count": un_read_agenda_count,
      "un_read_commerce_count": un_read_commerce_count,
      "un_read_discussion_count": un_read_discussion_count,
      "un_read_sujet_count": un_read_sujet_count,
      "un_read_job_count": un_read_job_count,
   };
}