// To parse this JSON data, do
//
//     final userProfileRequest = userProfileRequestFromJson(jsonString);

import 'dart:convert';

UserProfileRequest userProfileRequestFromJson(String str) => UserProfileRequest.fromJson(json.decode(str));

String userProfileRequestToJson(UserProfileRequest data) => json.encode(data.toJson());

class UserProfileRequest {
  UserProfileRequest({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password = 'anything',
    this.birthDate,
    this.photo,
    this.country,
    this.city,
    this.street,
    this.username,
    this.phoneNumber,
    this.shoulderSize,
    this.bustSize,
    this.hipSize,
    this.waistSize,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String password;
  DateTime birthDate;
  String photo;
  String country;
  String city;
  String street;
  String username;
  String phoneNumber;
  double shoulderSize;
  double bustSize;
  double hipSize;
  double waistSize;

  factory UserProfileRequest.fromJson(Map<String, dynamic> json) => UserProfileRequest(
    id: json["id"] == null ? null : json["id"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    birthDate: json["birthDate"] == null ? null : DateTime.parse(json["birthDate"]),
    photo: json["photo"] == null ? null : json["photo"],
    country: json["country"] == null ? null : json["country"],
    city: json["city"] == null ? null : json["city"],
    street: json["street"] == null ? null : json["street"],
    username: json["username"] == null ? null : json["username"],
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
    shoulderSize: json["shoulderSize"] == null ? null : json["shoulderSize"].toDouble(),
    bustSize: json["bustSize"] == null ? null : json["bustSize"].toDouble(),
    hipSize: json["hipSize"] == null ? null : json["hipSize"].toDouble(),
    waistSize: json["waistSize"] == null ? null : json["waistSize"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "birthDate": birthDate == null ? null : birthDate.toIso8601String(),
    "photo": photo == null ? null : photo,
    "country": country == null ? null : country,
    "city": city == null ? null : city,
    "street": street == null ? null : street,
    "username": username == null ? null : username,
    "phoneNumber": phoneNumber == null ? null : phoneNumber,
    "shoulderSize": shoulderSize == null ? null : shoulderSize,
    "bustSize": bustSize == null ? null : bustSize,
    "hipSize": hipSize == null ? null : hipSize,
    "waistSize": waistSize == null ? null : waistSize,
  };
}
