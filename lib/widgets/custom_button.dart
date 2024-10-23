import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String buttonName;
  final onTap;

  const CustomButton({super.key, required this.buttonName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD5715B),
          padding: const EdgeInsets.symmetric(vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        child: Text(
          buttonName,
          style: const TextStyle(
              fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
