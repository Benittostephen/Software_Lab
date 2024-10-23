import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/home_page.dart';
import '../services/auth/ath_service.dart';

class LoginType extends StatelessWidget {
  const LoginType({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        type(
            assetImage: 'assets/icons/google.png',
            onTap: () async {
              final user = await AuthService().signInWithGoogle();
              if (user != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Welcome, ${user.displayName}'),
                ));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Google sign-in failed')));
              }
            }),
        type(
            icon: const Icon(Icons.apple, size: 35),
            onTap: () => AuthService().signInWithApple()),
        type(
            icon: const Icon(Icons.facebook, color: Colors.blue, size: 35),
            onTap: () async {
              User? user = await AuthService().signInWithFacebook();
              if (user != null) {
                // Successfully logged in
                print('Logged in as ${user.displayName}');
              } else {
                // Failed to log in
                print('Facebook login failed');
              }
            })
      ],
    );
  }
}

Widget type({String? assetImage, Icon? icon, VoidCallback? onTap}) {
  return InkWell(
    borderRadius: BorderRadius.circular(50),
    onTap: onTap,
    child: Ink(
      width: 90,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFeeedec)),
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
      child: assetImage != null
          ? Image.asset(assetImage, scale: 21)
          : icon != null
              ? Center(child: icon)
              : const SizedBox.shrink(),
    ),
  );
}
