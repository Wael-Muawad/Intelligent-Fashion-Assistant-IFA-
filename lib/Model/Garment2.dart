// To parse this JSON data, do
//
//     final garment2 = garment2FromJson(jsonString);

import 'dart:convert';

Garment2 garment2FromJson(String str) => Garment2.fromJson(json.decode(str));

String garment2ToJson(Garment2 data) => json.encode(data.toJson());

class Garment2 {
  Garment2({
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
    this.imagesFiles,
    this.images,
    this.properties,
    this.sizes,
    this.storeApiDto,
  });

  int id;
  String name;
  String description;
  String brand;
  int price;
  DateTime createdAt;
  int storeId;
  int categoryId;
  String category;
  List<String> colors;
  dynamic imagesFiles;
  dynamic images;
  dynamic properties;
  List<dynamic> sizes;
  dynamic storeApiDto;

  factory Garment2.fromJson(Map<String, dynamic> json) => Garment2(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    brand: json["brand"],
    price: json["price"],
    createdAt: DateTime.parse(json["createdAt"]),
    storeId: json["storeId"],
    categoryId: json["categoryId"],
    category: json["category"],
    colors: List<String>.from(json["colors"].map((x) => x)),
    imagesFiles: json["imagesFiles"],
    images: json["images"],
    properties: json["properties"],
    sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
    storeApiDto: json["storeApiDto"],
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
    "imagesFiles": imagesFiles,
    "images": images,
    "properties": properties,
    "sizes": List<dynamic>.from(sizes.map((x) => x)),
    "storeApiDto": storeApiDto,
  };
}
