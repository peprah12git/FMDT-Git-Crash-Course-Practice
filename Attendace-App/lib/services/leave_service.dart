// ignore_for_file: null_check_always_fails, use_build_context_synchronously

import 'package:attendance_app/controllers/leave_controller.dart';
import 'package:attendance_app/models/leave_model.dart';
import 'package:attendance_app/utils/api_endpoints.dart';
import 'package:attendance_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaveService {
  final LeaveController leaveController = Get.find<LeaveController>();

  final GetConnect _connect = GetConnect(timeout: const Duration(seconds: 30));
  Logger logger = Logger();
  Future requestLeave({
    String? reason,
    String? leaveType,
    DateTime? startDate,
    DateTime? endDate,
    BuildContext? context,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //Get  stored employee Id
    String id = sharedPreferences.getString("userId")!;

    loadingBar(context!, title: "Sending Leave Request");
    try {
      final res = await _connect
          .post("${APIEndpoints.base_url}/${APIEndpoints.request_leave}", {
        "reason": reason,
        "leaveType": leaveType,
        "startDate": startDate!.toIso8601String(),
        "endDate": endDate!.toIso8601String(),
        "employeeId": id
      });
      if (res.statusCode == 201) {
        logger.d(res.body['message']);
        String message = res.body['message'];

        if (context.mounted) {
          Navigator.pop(context);
          showSnackBar(message: message);
          leaveController.getAllLeaveHistiry();
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

  Future<List<LeaveModel>> getLeaveHistory() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String employeedId = sharedPreferences.getString("userId")!;
    final Uri getUri = Uri.parse(
        "${APIEndpoints.base_url}/${APIEndpoints.getAll_leave_request}$employeedId");
    final res = await get(getUri);

    if (res.statusCode == 200) {
      logger.d(res.body);

      return leaveModelFromJson(res.body);
    } else {
      logger.d(res.body);
    }
    return null!;
  }

  //UPDATE T
  Future updateLeave({
    String? reason,
    String? leaveType,
    DateTime? startDate,
    DateTime? endDate,
    String? leaveId,
    BuildContext? context,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //Get  stored employee Id
    String id = sharedPreferences.getString("userId")!;

    loadingBar(context!, title: "Updating Leave Request");
    try {
      final res = await _connect.patch(
          "${APIEndpoints.base_url}/${APIEndpoints.update_leave_request}$leaveId",
          {
            "reason": reason,
            "leaveType": leaveType,
            "startDate": startDate!.toIso8601String(),
            "endDate": endDate!.toIso8601String(),
            "employeeId": id
          });
      if (res.statusCode == 200) {
        logger.d(res.body);
        String message = res.body['message'];
        if (context.mounted) {
          leaveController.getAllLeaveHistiry();
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
