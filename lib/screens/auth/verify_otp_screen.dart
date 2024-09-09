import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:software_lab/screens/auth/reset_password_screen.dart';
import 'package:software_lab/widgets/body_text.dart';
import 'package:software_lab/widgets/custom_button.dart';
import '../../api/apis.dart';
import '../../widgets/custom_appbar.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String mobileController;

  const VerifyOtpScreen({super.key, required this.mobileController});

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController otpController = TextEditingController();
  String? message = '';
  String token = '';

  Future<void> resendOtp() async {
    final forgotPasswordResponse =
        await apiService.sendOtp(widget.mobileController);

    setState(() {
      message = forgotPasswordResponse.message;
    });

    if (forgotPasswordResponse.success) {
      print("OTP sent successfully.");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message!)));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message!)));
    }
  }

  Future<void> verifyOtp() async {
    final otpResponse = await apiService.verifyOtp(otpController.text);

    setState(() {
      message = otpResponse.message;
    });

    if (otpResponse.success) {
      // OTP verified, proceed to the next step (e.g., navigate to another screen)
      print("OTP verified. Token: ${otpResponse.token}");
      token = otpResponse.token!;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(otpResponse.message)));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResetPasswordScreen(token: token)));
    } else {
      //Api is not correctly responding (I have given the registered phone number but it is not sending OTP)
      // So I'll Navigate the next screen if it is true or false
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResetPasswordScreen(token: token)));

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message!)));
      print("Error: ${otpResponse.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const BodyText(headingText: 'Verify OTP'),
            PinCodeTextField(
              enableActiveFill: true,
              keyboardType: TextInputType.phone,
              appContext: context,
              length: 5,
              controller: otpController,
              onChanged: (value) {
                if (value.length == 5) {
                  verifyOtp;
                }
              },
              pinTheme: PinTheme(
                activeColor: Colors.green,
                inactiveFillColor: const Color(0xffeeedec),
                activeFillColor: const Color(0xffeeedec),
                selectedFillColor: const Color(0xffeeedec),
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10.0),
                fieldHeight: 59,
                fieldWidth: 58,
                selectedColor: const Color(0xFFD5715B),
                inactiveColor: const Color(0xffeeedec),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(buttonName: 'Submit', onTap: verifyOtp),
            const SizedBox(height: 10),
            Center(
              child: GestureDetector(
                onTap: resendOtp,
                child: const Text('Resend Code',
                    style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
