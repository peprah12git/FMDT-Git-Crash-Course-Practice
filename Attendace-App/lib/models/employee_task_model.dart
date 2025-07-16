// To parse this JSON data, do
//
//     final employeeTaskModel = employeeTaskModelFromJson(jsonString);

import 'dart:convert';

List<EmployeeTaskModel> employeeTaskModelFromJson(String str) =>
    List<EmployeeTaskModel>.from(
        json.decode(str).map((x) => EmployeeTaskModel.fromJson(x)));

String employeeTaskModelToJson(List<EmployeeTaskModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeTaskModel {
  String id;
  Employee employee;
  String title;
  String description;
  DateTime timestamp;
  int v;

  EmployeeTaskModel({
    required this.id,
    required this.employee,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.v,
  });

  factory EmployeeTaskModel.fromJson(Map<String, dynamic> json) =>
      EmployeeTaskModel(
        id: json["_id"],
        employee: employeeValues.map[json["employee"]]!,
        title: json["title"],
        description: json["description"],
        timestamp: DateTime.parse(json["timestamp"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "employee": employeeValues.reverse[employee],
        "title": title,
        "description": description,
        "timestamp": timestamp.toIso8601String(),
        "__v": v,
      };
}

enum Employee { THE_65291966_AADB068184_C28010 }

final employeeValues = EnumValues(
    {"65291966aadb068184c28010": Employee.THE_65291966_AADB068184_C28010});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
