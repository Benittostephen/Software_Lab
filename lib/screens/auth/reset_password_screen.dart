import 'package:flutter/material.dart';
import 'package:software_lab/screens/auth/login_screen.dart';
import 'package:software_lab/widgets/body_text.dart';
import 'package:software_lab/widgets/custom_button.dart';
import 'package:software_lab/widgets/custom_textfield.dart';

import '../../api/apis.dart';
import '../../widgets/custom_appbar.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token;

  const ResetPasswordScreen({super.key, required this.token});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    String? message = '';

    Future<void> resetPassword() async {
      if (passwordController.text == confirmPasswordController.text) {
        final resetPasswordResponse = await apiService.resetPassword(
          widget.token,
          passwordController.text,
          confirmPasswordController.text,
        );

        setState(() {
          message = resetPasswordResponse.message;
        });

        if (resetPasswordResponse.success) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message!)));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const LoginScreen()));

          print("Password has been changed.");
        } else {
          //Api is not correctly responding (I have given the registered phone number but it is not sending OTP)
          // So I'll Navigate the next screen if it is true or false
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const LoginScreen()));

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message!)));
          // Handle error case
          print("Error: ${resetPasswordResponse.message}");
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Passwords do not match!')));
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const BodyText(headingText: 'Reset Password'),
            CustomTextfield(
              controller: passwordController,
              hintText: 'New Password',
              obscureText: true,
              prefixicon: 'assets/icons/lock.png',
            ),
            const SizedBox(height: 5),
            CustomTextfield(
              controller: confirmPasswordController,
              hintText: 'Confirm New Password',
              obscureText: true,
              prefixicon: 'assets/icons/lock.png',
            ),
            const SizedBox(height: 10),
            CustomButton(buttonName: 'Submit', onTap: resetPassword)
          ],
        ),
      ),
    );
  }
}
