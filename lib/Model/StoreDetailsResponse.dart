// To parse this JSON data, do
//
//     final storeDetailsResponse = storeDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:testo/Model/Garment.dart';

StoreDetailsResponse storeDetailsResponseFromJson(String str) => StoreDetailsResponse.fromJson(json.decode(str));

String storeDetailsResponseToJson(StoreDetailsResponse data) => json.encode(data.toJson());

class StoreDetailsResponse {
  StoreDetailsResponse({
    this.data,
    this.success,
    this.errors,
  });

  Data data;
  bool success;
  List<String> errors;

  factory StoreDetailsResponse.fromJson(Map<String, dynamic> json) => StoreDetailsResponse(
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
    this.storeName,
    this.stroePhoto,
    this.rank,
    this.username,
    this.locations,
    this.storeFeedbacks,
    this.garments,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String storeName;
  String stroePhoto;
  int rank;
  String username;
  List<Location> locations;
  List<StoreFeedback> storeFeedbacks;
  List<Datum> garments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    email: json["email"] == null ? null : json["email"],
    storeName: json["storeName"] == null ? null : json["storeName"],
    stroePhoto: json["stroePhoto"] == null ? null : json["stroePhoto"],
    rank: json["rank"] == null ? null : json["rank"],
    username: json["username"] == null ? null : json["username"],
    locations: json["locations"] == null ? null : List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
    storeFeedbacks: json["storeFeedbacks"] == null ? null : List<StoreFeedback>.from(json["storeFeedbacks"].map((x) => StoreFeedback.fromJson(x))),
    garments: json["garments"] == null ? null : List<Datum>.from(json["garments"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "email": email == null ? null : email,
    "storeName": storeName == null ? null : storeName,
    "stroePhoto": stroePhoto == null ? null : stroePhoto,
    "rank": rank == null ? null : rank,
    "username": username == null ? null : username,
    "locations": locations == null ? null : List<dynamic>.from(locations.map((x) => x.toJson())),
    "storeFeedbacks": storeFeedbacks == null ? null : List<dynamic>.from(storeFeedbacks.map((x) => x.toJson())),
    "garments": garments == null ? null : List<dynamic>.from(garments.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.description,
    this.brand,
    this.price,
    this.category,
    this.colors,
    this.images,
    this.sizes,
    this.isLike,
  });

  int id;
  String name;
  String description;
  String brand;
  double price;
  String category;
  List<String> colors;
  List<String> images;
  List<String> sizes;
  bool isLike;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    brand: json["brand"] == null ? null : json["brand"],
    price: json["price"] == null ? null : json["price"].toDouble(),
    category: json["category"] == null ? null : json["category"],
    colors: json["colors"] == null ? null : List<String>.from(json["colors"].map((x) => x)),
    images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
    sizes: json["sizes"] == null ? null : List<String>.from(json["sizes"].map((x) => x)),
    isLike: json["isLike"] == null ? null : json["isLike"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "brand": brand == null ? null : brand,
    "price": price == null ? null : price,
    "category": category == null ? null : category,
    "colors": colors == null ? null : List<dynamic>.from(colors.map((x) => x)),
    "images": images == null ? null : List<dynamic>.from(images.map((x) => x)),
    "sizes": sizes == null ? null : List<dynamic>.from(sizes.map((x) => x)),
    "isLike": isLike == null ? null : isLike,
  };
}
/*class Garment {
  Garment({
    this.id,
    this.name,
    this.brand,
    this.price,
    this.images,
    this.isLike,
  });

  int id;
  String name;
  String brand;
  int price;
  List<String> images;
  bool isLike;

  factory Garment.fromJson(Map<String, dynamic> json) => Garment(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    brand: json["brand"] == null ? null : json["brand"],
    price: json["price"] == null ? null : json["price"],
    images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
    isLike: json["isLike"] == null ? null : json["isLike"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "brand": brand == null ? null : brand,
    "price": price == null ? null : price,
    "images": images == null ? null : List<dynamic>.from(images.map((x) => x)),
    "isLike": isLike == null ? null : isLike,
  };
}*/

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
    id: json["id"] == null ? null : json["id"],
    country: json["country"] == null ? null : json["country"],
    city: json["city"] == null ? null : json["city"],
    street: json["street"] == null ? null : json["street"],
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
    storeId: json["storeId"] == null ? null : json["storeId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "country": country == null ? null : country,
    "city": city == null ? null : city,
    "street": street == null ? null : street,
    "phoneNumber": phoneNumber == null ? null : phoneNumber,
    "storeId": storeId == null ? null : storeId,
  };
}

class StoreFeedback {
  StoreFeedback({
    this.id,
    this.header,
    this.body,
    this.rate,
    this.storeId,
    this.userName,
    this.userImage,
  });

  int id;
  String header;
  String body;
  int rate;
  int storeId;
  String userName;
  String userImage;

  factory StoreFeedback.fromJson(Map<String, dynamic> json) => StoreFeedback(
    id: json["id"] == null ? null : json["id"],
    header: json["header"] == null ? null : json["header"],
    body: json["body"] == null ? null : json["body"],
    rate: json["rate"] == null ? null : json["rate"],
    storeId: json["storeId"] == null ? null : json["storeId"],
    userName: json["userName"] == null ? null : json["userName"],
    userImage: json["userImage"] == null ? null : json["userImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "header": header == null ? null : header,
    "body": body == null ? null : body,
    "rate": rate == null ? null : rate,
    "storeId": storeId == null ? null : storeId,
    "userName": userName == null ? null : userName,
    "userImage": userImage == null ? null : userImage,
  };
}
