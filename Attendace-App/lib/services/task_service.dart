// ignore_for_file: null_check_always_fails

import 'package:attendance_app/controllers/task_controller.dart';
import 'package:attendance_app/models/employee_task_model.dart';
import 'package:attendance_app/utils/api_endpoints.dart';
import 'package:attendance_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskService {
  final TaskController taskController = Get.find<TaskController>();

  final GetConnect _connect = GetConnect(timeout: const Duration(seconds: 30));
  Logger logger = Logger();
  Future createNewTask({
    String? title,
    String? description,
    BuildContext? context,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //Get  stored employee Id
    String id = sharedPreferences.getString("userId")!;

    loadingBar(context!, title: "Creating new Task");
    try {
      final res = await _connect.post(
          "${APIEndpoints.base_url}/${APIEndpoints.create_task}",
          {"title": title, "description": description, "employeeId": id});
      if (res.statusCode == 201) {
        logger.d(res.body);

        if (context.mounted) {
          Navigator.pop(context);
          showSnackBar(message: "Task Created Succesfully");
          taskController.getAllTask();
        }
      } else {
        logger.d(res.body);
        if (context.mounted) {
          Navigator.pop(context);
          showSnackBar(message: 'Error Creating Task', isError: true);
        }

        return null!;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  ///Get All Task

  Future<List<EmployeeTaskModel>> getTasksHistory() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String employeedId = sharedPreferences.getString("userId")!;
    final Uri getUri = Uri.parse(
        "${APIEndpoints.base_url}/${APIEndpoints.get_all_task}$employeedId");
    final res = await get(getUri);

    if (res.statusCode == 200) {
      logger.d(res.body);

      return employeeTaskModelFromJson(res.body.toString());
    } else {
      logger.d(res.body);
    }
    return null!;
  }

  //UPDATE T
  Future updateTask({
    String? title,
    String? description,
    String? taskId,
    BuildContext? context,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //Get  stored employee Id
    String id = sharedPreferences.getString("userId")!;

    loadingBar(context!, title: "Updating Task");
    try {
      final res = await _connect.patch(
          "${APIEndpoints.base_url}/${APIEndpoints.update_task}$taskId",
          {"title": title, "description": description, "employeeId": id});
      if (res.statusCode == 200) {
        logger.d(res.body);
        String message = res.body['message'];
        if (context.mounted) {
          taskController.getAllTask();
          Navigator.pop(context);
          showSnackBar(message: message);
        }
      } else {
        logger.d(res.body);
        String message = res.body['message'];
        if (context.mounted) {
          Navigator.pop(context);
          logger.d(res.body);
          showSnackBar(message: message, isError: true);
        }

        return null!;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
