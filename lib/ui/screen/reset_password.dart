import 'package:flutter/material.dart';
import 'package:todoproject/data/networkcaller/network_caller.dart';
import 'package:todoproject/data/networkcaller/network_response.dart';
import 'package:todoproject/data/utility/urls.dart';
import 'package:todoproject/ui/screen/login_screen.dart';
import 'package:todoproject/ui/widgets/body_background.dart';
import 'package:todoproject/ui/widgets/snack_message.dart';

class SetPasswordScreen extends StatefulWidget {
  final String email;
  final String pin;
  const SetPasswordScreen({super.key, required this.email, required this.pin});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _newPasswordTEController =
  TextEditingController();
  final TextEditingController _confirmPasswordTEController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool setPasswordInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BodyBackground(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 60,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Set Password",
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    Text(
                      "Minimum length password 8 character with letters & numbers combination",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _newPasswordTEController,
                      decoration: const InputDecoration(
                        hintText: "New Password",
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your New Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _confirmPasswordTEController,
                      decoration: const InputDecoration(
                        hintText: "Confirm Password",
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Visibility(
                      visible: setPasswordInProgress == false,
                      replacement: Center(
                        child: CircularProgressIndicator(
                        ),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: setNewPassword,
                          child: const Text("Confirm"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have account?",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                                  (route) => false,
                            );
                          },
                          child: Text(
                            "Sign in",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> setNewPassword() async {
    if (_formKey.currentState!.validate()) {
      if (_newPasswordTEController.text.length > 7) {
        if (_newPasswordTEController.text ==
            _confirmPasswordTEController.text) {
          setPasswordInProgress = true;
          if (mounted) {
            setState(() {});
          }
          final NetworkResponse response = await NetworkCaller().postRequest(
            Urls.setNewPassword,
            body: {
              "email": widget.email,
              "OTP": widget.pin,
              "password": _newPasswordTEController.text,
            },
          );
          setPasswordInProgress = false;
          if (mounted) {
            setState(() {});
          }

          if (response.isSuccess) {
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
              );
            }
          } else {
            if (mounted) {
              showSnackMessage(context, "Action Failed! Please try again.", true);
            }
          }
        } else {
          showSnackMessage(context, "Confirm password does not matched", true);
        }
      } else {
        showSnackMessage(context, "Minimum password length must be 8", true);
      }
    }
  }
}