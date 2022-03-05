// To parse this JSON data, do
//
//     final garment = garmentFromJson(jsonString);

import 'dart:convert';

Garment garmentFromJson(String str) => Garment.fromJson(json.decode(str));

String garmentToJson(Garment data) => json.encode(data.toJson());

class Garment {
    Garment({
        this.data,
        this.success,
        this.errors,
    });

    List<Datum> data;
    bool success;
    List<String> errors;

    factory Garment.fromJson(Map<String, dynamic> json) => Garment(
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        success: json["success"] == null ? null : json["success"],
        errors: json["errors"] == null ? null : List<String>.from(json["errors"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success == null ? null : success,
        "errors": errors == null ? null : List<dynamic>.from(errors.map((x) => x)),
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
