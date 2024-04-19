import 'Location.dart';

class User {
  User({
      this.location, 
      this.id, 
      this.name, 
      this.phone, 
      this.email, 
      this.profilePic, 
      this.favorites, 
      this.createdAt,});

  User.fromJson(dynamic json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    id = json['_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    profilePic = json['profilePic'];
    if (json['favorites'] != null) {
      favorites = [];
      json['favorites'].forEach((v) {
        favorites?.add(v);
      });
    }
    createdAt = json['createdAt'];
  }
  Location? location;
  String? id;
  String? name;
  String? phone;
  String? email;
  String? profilePic;
  List<dynamic>? favorites;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['_id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['profilePic'] = profilePic;
    if (favorites != null) {
      map['favorites'] = favorites?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    return map;
  }

}