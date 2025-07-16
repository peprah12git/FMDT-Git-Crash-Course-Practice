import 'package:attendance_app/services/user_auth.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:attendance_app/utils/shared_prefs.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getUserProfile();
    AuthService authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomeColors.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height / 4,
            color: CustomeColors.primary,
            child: Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                  ),
                  Text(
                    user["name"],
                    style: TextStyle(
                        fontSize: 20,
                        color: CustomeColors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    user["role"],
                    style: TextStyle(color: CustomeColors.white),
                  ),
                ],
              ),
            ),
          ),
          const ProfileCard(
            title: "Company Policy",
            icon: FeatherIcons.user,
          ),
          const ProfileCard(
            title: "Contact Admin",
            icon: FeatherIcons.phoneCall,
          ),
          ProfileCard(
            title: "Log out",
            icon: FeatherIcons.logOut,
            onTap: () {
              authService.logoutUser(context: context);
            },
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, this.title, this.onTap, this.icon});
  final String? title;
  final void Function()? onTap;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      surfaceTintColor: CustomeColors.white,
      child: ListTile(
        onTap: onTap,
        title: Text(title!),
        trailing: Icon(
          icon,
          size: 20,
          color: CustomeColors.primary,
        ),
      ),
    );
  }
}

///0549530547