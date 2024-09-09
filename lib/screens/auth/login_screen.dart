import 'package:flutter/material.dart';
import 'package:software_lab/screens/auth/forgot_password_screen.dart';
import 'package:software_lab/screens/auth/signup/registration.dart';
import 'package:software_lab/screens/home_page.dart';
import 'package:software_lab/widgets/const.dart';
import 'package:software_lab/widgets/custom_appbar.dart';
import 'package:software_lab/widgets/custom_button.dart';
import '../../api/apis.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/login_type.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? loginMessage = '';

  Future<void> loginUser() async {
    final loginResponse = await apiService.loginUser(
      email: emailController.text,
      password: passwordController.text,
      role: "farmer",
      deviceToken: "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
      type: "email/facebook/google/apple",
      socialId: "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
    );

    setState(() {
      loginMessage = loginResponse.message;
    });

    if (loginResponse.success) {
      emailController.clear();
      passwordController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(loginResponse.message)));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      print(loginResponse.message);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(loginResponse.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'New here?',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFFa7a6a5),
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegistrationScreen()));
                      },
                      child: Text(
                        'Create account',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                CustomTextfield(
                  controller: emailController,
                  obscureText: false,
                  prefixicon: 'assets/icons/at.png',
                  hintText: 'Email Address',
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 40, minHeight: 20),
                        filled: true,
                        fillColor: const Color(0xFFeeedec),
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                            color: Color(0xFFa7a6a5),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        prefixIcon: Image.asset(
                          'assets/icons/lock.png',
                          scale: 3.3,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xFFeeedec), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Color(0xFFeeedec), width: 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          //borderSide: BorderSide.none,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen()));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 15),
                            child: Text(
                              'Forgot?',
                              style: TextStyle(
                                  color: Color(0xffed5715b), fontSize: 14),
                            ),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        labelStyle: const TextStyle(
                          color: Color(0xfff454545),
                        )),
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(buttonName: 'Login', onTap: loginUser),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'or login with',
                    style: TextStyle(
                        color: Color(0xFFa7a6a5),
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 30),
                const LoginType(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
