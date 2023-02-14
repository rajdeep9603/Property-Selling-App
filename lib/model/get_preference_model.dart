// To parse this JSON data, do
//
//     final getPreferenceModel = getPreferenceModelFromJson(jsonString);

import 'dart:convert';

GetPreferenceModel getPreferenceModelFromJson(String str) =>
    GetPreferenceModel.fromJson(json.decode(str));

String getPreferenceModelToJson(GetPreferenceModel data) =>
    json.encode(data.toJson());

class GetPreferenceModel {
  GetPreferenceModel({
    this.status,
    this.errorCode,
    this.errorMsg,
    this.data,
  });

  String? status;
  String? errorCode;
  String? errorMsg;
  Data? data;

  factory GetPreferenceModel.fromJson(Map<String, dynamic> json) =>
      GetPreferenceModel(
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
    this.statement,
    this.occupation,
    this.bedrooms,
    this.intent,
    this.type,
    this.category,
    this.lookingTo,
    this.lookingFor,
    this.min,
    this.max,
    this.jump,
    this.furnishType,
  });

  Id? id;
  String? objectType;
  String? statement;
  List<String>? occupation;
  List<String>? bedrooms;
  List<String>? intent;
  List<String>? type;
  List<String>? category;
  List<String>? lookingTo;
  List<String>? lookingFor;
  Jump? min;
  Jump? max;
  Jump? jump;
  List<String>? furnishType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"] == null ? null : Id.fromJson(json["_id"]),
        objectType: json["objectType"] == null ? null : json["objectType"],
        statement: json["statement"] == null ? null : json["statement"],
        occupation: json["occupation"] == null
            ? null
            : List<String>.from(json["occupation"].map((x) => x)),
        bedrooms: json["bedrooms"] == null
            ? null
            : List<String>.from(json["bedrooms"].map((x) => x)),
        intent: json["intent"] == null
            ? null
            : List<String>.from(json["intent"].map((x) => x)),
        type: json["type"] == null
            ? null
            : List<String>.from(json["type"].map((x) => x)),
        category: json["category"] == null
            ? null
            : List<String>.from(json["category"].map((x) => x)),
        lookingTo: json["lookingTo"] == null
            ? null
            : List<String>.from(json["lookingTo"].map((x) => x)),
        lookingFor: json["lookingFor"] == null
            ? null
            : List<String>.from(json["lookingFor"].map((x) => x)),
        min: json["min"] == null ? null : Jump.fromJson(json["min"]),
        max: json["max"] == null ? null : Jump.fromJson(json["max"]),
        jump: json["jump"] == null ? null : Jump.fromJson(json["jump"]),
        furnishType: json["furnishType"] == null
            ? null
            : List<String>.from(json["furnishType"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id!.toJson(),
        "objectType": objectType == null ? null : objectType,
        "statement": statement == null ? null : statement,
        "occupation": occupation == null
            ? null
            : List<dynamic>.from(occupation!.map((x) => x)),
        "bedrooms": bedrooms == null
            ? null
            : List<dynamic>.from(bedrooms!.map((x) => x)),
        "intent":
            intent == null ? null : List<dynamic>.from(intent!.map((x) => x)),
        "type": type == null ? null : List<dynamic>.from(type!.map((x) => x)),
        "category": category == null
            ? null
            : List<dynamic>.from(category!.map((x) => x)),
        "lookingTo": lookingTo == null
            ? null
            : List<dynamic>.from(lookingTo!.map((x) => x)),
        "lookingFor": lookingFor == null
            ? null
            : List<dynamic>.from(lookingFor!.map((x) => x)),
        "min": min == null ? null : min!.toJson(),
        "max": max == null ? null : max!.toJson(),
        "jump": jump == null ? null : jump!.toJson(),
        "furnishType": furnishType == null
            ? null
            : List<dynamic>.from(furnishType!.map((x) => x)),
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

class Jump {
  Jump({
    this.numberDouble,
  });

  String? numberDouble;

  factory Jump.fromJson(Map<String, dynamic> json) => Jump(
        numberDouble: json["\u0024numberDouble"] == null
            ? null
            : json["\u0024numberDouble"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024numberDouble": numberDouble == null ? null : numberDouble,
      };
}
