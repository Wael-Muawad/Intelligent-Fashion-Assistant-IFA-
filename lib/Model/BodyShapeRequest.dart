// To parse this JSON data, do
//
//     final bodyShapeRequest = bodyShapeRequestFromJson(jsonString);

import 'dart:convert';

BodyShapeRequest bodyShapeRequestFromJson(String str) => BodyShapeRequest.fromJson(json.decode(str));

String bodyShapeRequestToJson(BodyShapeRequest data) => json.encode(data.toJson());

class BodyShapeRequest {
  BodyShapeRequest({
    this.id = 0,
    this.shoulderSize,
    this.bustSize,
    this.hipSize,
    this.waistSize,
  });

  int id;
  double shoulderSize;
  double bustSize;
  double hipSize;
  double waistSize;

  factory BodyShapeRequest.fromJson(Map<String, dynamic> json) => BodyShapeRequest(
    id: json["id"] == null ? null : json["id"],
    shoulderSize: json["shoulderSize"] == null ? null : json["shoulderSize"].toDouble(),
    bustSize: json["bustSize"] == null ? null : json["bustSize"].toDouble(),
    hipSize: json["hipSize"] == null ? null : json["hipSize"].toDouble(),
    waistSize: json["waistSize"] == null ? null : json["waistSize"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "shoulderSize": shoulderSize == null ? null : shoulderSize,
    "bustSize": bustSize == null ? null : bustSize,
    "hipSize": hipSize == null ? null : hipSize,
    "waistSize": waistSize == null ? null : waistSize,
  };
}
