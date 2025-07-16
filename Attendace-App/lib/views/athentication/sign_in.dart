import 'package:attendance_app/components/common_textfield.dart';
import 'package:attendance_app/services/user_auth.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:attendance_app/utils/constant.dart';
import 'package:attendance_app/views/dashboard/splash.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final AuthService _authService = AuthService();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passWordController = TextEditingController();
  bool isObsecured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    FeatherIcons.send,
                    color: CustomeColors.secondary,
                  ),
                  const Text(
                    "NEXTGEN",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Enter your account to\ncontinue",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              headingText(title: "Enter email"),
              CommonFieldComponent(
                hintText: "jacon@nextgen.com",
                controller: emailController,
              ),
              headingText(title: "Enter password"),
              CommonFieldComponent(
                obscureText: isObsecured,
                hintText: "********",
                prefixIcon: GestureDetector(
                  child: Icon(
                      isObsecured ? FeatherIcons.eyeOff : FeatherIcons.eye),
                  onTap: () => setState(() => isObsecured = !isObsecured),
                ),
                controller: passWordController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox.adaptive(
                        activeColor: CustomeColors.secondary,
                        value: true,
                        onChanged: (va) {},
                      ),
                      const Text("Remember me"),
                    ],
                  ),
                  Text(
                    "Forgot password?",
                    style: TextStyle(
                        color: CustomeColors.secondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  )
                ],
              ),
              const SizedBox(height: 30),
              CommonButton(
                title: "Sign In",
                onTap: () async {
                  _authService.signInUser(
                      email: emailController.text,
                      staffId: passWordController.text,
                      context: context);
                  // Get.toNamed(AppRouter.dashboard);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
