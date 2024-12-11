class RegistrationResponse {
  final User? user;
  final String? message;
  final String? accessToken;
  final String? tokenType;
  final bool? success;

  RegistrationResponse({
    this.user,
    this.message,
    this.accessToken,
    this.tokenType,
    this.success,
  });

  // Factory constructor to create an instance from JSON
  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      message: json['message'],
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      success: json['success'],
    );
  }

  // Method to convert an instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'message': message,
      'access_token': accessToken,
      'token_type': tokenType,
      'success': success,
    };
  }
}

class User {
  final int? roleId;
  final String? name;
  final String? phoneNumber;
  final String? updatedAt;
  final String? createdAt;
  final int? id;
  final String? profilePhotoUrl;

  User({
    this.roleId,
    this.name,
    this.phoneNumber,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.profilePhotoUrl,
  });

  // Factory constructor to create an instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      roleId: json['role_id'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
      profilePhotoUrl: json['profile_photo_url'],
    );
  }

  // Method to convert an instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'role_id': roleId,
      'name': name,
      'phone_number': phoneNumber,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
      'profile_photo_url': profilePhotoUrl,
    };
  }
}
