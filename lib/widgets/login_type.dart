import 'package:flutter/material.dart';

class LoginType extends StatelessWidget {
  const LoginType({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        type('assets/icons/google.png', null),
        type(null, const Icon(Icons.apple, size: 35)),
        type(null, const Icon(Icons.facebook, color: Colors.blue, size: 35)),
      ],
    );
  }
}

Widget type(assetImage, icon) {
  return (icon == null)
      ? Container(
          width: 90,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFeeedec)),
              borderRadius: BorderRadius.circular(50),
              color: Colors.white),
          child: Image.asset(assetImage, scale: 21))
      : Container(
          width: 90,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFeeedec)),
              borderRadius: BorderRadius.circular(50),
              color: Colors.white),
          child: icon);
}
