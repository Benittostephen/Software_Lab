import 'package:flutter/material.dart';
import 'package:software_lab/screens/auth/login_screen.dart';
import 'package:software_lab/screens/auth/signup/form_info_screen.dart';
import 'package:software_lab/widgets/custom_appbar.dart';
import 'package:software_lab/widgets/custom_button.dart';
import 'package:software_lab/widgets/custom_textfield.dart';
import 'package:software_lab/widgets/signup_top_text.dart';

import '../../../widgets/login_type.dart';

final _formKey1 = GlobalKey<FormState>();

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

    ///Validators///

    String? _validateName(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your name';
      }
      return null;
    }

    String? _validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      }
      // Basic email format validation
      String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(value)) {
        return 'Please enter a valid email address';
      }
      return null;
    }

    String? _validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your password';
      }

      // Password validation criteria
      if (value.length < 8) {
        return 'Password must be at least 8 characters';
      }
      return null;
    }

    String? _validateRePassword(String? value, String password) {
      if (value == null || value.isEmpty) {
        return 'Please re-enter your password';
      } else if (value != password) {
        return 'Passwords do not match';
      }
      return null;
    }

    String? _validatePhoneNo(String? value) {
      final phoneExp = RegExp(r'^[0-9]{10}$');
      if (value == null || value.isEmpty) {
        return 'Please enter your phone number';
      } else if (!phoneExp.hasMatch(value)) {
        return 'Please enter a valid 10-digit phone number';
      }
      return null;
    }

    ///Login///
    void _login() async {
      if (_formKey1.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FarmInfoScreen(
                      fullName: fullNameController.text,
                      email: emailController.text.toLowerCase(),
                      phoneNo: phoneController.text,
                      password: passwordController.text,
                      rePassword: repasswordController.text,
                      role: role,
                    )));
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey1,
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
                  validater: _validateName,
                  hintText: 'Full Name',
                  obscureText: false,
                  prefixicon: 'assets/icons/per.png',
                  controller: fullNameController),
              //const SizedBox(height: 20),
              CustomTextfield(
                hintText: 'Email Address',
                obscureText: false,
                prefixicon: 'assets/icons/at.png',
                controller: emailController,
                validater: _validateEmail,
              ),
              // const SizedBox(height: 20),
              CustomTextfield(
                  validater: _validatePhoneNo,
                  hintText: 'Phone Number',
                  obscureText: false,
                  prefixicon: 'assets/icons/phone.png',
                  controller: phoneController),
              // const SizedBox(height: 20),
              CustomTextfield(
                hintText: 'Password',
                obscureText: true,
                prefixicon: 'assets/icons/lock.png',
                controller: passwordController,
                validater: _validatePassword,
              ),
              // const SizedBox(height: 20),
              CustomTextfield(
                  validater: (value) =>
                      _validateRePassword(value, passwordController.text),
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
                    child: CustomButton(buttonName: 'Continue', onTap: _login),
                  )
                ],
              ),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }
}
