import 'package:attendance_app/components/common_textfield.dart';
import 'package:attendance_app/models/leave_model.dart';
import 'package:attendance_app/services/leave_service.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:attendance_app/views/dashboard/splash.dart';
import 'package:attendance_app/views/home/leave/leave.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateLeaveComponent extends StatefulWidget {
  const UpdateLeaveComponent({super.key, this.leaveModel});

  final LeaveModel? leaveModel;

  @override
  State<UpdateLeaveComponent> createState() => _UpdateLeaveComponentState();
}

class _UpdateLeaveComponentState extends State<UpdateLeaveComponent> {
  final LeaveService leaveService = LeaveService();
  List leaveType = ["Sick", "Maternity"];
  String? selectedleaveType;

  String? formattedStartDate;
  String? formattedEndDate;

  @override
  Widget build(BuildContext context) {
    DateTime startSelectedDate = widget.leaveModel!.startDate;
    DateTime endSelectedDate = widget.leaveModel!.endDate;
    final TextEditingController reasonController =
        TextEditingController(text: widget.leaveModel!.reason);

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.cancel, color: CustomeColors.grey),
                ),
              ),
              const Text(
                "Update Leave",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              CommomDropDownButton(
                leaveType: leaveType,
                selectedleaveType: selectedleaveType,
                onChanged: (v) {
                  setState(() {
                    selectedleaveType = v.toString();
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: () => selectLeaveDate(
                    context: context,
                    title: "Select leave start date",
                    selectedDate: startSelectedDate,
                    onDateTimeChanged: (DateTime value) {
                      setState(() {
                        startSelectedDate = value;
                        final DateTime timeCreate = startSelectedDate;

                        final DateFormat formatter = DateFormat("MMMM d yyyy");
                        formattedStartDate = formatter.format(timeCreate);
                        print(formattedStartDate);
                        // print(_startSelectedDate);
                      });
                    },
                  ),
                  child: CommonFieldComponent(
                    enable: false,
                    hintColor: CustomeColors.blackMedium,
                    hintText: formattedStartDate ?? "Start Date ",
                    // controller: titleController,
                    prefixIcon: const Icon(FeatherIcons.calendar),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => selectLeaveDate(
                  context: context,
                  selectedDate: endSelectedDate,
                  title: "Select leave end date",
                  onDateTimeChanged: (DateTime value) {
                    setState(() {
                      endSelectedDate = value;
                      final DateTime timeCreate = endSelectedDate;

                      final DateFormat formatter = DateFormat("MMMM d yyyy");
                      formattedEndDate = formatter.format(timeCreate);
                      print(formattedEndDate);
                      print(endSelectedDate);
                    });
                  },
                ),
                child: CommonFieldComponent(
                  hintText: formattedEndDate ?? "End Date",
                  enable: false,
                  hintColor: CustomeColors.blackMedium,

                  // controller: titleController,
                  prefixIcon: const Icon(FeatherIcons.calendar),
                ),
              ),
              const SizedBox(height: 20),

              CommonFieldComponent(
                hintText: "Task Description",
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: 20,
                // maxLength: 1000,
                controller: reasonController,
              ),
              const SizedBox(height: 100),
              // Spacer(),
              SafeArea(
                child: CommonButton(
                  title: "Update",
                  onTap: () {
                    leaveService
                        .updateLeave(
                            context: context,
                            startDate: startSelectedDate,
                            endDate: endSelectedDate,
                            reason: reasonController.text,
                            leaveType: selectedleaveType ??
                                widget.leaveModel!.leaveType,
                            // description: descriptionController.text,
                            leaveId: widget.leaveModel!.id)
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
