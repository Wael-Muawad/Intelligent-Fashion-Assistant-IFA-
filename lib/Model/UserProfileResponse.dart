// To parse this JSON data, do
//
//     final userProfileResponse = userProfileResponseFromJson(jsonString);

import 'dart:convert';

UserProfileResponse userProfileResponseFromJson(String str) => UserProfileResponse.fromJson(json.decode(str));

String userProfileResponseToJson(UserProfileResponse data) => json.encode(data.toJson());

class UserProfileResponse {
  UserProfileResponse({
    this.data,
    this.success,
    this.errors,
  });

  Data data;
  bool success;
  List<String> errors;

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) => UserProfileResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    success: json["success"] == null ? null : json["success"],
    errors: json["errors"] == null ? null : List<String>.from(json["errors"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data.toJson(),
    "success": success == null ? null : success,
    "errors": errors == null ? null : List<dynamic>.from(errors.map((x) => x)),
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
    this.shape,
    this.sizes,
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
  String shape;
  Sizes sizes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    shape: json["shape"] == null ? null : json["shape"],
    sizes: json["sizes"] == null ? null : Sizes.fromJson(json["sizes"]),
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
    "shape": shape == null ? null : shape,
    "sizes": sizes == null ? null : sizes.toJson(),
  };
}

class Sizes {
  Sizes({
    this.dress,
    this.top,
    this.jumpsuit,
    this.skirt,
    this.pants,
  });

  String dress;
  String top;
  String jumpsuit;
  String skirt;
  String pants;

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
    dress: json["Dress"] == null ? null : json["Dress"],
    top: json["Top"] == null ? null : json["Top"],
    jumpsuit: json["Jumpsuit"] == null ? null : json["Jumpsuit"],
    skirt: json["Skirt"] == null ? null : json["Skirt"],
    pants: json["Pants"] == null ? null : json["Pants"],
  );

  Map<String, dynamic> toJson() => {
    "Dress": dress == null ? null : dress,
    "Top": top == null ? null : top,
    "Jumpsuit": jumpsuit == null ? null : jumpsuit,
    "Skirt": skirt == null ? null : skirt,
    "Pants": pants == null ? null : pants,
  };
}
