import 'package:attendance_app/components/common_textfield.dart';
import 'package:attendance_app/services/task_service.dart';
import 'package:attendance_app/views/dashboard/splash.dart';
import 'package:flutter/material.dart';

class NewTaskViewComponent extends StatelessWidget {
  NewTaskViewComponent({super.key});
  final TaskService taskService = TaskService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return 
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
           const Text(
                "Create New Task",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: CommonFieldComponent(
            hintText: "Task Title",
            controller: titleController,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonFieldComponent(
                  hintText: "Task Description",
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 20,
                  // maxLength: 1000,
                  controller: descriptionController,
                ),
              ],
            ),
          ),
        ),
        // Spacer(),
        SafeArea(
          child: CommonButton(
            title: "Submit",
            onTap: () {
              taskService.createNewTask(
                context: context,
                title: titleController.text,
                description: descriptionController.text,
              );
            },
          ),
        )
      ],
    );
  }
}
