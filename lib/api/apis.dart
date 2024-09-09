import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/model_class.dart';

const String baseUrl = 'https://sowlab.com/assignment';

class ApiService {
  final String registerUrl = '$baseUrl/user/register';
  final String loginUrl = '$baseUrl/user/login';
  final String forgotPasswordUrl = '$baseUrl/user/forgot-password';
  final String verifyOtpUrl = '$baseUrl/user/verify-otp';
  final String resetPasswordUrl = '$baseUrl/user/reset-password';

  ///Registration Response
  Future<RegistrationResponse> registerUser(Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(registerUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return RegistrationResponse.fromJson(data);
    } else {
      return RegistrationResponse(
        success: false,
        message: 'Server error, please try again later.',
      );
    }
  }

  ///Login Response
  Future<LoginResponse> loginUser({
    required String email,
    required String password,
    required String role,
    required String deviceToken,
    required String type,
    required String socialId,
  }) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
        "role": role,
        "device_token": deviceToken,
        "type": type,
        "social_id": socialId,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('looooooooogin$data');
      return LoginResponse.fromJson(data);
    } else {
      // If server returns an error, return a failed response
      print('noooooooooooooooooooooooo');
      return LoginResponse(
        success: false,
        message: 'Server error, please try again later.',
      );
    }
  }

  ///Forgot Password Response
  Future<ForgotPasswordResponse> sendOtp(String mobileNumber) async {
    final response = await http.post(
      Uri.parse(forgotPasswordUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "mobile": '+91$mobileNumber',
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ForgotPasswordResponse.fromJson(data);
    } else {
      return ForgotPasswordResponse(
        success: false,
        message: 'Server error, please try again later.',
      );
    }
  }

  ///Otp Verification Response
  Future<OtpVerificationResponse> verifyOtp(String otp) async {
    final response = await http.post(
      Uri.parse(verifyOtpUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "otp": otp,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return OtpVerificationResponse.fromJson(data);
    } else {
      return OtpVerificationResponse(
        success: false,
        message: 'Server error, please try again later.',
      );
    }
  }

  ///Reset Password Response
  Future<ResetPasswordResponse> resetPassword(
      String token, String password, String cpassword) async {
    final response = await http.post(
      Uri.parse(resetPasswordUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "token": token,
        "password": password,
        "cpassword": cpassword,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ResetPasswordResponse.fromJson(data);
    } else {
      return ResetPasswordResponse(
        success: false,
        message: 'Server error, please try again later.',
      );
    }
  }
}
