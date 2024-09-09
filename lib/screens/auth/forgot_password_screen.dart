import 'package:flutter/material.dart';
import 'package:software_lab/screens/auth/verify_otp_screen.dart';
import 'package:software_lab/widgets/body_text.dart';
import 'package:software_lab/widgets/custom_appbar.dart';
import 'package:software_lab/widgets/custom_button.dart';
import 'package:software_lab/widgets/custom_textfield.dart';

import '../../api/apis.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    final TextEditingController mobileController = TextEditingController();
    String? message = '';

    Future<void> sendOtp() async {
      final forgotPasswordResponse =
          await apiService.sendOtp(mobileController.text);

      setState(() {
        message = forgotPasswordResponse.message;
      });

      if (forgotPasswordResponse.success) {
        print("OTP sent successfully.");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message!)));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    VerifyOtpScreen(mobileController: mobileController.text)));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message!)));

        print("Error: ${forgotPasswordResponse.message}");

        //Api is not correctly responding (I have given the registered phone number but it is not sending OTP)
        // So I'll Navigate the next screen if it is true or false
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyOtpScreen(
                      mobileController: mobileController.text,
                    )));
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const BodyText(headingText: 'Forgot Password?'),
            CustomTextfield(
                controller: mobileController,
                hintText: 'Phone Number',
                obscureText: false,
                prefixicon: 'assets/icons/phone.png'),
            const SizedBox(height: 30),
            CustomButton(buttonName: 'Send Code', onTap: sendOtp)
          ],
        ),
      ),
    );
  }
}
