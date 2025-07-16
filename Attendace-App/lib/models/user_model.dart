// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String message;
  Employee employee;

  UserModel({
    required this.message,
    required this.employee,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        employee: Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "employee": employee.toJson(),
      };
}

class Employee {
  String? email;
  String? name;
  String? staffId;
  String? role;
  String? id;

  Employee({
    this.email,
    this.name,
    this.staffId,
    this.role,
    this.id,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        email: json["email"],
        name: json["name"],
        staffId: json["staffId"],
        role: json["role"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "staffId": staffId,
        "role": role,
        "id": id,
      };
}
