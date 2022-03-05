// To parse this JSON data, do
//
//     final addPhotoResponse = addPhotoResponseFromJson(jsonString);

import 'dart:convert';

AddPhotoResponse addPhotoResponseFromJson(String str) => AddPhotoResponse.fromJson(json.decode(str));

String addPhotoResponseToJson(AddPhotoResponse data) => json.encode(data.toJson());

class AddPhotoResponse {
  AddPhotoResponse({
    this.data,
    this.success,
    this.errors,
  });

  String data;
  bool success;
  List<String> errors;

  factory AddPhotoResponse.fromJson(Map<String, dynamic> json) => AddPhotoResponse(
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
