// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

import 'dart:convert';

ApiResponse apiResponseFromJson(String str) => ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  ApiResponse({
    this.success,
    this.errors,
  });

  bool success;
  List<String> errors;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    success: json["success"] == null ? null : json["success"],
    errors: json["errors"] == null ? null : List<String>.from(json["errors"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "errors": errors == null ? null : List<dynamic>.from(errors.map((x) => x)),
  };
}
