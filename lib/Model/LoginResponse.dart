// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.data,
    this.success,
    this.errors,
  });

  String data;
  bool success;
  List<String> errors;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    data: json["data"] == null ? null : json["data"],
    success: json["success"] == null ? null : json["success"],
    errors: json["errors"] == null ? null : List<String>.from(json["errors"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data,
    "success": success == null ? null : success,
    "errors": errors == null ? null : List<dynamic>.from(errors.map((x) => x)),
  };
}
