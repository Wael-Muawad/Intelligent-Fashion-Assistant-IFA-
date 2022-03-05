// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id = 0,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.birthDate,
    this.country,
    this.city,
    this.street,
    this.houseNumber,
    this.username,
    this.phoneNumber,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  dynamic password;
  DateTime birthDate;
  String country;
  String city;
  String street;
  String houseNumber;
  String username;
  String phoneNumber;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    birthDate: DateTime.parse(json["birthDate"]),
    country: json["country"],
    city: json["city"],
    street: json["street"],
    houseNumber: json["houseNumber"],
    username: json["username"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "birthDate": birthDate.toIso8601String(),
    "country": country,
    "city": city,
    "street": street,
    "houseNumber": houseNumber,
    "username": username,
    "phoneNumber": phoneNumber,
  };
}
