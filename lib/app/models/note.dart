class Note {
  bool? success;
  NoteData? data;

  Note({this.success, this.data});

  Note.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new NoteData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NoteData {
  int? hotelId;
  int? restaurantId;
  double? valeur;
  int? userId;
  String? commentaireHotel;


  NoteData({this.hotelId, this.restaurantId, this.valeur, this.userId, this.commentaireHotel});

  NoteData.fromJson(Map<String, dynamic> json) {
    hotelId = json['hotel_id'];
    restaurantId = json['restaurant_id'];
    valeur = json['valeur'];
    userId = json['user_id'];
    commentaireHotel = json['commentaireHotel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotel_id'] = this.hotelId;
    data['restaurant_id'] = this.restaurantId;
    data['valeur'] = this.valeur;
    data['user_id'] = this.userId;
    data['commentaireHotel'] = this.commentaireHotel;
    return data;
  }
}
