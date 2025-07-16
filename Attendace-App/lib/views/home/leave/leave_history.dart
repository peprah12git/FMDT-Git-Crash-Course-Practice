import 'package:attendance_app/controllers/leave_controller.dart';
import 'package:attendance_app/models/leave_model.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:attendance_app/utils/constant.dart';
import 'package:attendance_app/views/home/leave/update_leave.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:light_modal_bottom_sheet/light_modal_bottom_sheet.dart';

class LeaveHistory extends StatelessWidget {
  const LeaveHistory({super.key});
  // LeaveController? leaveController = Get.find<LeaveController>();
  formatDate({int? index, LeaveModel? leaveController}) {
    final DateTime timeCreate = leaveController!.timeStamp;
    final DateFormat formatter = DateFormat("MMM d");
    final String formatted = formatter.format(timeCreate);
    final DateFormat formatteredTime = DateFormat().add_jm();
    final String formattedTime = formatteredTime.format(timeCreate);
    return "$formatted $formattedTime";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.white,
      appBar: commonAppBar(title: "Leave History"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<LeaveController>(builder: (leaveController) {
          return ListView.builder(
              itemCount: leaveController.employeeLeaveHistory.length,
              itemBuilder: (context, index) {
                LeaveModel leaveData =
                    leaveController.employeeLeaveHistory.reversed.toList()[index];
                String status = leaveData.status;
                String time =
                    formatDate(index: index, leaveController: leaveData);
        
                return leaveController.employeeLeaveHistory.isEmpty
                    ? const Center(
                        child: Text("No Leave History"),
                      )
                    : GestureDetector(
                        onTap: () {
                          showMaterialModalBottomSheet(
                            backgroundColor: CustomeColors.white,
                            expand: true,
                            context: context,
                            builder: (context) => UpdateLeaveComponent(
                              leaveModel: leaveData,
                            ),
                          );
                        },
                        child: Card(
                          elevation: .4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          surfaceTintColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: const RoundedRectangleBorder(),
                          child: ListTile(
                            leading: Icon(
                              status == "approved"
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: CustomeColors.primary,
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Material(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  color: status == "pending"
                                      ? CustomeColors.yellow
                                      : status == "rejected"
                                          ? CustomeColors.red
                                          : CustomeColors.lightGreen,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    child: Text(status,
                                        style: TextStyle(
                                            color: CustomeColors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                                Text(
                                  time,
                                  style: TextStyle(
                                      fontSize: 12, color: CustomeColors.grey),
                                ),
                              ],
                            ),
                            title: Text(leaveData.leaveType),
                            subtitle: Text(
                              leaveData.reason,
                              style: TextStyle(
                                  fontSize: 12, color: CustomeColors.grey),
                            ),
                          ),
                        ),
                      );
              });
        }),
      ),
    );
  }
}
