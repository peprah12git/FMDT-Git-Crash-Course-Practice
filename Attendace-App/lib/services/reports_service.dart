// ignore_for_file: null_check_always_fails, use_build_context_synchronously

import 'package:attendance_app/controllers/reports_controller.dart';
import 'package:attendance_app/models/reports_model.dart';
import 'package:attendance_app/utils/api_endpoints.dart';
import 'package:attendance_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportService {
  final ReportController reportController = Get.find<ReportController>();

  final GetConnect _connect = GetConnect(timeout: const Duration(seconds: 30));
  Logger logger = Logger();
  Future createReport({
    String? month,
    String? week,
    String? title,
    String? body,
    BuildContext? context,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //Get  stored employee Id
    String id = sharedPreferences.getString("userId")!;

    loadingBar(context!,title: "Creating new Report");
    try {
      final res = await _connect.post(
          "${APIEndpoints.base_url}/${APIEndpoints.create_report}", {
        "month": month,
        "week": week,
        "title": title,
        "body": body,
        "id": id
      });
      if (res.statusCode == 201) {
        logger.d(res.body['message']);
        String message = res.body['message'];

        if (context.mounted) {
          Navigator.pop(context);
          showSnackBar(message: message);
          reportController.getReports();
        }
      } else {
        logger.d(res.body);
        String message = res.body['message'];

        if (context.mounted) {
          Navigator.pop(context);
          showSnackBar(message: message, isError: true);
        }

        return null!;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  ///Get All Task

  Future<ReportsModel> getUserReports() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String employeedId = sharedPreferences.getString("userId")!;
    final Uri getUri = Uri.parse(
        "${APIEndpoints.base_url}/${APIEndpoints.get_reports}$employeedId");
    final res = await get(getUri);

    if (res.statusCode == 200) {
      logger.d(res.body);

      return reportsModelFromJson(res.body);
    } else {
      logger.d(res.body);
    }
    return null!;
  }

  //UPDATE T
  Future updateLeave({
    String? month,
    String? week,
    DateTime? startDate,
    DateTime? endDate,
    String? leaveId,
    BuildContext? context,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //Get  stored employee Id
    String id = sharedPreferences.getString("userId")!;

    loadingBar(context!);
    try {
      final res = await _connect.patch(
          "${APIEndpoints.base_url}/${APIEndpoints.update_leave_request}$leaveId",
          {
            "month": month,
            "week": week,
            "startDate": startDate!.toIso8601String(),
            "endDate": endDate!.toIso8601String(),
            "employeeId": id
          });
      if (res.statusCode == 200) {
        logger.d(res.body);
        String message = res.body['message'];
        if (context.mounted) {
          reportController.getReports();
          Navigator.pop(context);
          showSnackBar(message: message);
        }
      } else {
        logger.d(res.body);
        if (context.mounted) {
          Navigator.pop(context);
          logger.d(res.body);
          String message = res.body['message'];

          showSnackBar(message: message, isError: true);
        }

        return null!;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
