///Registration Response
class RegistrationResponse {
  final bool success;
  final String message;
  final String? token;

  RegistrationResponse({
    required this.success,
    required this.message,
    this.token,
  });

  // Factory constructor to create an instance from a JSON map
  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      success: json['success'],
      message: json['message'],
      token: json['token'],
    );
  }
}

///Login Response Model
class LoginResponse {
  final bool success;
  final String message;
  final String? token;

  LoginResponse({
    required this.success,
    required this.message,
    this.token,
  });

  // Factory constructor to create an instance from a JSON map
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      message: json['message'],
      token: json['token'], // This will be null if token is not present
    );
  }
}

///Forgot Password Response

class ForgotPasswordResponse {
  final bool success;
  final String message;

  ForgotPasswordResponse({
    required this.success,
    required this.message,
  });

  // Factory constructor to create an instance from JSON
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      success: json['success'],
      message: json['message'],
    );
  }
}

///OTP Verification Response

class OtpVerificationResponse {
  final bool success;
  final String message;
  final String? token;

  OtpVerificationResponse({
    required this.success,
    required this.message,
    this.token,
  });

  // Factory constructor to create an instance from a JSON map
  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerificationResponse(
      success: json['success'],
      message: json['message'],
      token: json['token'], // The token might be null
    );
  }
}

///Reset Password Response

class ResetPasswordResponse {
  final bool success;
  final String message;
  final bool? isVerified;

  ResetPasswordResponse({
    required this.success,
    required this.message,
    this.isVerified,
  });

  // Factory constructor to create an instance from a JSON map
  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      success: json['success'],
      message: json['message'],
      isVerified: json['is_verified'],
    );
  }
}
