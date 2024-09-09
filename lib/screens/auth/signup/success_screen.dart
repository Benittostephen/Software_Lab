import 'package:flutter/material.dart';
import 'package:software_lab/screens/auth/login_screen.dart';
import 'package:software_lab/screens/home_page.dart';
import 'package:software_lab/widgets/custom_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 170),
            Image.asset('assets/icons/vector1.png', height: 80),
            const SizedBox(height: 16),
            const Text(
              "You're all done!",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Hang tight! We are currently reviewing your account and will follow up with you in 2-3 business days. In the meantime, you can setup your inventory.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            CustomButton(
                buttonName: 'Got it!',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                })
          ],
        ),
      ),
    );
  }
}
