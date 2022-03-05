// To parse this JSON data, do
//
//     final rateStoreRequest = rateStoreRequestFromJson(jsonString);

import 'dart:convert';

RateStoreRequest rateStoreRequestFromJson(String str) => RateStoreRequest.fromJson(json.decode(str));

String rateStoreRequestToJson(RateStoreRequest data) => json.encode(data.toJson());

class RateStoreRequest {
  RateStoreRequest({
    this.id = 0,
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

  factory RateStoreRequest.fromJson(Map<String, dynamic> json) => RateStoreRequest(
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
