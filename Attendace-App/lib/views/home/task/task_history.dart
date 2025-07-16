import 'package:attendance_app/controllers/task_controller.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:attendance_app/views/home/task/update_task.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:light_modal_bottom_sheet/light_modal_bottom_sheet.dart';

class TaskHistory extends StatelessWidget {
  TaskHistory({super.key, this.taskController});
  TaskController? taskController;
  formatDate({int? index}) {
    final DateTime timeCreate =
        taskController!.employeeTaskHistory[index!].timestamp;
    final DateFormat formatter = DateFormat("MMM d");
    final String formatted = formatter.format(timeCreate);
    final DateFormat formatteredTime = DateFormat().add_jm();
    final String formattedTime = formatteredTime.format(timeCreate);
    return "$formatted $formattedTime";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
          itemCount: taskController!.employeeTaskHistory.length,
          itemBuilder: (context, index) {
            String time = formatDate(index: index);
            return taskController!.employeeTaskHistory.isEmpty
                ? const Center(
                    child: Text("No Task History"),
                  )
                : Card(
                    elevation: .4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    surfaceTintColor: CustomeColors.white,
                    color: CustomeColors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    child: ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: CustomeColors.primary,
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showMaterialModalBottomSheet(
                                  backgroundColor: CustomeColors.white,
                                  expand: true,
                                  context: context,
                                  builder: (context) => UpdateTaskComponent(
                                        employeeTaskModel: taskController!
                                            .employeeTaskHistory[index],
                                      ));
                            },
                            child: const Icon(
                              FeatherIcons.edit,
                              size: 20,
                            ),
                          ),
                          Text(
                            time,
                            style: TextStyle(
                                fontSize: 12, color: CustomeColors.grey),
                          ),
                        ],
                      ),
                      title: Text(
                          taskController!.employeeTaskHistory[index].title),
                      subtitle: Text(
                        taskController!.employeeTaskHistory[index].description,
                        style:
                            TextStyle(fontSize: 12, color: CustomeColors.grey),
                      ),
                    ),
                  );
          }),
    );
  }
}
