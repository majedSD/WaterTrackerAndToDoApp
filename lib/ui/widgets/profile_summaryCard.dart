import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:todoproject/ui/controller/auth_controller.dart';
import 'package:todoproject/ui/screen/edit_profile.dart';
import 'package:todoproject/ui/screen/login_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
   ProfileSummaryCard({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;
  String base64String=AuthController.user?.photo??"";
  @override
  Widget build(BuildContext context) {
    if(base64String.startsWith('data:image')){
      base64String=
          base64String.replaceFirst(RegExp(r'data:image/[^;]+;base64,'),'');
    }
    Uint8List imageBytes = const Base64Decoder().convert(base64String);

    return ListTile(
      onTap: () {
        if (enableOnTap) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfileScreen(),
            ),
          );
        }
      },
      leading: CircleAvatar(
        child: AuthController.user?.photo == null
            ? const Icon(Icons.person)
            : ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.memory(
            imageBytes,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        fullName,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        AuthController.user?.email ?? '',
        style: const TextStyle(color: Colors.white),
      ),
      trailing: IconButton(
        onPressed: () async {
          await AuthController.clearAuthData();
          // TODO : solve this warning
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => const LoginScreen()), (
              route) => false);
        },
        icon: const Icon(Icons.logout),
      ),
      tileColor: Colors.green,
    );
  }

  String get fullName {
    return '${AuthController.user?.firstName ?? ''} ${AuthController.user?.lastName ?? ')'}';
  }
}