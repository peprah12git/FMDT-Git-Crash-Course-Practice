// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

List<AttendanceModel> attendanceModelFromJson(String str) =>
    List<AttendanceModel>.from(
        json.decode(str).map((x) => AttendanceModel.fromJson(x)));

String attendanceModelToJson(List<AttendanceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttendanceModel {
  String id;
  String employee;
  String email;
  DateTime clockInTime;
  DateTime? clockOutTime;
  int v;

  AttendanceModel({
    required this.id,
    required this.employee,
    required this.email,
    required this.clockInTime,
    required this.clockOutTime,
    required this.v,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        id: json["_id"],
        employee: json["employee"],
        email: json["email"],
        clockInTime: DateTime.parse(json["clockInTime"]),
        clockOutTime: json["clockOutTime"] == null
            ? DateTime.parse("2023-11-13T00:00:32.453Z")
            : DateTime.parse(json["clockOutTime"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "employee": employee,
        "email": email,
        "clockInTime": clockInTime.toIso8601String(),
        "clockOutTime": clockOutTime?.toIso8601String(),
        "__v": v,
      };
}
