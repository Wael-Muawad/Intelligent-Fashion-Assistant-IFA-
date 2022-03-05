// To parse this JSON data, do
//
//     final feedbacksResponse = feedbacksResponseFromJson(jsonString);

import 'dart:convert';

FeedbacksResponse feedbacksResponseFromJson(String str) => FeedbacksResponse.fromJson(json.decode(str));

String feedbacksResponseToJson(FeedbacksResponse data) => json.encode(data.toJson());

class FeedbacksResponse {
  FeedbacksResponse({
    this.data,
    this.success,
    this.errors,
  });

  List<Datum> data;
  bool success;
  List<String> errors;

  factory FeedbacksResponse.fromJson(Map<String, dynamic> json) => FeedbacksResponse(
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
    this.header,
    this.body,
    this.rate,
    this.storeId,
    this.userName,
    this.userImage,
  });

  int id;
  dynamic header;
  String body;
  int rate;
  int storeId;
  String userName;
  String userImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    header: json["header"],
    body: json["body"] == null ? null : json["body"],
    rate: json["rate"] == null ? null : json["rate"],
    storeId: json["storeId"] == null ? null : json["storeId"],
    userName: json["userName"] == null ? null : json["userName"],
    userImage: json["userImage"] == null ? null : json["userImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "header": header,
    "body": body == null ? null : body,
    "rate": rate == null ? null : rate,
    "storeId": storeId == null ? null : storeId,
    "userName": userName == null ? null : userName,
    "userImage": userImage == null ? null : userImage,
  };
}
