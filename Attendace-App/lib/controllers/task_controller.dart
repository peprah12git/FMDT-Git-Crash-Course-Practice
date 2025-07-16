// ignore_for_file: unnecessary_null_comparison

// import 'package:get/get.dart';
import 'package:attendance_app/models/employee_task_model.dart';
import 'package:attendance_app/services/task_service.dart';
import 'package:get/state_manager.dart';

TaskService taskService = TaskService();

class TaskController extends GetxController {
  var isLoading = true.obs;
  var employeeTaskHistory = <EmployeeTaskModel>[];

  @override
  void onInit() {
    // getUser();
    // TODO: implement onInit
    super.onInit();
  }

  //Get the employeeTaskHistory information
  void getAllTask() async {
    try {
      var employeeTask = await taskService.getTasksHistory();
      if (employeeTask != null) {
        print(
            "################################################################");
        employeeTaskHistory = employeeTask;
        print(
            "#####################${employeeTaskHistory[0].description}###################");
      }
    } finally {}
    update();
  }
}
