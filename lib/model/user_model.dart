// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.roles,
  });

  int? id;
  String name;
  String email;
  String roles;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        roles: json["roles"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "roles": roles,
      };

  static Map<String, dynamic> toMap(UserModel user) => {
        "id": user.id,
        "name": user.name,
        "email": user.email,
        "roles": user.roles,
      };

  static String encode(List<UserModel> contact) => json.encode(
        contact
            .map<Map<String, dynamic>>((contact) => UserModel.toMap(contact))
            .toList(),
      );
}
