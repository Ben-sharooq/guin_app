import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));
String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({this.userId, this.roleId, this.accessToken, this.boatCount});

  int? userId;
  int? roleId;
  String? accessToken;
  int? boatCount;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        userId: json["user_id"],
        roleId: json["role_uid"],
        accessToken: json["access_token"],
        boatCount: json["boat_count"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "role_uid": roleId,
        "access_token": accessToken,
        "boat_count": boatCount,
      };
}

class PasswordUpdateResponse {
  String data;

  PasswordUpdateResponse({required this.data});

  factory PasswordUpdateResponse.fromJson(Map<String, dynamic> json) {
    return PasswordUpdateResponse(
      data: json['data'] ?? '',
    );
  }
}
