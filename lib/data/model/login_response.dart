class LoginResponse {
  final String? message;
  final String? accessToken;
  final String? tokenType;
  final bool? success;

  LoginResponse({
    this.message,
    this.accessToken,
    this.tokenType,
    this.success,
  });

  // Factory constructor for creating an instance from JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      success: json['success'],
    );
  }

  // Method for converting an instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'access_token': accessToken,
      'token_type': tokenType,
      'success': success,
    };
  }
}
