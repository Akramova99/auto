class LoginModel {
  String? phoneNumber;
  String? password;

  LoginModel({
    this.phoneNumber,
    this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    phoneNumber: json["phone_number"],
    password: json["password"],
  );

  Map<String, String> toJson() => {
    "phone_number": phoneNumber!,
    "password": password!,
  };
}
class RegisterModel {
  String? name;
  String? phoneNumber;
  String? password;

  RegisterModel({
    this.name,
    this.phoneNumber,
    this.password,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    name: json["name"],
    phoneNumber: json["phone_number"],
    password: json["password"],
  );

  Map<String, String> toJson() => {
    "name": name!,
    "phone_number": phoneNumber!,
    "password": password!,
  };
}
