import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  //Google Sign in
  Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    }
    return null;
  }

  // Google Sign-Out
  Future<void> signOutFromGoogle() async {
    await GoogleSignIn().signOut(); // Sign out from Google
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase
  }

  // Apple Sign-In for iOS and Android
  Future<User?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          // Required for Android
          redirectUri: Uri.parse(
              'https://your-service.com/callbacks/sign_in_with_apple'),
          clientId: 'com.example.your.client.id',
        ),
      );

      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in to Firebase with the credential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } catch (error) {
      print('Error during Apple Sign-In: $error');
      return null;
    }
  }

  // Facebook Sign-In
  Future<User?> signInWithFacebook() async {
    try {
      // Trigger the Facebook sign-in flow
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // If the sign-in is successful, create a credential for Firebase
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);

        // Sign in to Firebase with the Facebook credential
        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);

        return userCredential.user;
      } else {
        print('Facebook Sign-In failed: ${result.message}');
        return null;
      }
    } catch (error) {
      print('Error during Facebook Sign-In: $error');
      return null;
    }
  }

  // Sign out from all authentication providers
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase
    await GoogleSignIn().signOut(); // Sign out from Google
    await FacebookAuth.instance.logOut(); // Sign out from Facebook
  }
}
