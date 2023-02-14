// To parse this JSON data, do
//
//     final getBgImageModel = getBgImageModelFromJson(jsonString);

import 'dart:convert';

GetBgImageModel getBgImageModelFromJson(String str) =>
    GetBgImageModel.fromJson(json.decode(str));

String getBgImageModelToJson(GetBgImageModel data) =>
    json.encode(data.toJson());

class GetBgImageModel {
  GetBgImageModel({
    this.status,
    this.errorCode,
    this.errorMsg,
    this.data,
  });

  String? status;
  String? errorCode;
  String? errorMsg;
  Data? data;

  factory GetBgImageModel.fromJson(Map<String, dynamic> json) =>
      GetBgImageModel(
        status: json["status"] == null ? null : json["status"],
        errorCode: json["errorCode"] == null ? null : json["errorCode"],
        errorMsg: json["errorMsg"] == null ? null : json["errorMsg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "errorCode": errorCode == null ? null : errorCode,
        "errorMsg": errorMsg == null ? null : errorMsg,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.objectType,
    this.images,
    this.videos,
  });

  Id? id;
  String? objectType;
  List<String>? images;
  List<String>? videos;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"] == null ? null : Id.fromJson(json["_id"]),
        objectType: json["objectType"] == null ? null : json["objectType"],
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        videos: json["videos"] == null
            ? null
            : List<String>.from(json["videos"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id!.toJson(),
        "objectType": objectType == null ? null : objectType,
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "videos":
            videos == null ? null : List<dynamic>.from(videos!.map((x) => x)),
      };
}

class Id {
  Id({
    this.oid,
  });

  String? oid;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        oid: json["\u0024oid"] == null ? null : json["\u0024oid"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024oid": oid == null ? null : oid,
      };
}
