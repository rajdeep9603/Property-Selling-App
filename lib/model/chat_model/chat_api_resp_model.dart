// To parse this JSON data, do
//
//     final chatApiResponseModel = chatApiResponseModelFromJson(jsonString);

import 'dart:convert';

ChatApiResponseModel chatApiResponseModelFromJson(String str) => ChatApiResponseModel.fromJson(json.decode(str));

String chatApiResponseModelToJson(ChatApiResponseModel data) => json.encode(data.toJson());

class ChatApiResponseModel {
  ChatApiResponseModel({
    this.status,
    this.errorCode,
    this.errorMsg,
    this.data,
  });

  String? status;
  String? errorCode;
  String? errorMsg;
  Data? data;

  factory ChatApiResponseModel.fromJson(Map<String, dynamic> json) => ChatApiResponseModel(
    status: json["status"],
    errorCode: json["errorCode"],
    errorMsg: json["errorMsg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "errorMsg": errorMsg,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.buddy,
  });

  Buddy? buddy;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    buddy: Buddy.fromJson(json["buddy"]),
  );

  Map<String, dynamic> toJson() => {
    "buddy": buddy!.toJson(),
  };
}

class Buddy {
  Buddy({
    this.name,
    this.number,
    this.uid,
    this.memberType,
  });

  String? name;
  String? number;
  String? uid;
  String? memberType;

  factory Buddy.fromJson(Map<String, dynamic> json) => Buddy(
    name: json["name"],
    number: json["number"],
    uid: json["uid"],
    memberType: json["memberType"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "number": number,
    "uid": uid,
    "memberType": memberType,
  };
}
