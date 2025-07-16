import 'package:attendance_app/components/common_textfield.dart';
import 'package:attendance_app/models/employee_task_model.dart';
import 'package:attendance_app/services/task_service.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:attendance_app/views/dashboard/splash.dart';
import 'package:flutter/material.dart';

class UpdateReprtComponent extends StatelessWidget {
  UpdateReprtComponent({super.key, this.employeeTaskModel});

  final EmployeeTaskModel? employeeTaskModel;
  final TaskService taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: employeeTaskModel!.title);
    final TextEditingController descriptionController =
        TextEditingController(text: employeeTaskModel!.description);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.cancel, color: CustomeColors.grey),
                ),
              ),
              const Text("Update Task"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: CommonFieldComponent(
                  hintText: "Task Title",
                  controller: titleController,
                ),
              ),
              CommonFieldComponent(
                hintText: "Task Description",
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 20,
                // maxLength: 1000,
                controller: descriptionController,
              ),
              const SizedBox(height: 100),
              // Spacer(),
              SafeArea(
                child: CommonButton(
                  title: "Submit",
                  onTap: () {
                    taskService
                        .updateTask(
                            context: context,
                            title: titleController.text,
                            description: descriptionController.text,
                            taskId: employeeTaskModel!.id)
                        .then((value) {
                      Navigator.pop(context);
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
