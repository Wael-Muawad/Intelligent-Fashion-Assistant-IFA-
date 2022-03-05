// To parse this JSON data, do
//
//     final garment3 = garment3FromJson(jsonString);

import 'dart:convert';

Garment3 garment3FromJson(String str) => Garment3.fromJson(json.decode(str));

String garment3ToJson(Garment3 data) => json.encode(data.toJson());

class Garment3 {
  Garment3({
    this.data,
    this.success,
    this.errors,
  });

  List<Datum> data;
  bool success;
  dynamic errors;

  factory Garment3.fromJson(Map<String, dynamic> json) => Garment3(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    success: json["success"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
    "errors": errors,
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.description,
    this.brand,
    this.price,
    this.createdAt,
    this.storeId,
    this.categoryId,
    this.category,
    this.colors,
    this.images,
    this.properties,
    this.sizes,
    this.storeApiDto,
    this.colorsOfId,
    this.sizesOfId,
  });

  int id;
  String name;
  String description;
  String brand;
  double price;
  DateTime createdAt;
  int storeId;
  int categoryId;
  String category;
  List<String> colors;
  List<String> images;
  dynamic properties;
  List<String> sizes;
  StoreApiDto storeApiDto;
  dynamic colorsOfId;
  dynamic sizesOfId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    brand: json["brand"],
    price: json["price"].toDouble(),
    createdAt: DateTime.parse(json["createdAt"]),
    storeId: json["storeId"],
    categoryId: json["categoryId"],
    category: json["category"],
    colors: List<String>.from(json["colors"].map((x) => x)),
    images: List<String>.from(json["images"].map((x) => x)),
    properties: json["properties"],
    sizes: List<String>.from(json["sizes"].map((x) => x)),
    storeApiDto: StoreApiDto.fromJson(json["storeApiDto"]),
    colorsOfId: json["colorsOfId"],
    sizesOfId: json["sizesOfId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "brand": brand,
    "price": price,
    "createdAt": createdAt.toIso8601String(),
    "storeId": storeId,
    "categoryId": categoryId,
    "category": category,
    "colors": List<dynamic>.from(colors.map((x) => x)),
    "images": List<dynamic>.from(images.map((x) => x)),
    "properties": properties,
    "sizes": List<dynamic>.from(sizes.map((x) => x)),
    "storeApiDto": storeApiDto.toJson(),
    "colorsOfId": colorsOfId,
    "sizesOfId": sizesOfId,
  };
}

class StoreApiDto {
  StoreApiDto({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.birthDate,
    this.storeName,
    this.rank,
    this.username,
    this.locations,
    this.createdAt,
  });

  int id;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic password;
  dynamic birthDate;
  String storeName;
  int rank;
  dynamic username;
  List<Location> locations;
  DateTime createdAt;

  factory StoreApiDto.fromJson(Map<String, dynamic> json) => StoreApiDto(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    birthDate: json["birthDate"],
    storeName: json["storeName"],
    rank: json["rank"],
    username: json["username"],
    locations: List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "birthDate": birthDate,
    "storeName": storeName,
    "rank": rank,
    "username": username,
    "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
  };
}

class Location {
  Location({
    this.id,
    this.country,
    this.city,
    this.street,
    this.phoneNumber,
    this.storeId,
  });

  int id;
  String country;
  String city;
  String street;
  String phoneNumber;
  int storeId;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    country: json["country"],
    city: json["city"],
    street: json["street"],
    phoneNumber: json["phoneNumber"],
    storeId: json["storeId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country": country,
    "city": city,
    "street": street,
    "phoneNumber": phoneNumber,
    "storeId": storeId,
  };
}
