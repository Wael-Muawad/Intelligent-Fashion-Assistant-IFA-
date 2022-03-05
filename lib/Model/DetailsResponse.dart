// To parse this JSON data, do
//
//     final detailsResponse = detailsResponseFromJson(jsonString);

import 'dart:convert';

DetailsResponse detailsResponseFromJson(String str) => DetailsResponse.fromJson(json.decode(str));

String detailsResponseToJson(DetailsResponse data) => json.encode(data.toJson());

class DetailsResponse {
  DetailsResponse({
    this.data,
    this.success,
    this.errors,
  });

  Data data;
  bool success;
  List<String> errors;

  factory DetailsResponse.fromJson(Map<String, dynamic> json) => DetailsResponse(
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
    this.name,
    this.description,
    this.brand,
    this.price,
    this.storeId,
    this.categoryId,
    this.category,
    this.colors,
    this.images,
    this.storeApiDto,
    this.isLike,
  });

  int id;
  String name;
  String description;
  String brand;
  double price;
  int storeId;
  int categoryId;
  String category;
  List<String> colors;
  List<String> images;
  StoreApiDto storeApiDto;
  bool isLike;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    brand: json["brand"] == null ? null : json["brand"],
    price: json["price"] == null ? null : json["price"].toDouble(),
    storeId: json["storeId"] == null ? null : json["storeId"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    category: json["category"] == null ? null : json["category"],
    colors: json["colors"] == null ? null : List<String>.from(json["colors"].map((x) => x)),
    images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
    storeApiDto: json["storeApiDto"] == null ? null : StoreApiDto.fromJson(json["storeApiDto"]),
    isLike: json["isLike"] == null ? null : json["isLike"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "brand": brand == null ? null : brand,
    "price": price == null ? null : price,
    "storeId": storeId == null ? null : storeId,
    "categoryId": categoryId == null ? null : categoryId,
    "category": category == null ? null : category,
    "colors": colors == null ? null : List<dynamic>.from(colors.map((x) => x)),
    "images": images == null ? null : List<dynamic>.from(images.map((x) => x)),
    "storeApiDto": storeApiDto == null ? null : storeApiDto.toJson(),
    "isLike": isLike == null ? null : isLike,
  };
}

class StoreApiDto {
  StoreApiDto({
    this.id,
    this.storeName,
    this.stroePhoto,
    this.rank,
    this.username,
    this.locations,
  });

  int id;
  String storeName;
  String stroePhoto;
  int rank;
  String username;
  List<Location> locations;

  factory StoreApiDto.fromJson(Map<String, dynamic> json) => StoreApiDto(
    id: json["id"] == null ? null : json["id"],
    storeName: json["storeName"] == null ? null : json["storeName"],
    stroePhoto: json["stroePhoto"] == null ? null : json["stroePhoto"],
    rank: json["rank"] == null ? null : json["rank"],
    username: json["username"] == null ? null : json["username"],
    locations: json["locations"] == null ? null : List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "storeName": storeName == null ? null : storeName,
    "stroePhoto": stroePhoto == null ? null : stroePhoto,
    "rank": rank == null ? null : rank,
    "username": username == null ? null : username,
    "locations": locations == null ? null : List<dynamic>.from(locations.map((x) => x.toJson())),
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
