// To parse this JSON data, do
//
//     final bodyShapeResponse = bodyShapeResponseFromJson(jsonString);

import 'dart:convert';

BodyShapeResponse bodyShapeResponseFromJson(String str) => BodyShapeResponse.fromJson(json.decode(str));

String bodyShapeResponseToJson(BodyShapeResponse data) => json.encode(data.toJson());

class BodyShapeResponse {
  BodyShapeResponse({
    this.data,
    this.success,
    this.errors,
  });

  Data data;
  bool success;
  dynamic errors;

  factory BodyShapeResponse.fromJson(Map<String, dynamic> json) => BodyShapeResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    success: json["success"] == null ? null : json["success"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data.toJson(),
    "success": success == null ? null : success,
    "errors": errors,
  };
}

class Data {
  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.birthDate,
    this.country,
    this.city,
    this.street,
    this.username,
    this.phoneNumber,
    this.shoulderSize,
    this.bustSize,
    this.hipSize,
    this.waistSize,
    this.shape,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  dynamic password;
  dynamic birthDate;
  String country;
  String city;
  String street;
  String username;
  dynamic phoneNumber;
  double shoulderSize;
  double bustSize;
  double hipSize;
  double waistSize;
  String shape;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"],
    birthDate: json["birthDate"],
    country: json["country"] == null ? null : json["country"],
    city: json["city"] == null ? null : json["city"],
    street: json["street"] == null ? null : json["street"],
    username: json["username"] == null ? null : json["username"],
    phoneNumber: json["phoneNumber"],
    shoulderSize: json["shoulderSize"] == null ? null : json["shoulderSize"].toDouble(),
    bustSize: json["bustSize"] == null ? null : json["bustSize"].toDouble(),
    hipSize: json["hipSize"] == null ? null : json["hipSize"].toDouble(),
    waistSize: json["waistSize"] == null ? null : json["waistSize"].toDouble(),
    shape: json["shape"] == null ? null : json["shape"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "email": email == null ? null : email,
    "password": password,
    "birthDate": birthDate,
    "country": country == null ? null : country,
    "city": city == null ? null : city,
    "street": street == null ? null : street,
    "username": username == null ? null : username,
    "phoneNumber": phoneNumber,
    "shoulderSize": shoulderSize == null ? null : shoulderSize,
    "bustSize": bustSize == null ? null : bustSize,
    "hipSize": hipSize == null ? null : hipSize,
    "waistSize": waistSize == null ? null : waistSize,
    "shape": shape == null ? null : shape,
  };
}
