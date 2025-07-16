import 'package:attendance_app/controllers/task_controller.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:attendance_app/utils/constant.dart';
import 'package:attendance_app/views/home/task/new_task.dart';
import 'package:attendance_app/views/home/task/task_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: commonAppBar(title: "Task"),
          backgroundColor: CustomeColors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                TabBar(
                    enableFeedback: false,
                    labelPadding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    indicatorColor: CustomeColors.primary,
                    padding: EdgeInsets.zero,
                    unselectedLabelColor: CustomeColors.grey,
                    labelColor: CustomeColors.primary,
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                    tabs: const [
                      Tab(
                        child: Text("New Task"),
                      ),
                      Tab(
                        child: Text("Task History"),
                      )
                    ]),
                Expanded(
                    child: TabBarView(
                  children: [
                    NewTaskViewComponent(),

                    GetBuilder<TaskController>(
                        builder: (controller) => TaskHistory(
                              taskController: controller,
                            ))
                    ///////////
                  ],
                ))
              ],
            ),
          )),
    );
  }
}

