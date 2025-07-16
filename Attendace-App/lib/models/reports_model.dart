// To parse this JSON data, do
//
//     final reportsModel = reportsModelFromJson(jsonString);

import 'dart:convert';

ReportsModel reportsModelFromJson(String str) => ReportsModel.fromJson(json.decode(str));

String reportsModelToJson(ReportsModel data) => json.encode(data.toJson());

class ReportsModel {
    List<Report> reports;

    ReportsModel({
        required this.reports,
    });

    factory ReportsModel.fromJson(Map<String, dynamic> json) => ReportsModel(
        reports: List<Report>.from(json["reports"].map((x) => Report.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "reports": List<dynamic>.from(reports.map((x) => x.toJson())),
    };
}

class Report {
    String id;
    String employee;
    List<WeeklyReport> weeklyReports;
    int v;

    Report({
        required this.id,
        required this.employee,
        required this.weeklyReports,
        required this.v,
    });

    factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["_id"],
        employee: json["employee"],
        weeklyReports: List<WeeklyReport>.from(json["weeklyReports"].map((x) => WeeklyReport.fromJson(x))),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "employee": employee,
        "weeklyReports": List<dynamic>.from(weeklyReports.map((x) => x.toJson())),
        "__v": v,
    };
}

class WeeklyReport {
    String month;
    String week;
    String title;
    String body;
    DateTime timeStamp;
    String status;
    String id;

    WeeklyReport({
        required this.month,
        required this.week,
        required this.title,
        required this.body,
        required this.timeStamp,
        required this.status,
        required this.id,
    });

    factory WeeklyReport.fromJson(Map<String, dynamic> json) => WeeklyReport(
        month: json["month"],
        week: json["week"],
        title: json["title"],
        body: json["body"],
        timeStamp: DateTime.parse(json["timeStamp"]),
        status: json["status"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "month": month,
        "week": week,
        "title": title,
        "body": body,
        "timeStamp": timeStamp.toIso8601String(),
        "status": status,
        "_id": id,
    };
}
