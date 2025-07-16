// To parse this JSON data, do
//
//     final leaveModel = leaveModelFromJson(jsonString);

import 'dart:convert';

List<LeaveModel> leaveModelFromJson(String str) =>
    List<LeaveModel>.from(json.decode(str).map((x) => LeaveModel.fromJson(x)));

String leaveModelToJson(List<LeaveModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveModel {
  String id;
  String employee;
  DateTime startDate;
  DateTime endDate;
  String reason;
  String leaveType;
  DateTime timeStamp;
  String status;
  int v;

  LeaveModel({
    required this.id,
    required this.employee,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.leaveType,
    required this.timeStamp,
    required this.status,
    required this.v,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
        id: json["_id"],
        employee: json["employee"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        reason: json["reason"],
        leaveType: json["leaveType"] ?? "",
        timeStamp: DateTime.parse(json["timeStamp"]),
        status: json["status"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "employee": employee,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "reason": reason,
        "leaveType": leaveType,
        "timeStamp": timeStamp.toIso8601String(),
        "status": status,
        "__v": v,
      };
}
