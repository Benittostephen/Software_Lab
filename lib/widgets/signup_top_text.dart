import 'package:flutter/material.dart';

class SignupTopText extends StatelessWidget {
  final String headingText;
  final int pageNo;

  const SignupTopText(
      {super.key, required this.headingText, required this.pageNo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        Text(
          'Signup $pageNo of 4',
          style: const TextStyle(
              fontSize: 14,
              color: Color(0xFFb3b3b3),
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Text(
          headingText,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 30)
      ],
    );
  }
}
