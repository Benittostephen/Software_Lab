import 'package:flutter/material.dart';

import '../screens/auth/login_screen.dart';

class BodyText extends StatelessWidget {
  final String headingText;

  const BodyText({super.key, required this.headingText});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 50),
      Text(
        headingText,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          const Text('Remember your password? ',
              style: TextStyle(color: Color(0xFFa7a6a5), fontSize: 13)),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Text('Login',
                style: TextStyle(color: Color(0xFFD5715B), fontSize: 13)),
          )
        ],
      ),
      const SizedBox(height: 70),
    ]);
  }
}
