import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoproject/ui/controller/auth_controller.dart';
import 'package:todoproject/ui/screen/login_screen.dart';
import 'package:todoproject/ui/screen/main_bttom_nav_screen.dart';
import 'package:todoproject/ui/widgets/body_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    goToLogin();
  }

  Future<void> goToLogin() async {
    final bool isLoggedIn = await AuthController.checkAuthState();

    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => isLoggedIn
                  ? const MainBottomNavScreen()
                  : const LoginScreen()),
              (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BodyBackground(
          child: Center(
            child: SvgPicture.asset(
              'assets/images/app-logo.svg',
              width: 120,
            ),
          ),
        )
    );
  }
}
