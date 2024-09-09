import 'package:flutter/material.dart';
import 'package:software_lab/screens/auth/login_screen.dart';
import 'package:software_lab/screens/auth/signup/form_info_screen.dart';
import 'package:software_lab/widgets/custom_appbar.dart';
import 'package:software_lab/widgets/custom_button.dart';
import 'package:software_lab/widgets/custom_textfield.dart';
import 'package:software_lab/widgets/signup_top_text.dart';

import '../../../widgets/login_type.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController repasswordController = TextEditingController();
    const String role = 'farmer';

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SignupTopText(
              headingText: 'Welcome!',
              pageNo: 1,
            ),
            const LoginType(),
            const SizedBox(height: 20),
            const Center(
                child: Text('or signup with',
                    style: TextStyle(
                        color: Color(0xFFa7a6a5),
                        fontSize: 10,
                        fontWeight: FontWeight.w500))),
            const SizedBox(height: 30),
            CustomTextfield(
                hintText: 'Full Name',
                obscureText: false,
                prefixicon: 'assets/icons/per.png',
                controller: fullNameController),
            const SizedBox(height: 20),
            CustomTextfield(
                hintText: 'Email Address',
                obscureText: false,
                prefixicon: 'assets/icons/at.png',
                controller: emailController),
            const SizedBox(height: 20),
            CustomTextfield(
                hintText: 'Phone Number',
                obscureText: false,
                prefixicon: 'assets/icons/phone.png',
                controller: phoneController),
            const SizedBox(height: 20),
            CustomTextfield(
                hintText: 'Password',
                obscureText: true,
                prefixicon: 'assets/icons/lock.png',
                controller: passwordController),
            const SizedBox(height: 20),
            CustomTextfield(
                hintText: 'Re-enter Password',
                obscureText: true,
                prefixicon: 'assets/icons/lock.png',
                controller: repasswordController),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text('Login',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            color: Colors.black)),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CustomButton(
                      buttonName: 'Continue',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FarmInfoScreen(
                                      fullName: fullNameController.text,
                                      email: emailController.text,
                                      phoneNo: phoneController.text,
                                      password: passwordController.text,
                                      rePassword: repasswordController.text,
                                      role: role,
                                    )));
                      }),
                )
              ],
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}
