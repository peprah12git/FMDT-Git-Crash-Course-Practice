import 'dart:io';

import 'package:attendance_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

Future<bool> showExitPopup(context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Do you want to exit?",
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        exit(0);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomeColors.secondary),
                      child: const Text("Yes"),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child:
                        const Text("No", style: TextStyle(color: Colors.black)),
                  ))
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

Future<dynamic> loadingBar(BuildContext context,
    {Widget? widget, String? title}) {
  return showDialog(
    // barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: CustomeColors.white.withOpacity(0.0),
        elevation: 0.0,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget ??
                CircularProgressIndicator(
                  backgroundColor: CustomeColors.white,
                  valueColor: AlwaysStoppedAnimation(CustomeColors.primary),
                ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                title ?? "Please wait...",
                style: TextStyle(color: CustomeColors.white),
              ),
            ),
          ],
        ),
      );
    },
  );
}

showSnackBar({String? message, bool isError = false}) {
  return Get.snackbar(
    message!,
    "",
    titleText: Text(
      message,
      style: TextStyle(color: CustomeColors.white),
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: isError ? Colors.red : CustomeColors.primary,
  );
}

Padding headingText({String? title}) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 10),
    child: Text(title!),
  );
}

AppBar commonAppBar({String? title, bool canGoback = true}) {
  return AppBar(
    surfaceTintColor: CustomeColors.white,
    automaticallyImplyLeading: canGoback,
    backgroundColor: Colors.white,
    title: Text(title!,style: const TextStyle(fontSize: 20),),
  );
}
