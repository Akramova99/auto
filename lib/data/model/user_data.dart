class UserData {
  final int id;
  final int roleId;
  final String name;
  final String phoneNumber;
  final String? finishTime;
  final String? phoneNumberVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String profilePhotoUrl;

  UserData({
    required this.id,
    required this.roleId,
    required this.name,
    required this.phoneNumber,
    this.finishTime,
    this.phoneNumberVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.profilePhotoUrl,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["id"],
      roleId: json["role_id"],
      name: json["name"],
      phoneNumber: json["phone_number"],
      finishTime: json["finish_time"],
      phoneNumberVerifiedAt: json["phone_number_verified_at"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      profilePhotoUrl: json["profile_photo_url"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "role_id": roleId,
      "name": name,
      "phone_number": phoneNumber,
      "finish_time": finishTime,
      "phone_number_verified_at": phoneNumberVerifiedAt,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "profile_photo_url": profilePhotoUrl,
    };
  }
}
