// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.status,
    this.errorCode,
    this.errorMsg,
    this.data,
  });

  String? status;
  String? errorCode;
  String? errorMsg;
  Data? data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
    this.from,
    this.memberId,
    this.customerId,
    this.preferences,
  });

  String? from;
  CustomerId? memberId;
  CustomerId? customerId;
  List<Preference>? preferences;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        from: json["from"] == null ? null : json["from"],
        memberId: json["memberId"] == null
            ? null
            : CustomerId.fromJson(json["memberId"]),
        customerId: json["customerId"] == null
            ? null
            : CustomerId.fromJson(json["customerId"]),
        preferences: json["preferences"] == null
            ? null
            : List<Preference>.from(
                json["preferences"].map((x) => Preference.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "from": from == null ? null : from,
        "memberId": memberId == null ? null : memberId!.toJson(),
        "customerId": customerId == null ? null : customerId!.toJson(),
        "preferences": preferences == null
            ? null
            : List<dynamic>.from(preferences!.map((x) => x.toJson())),
      };
}

class CustomerId {
  CustomerId({
    this.oid,
  });

  String? oid;

  factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
        oid: json["\u0024oid"] == null ? null : json["\u0024oid"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024oid": oid == null ? null : oid,
      };
}

class Preference {
  Preference({
    this.subCity,
    this.bedrooms,
    this.category,
    this.furnishType,
    this.id,
    this.propType,
    this.minPrice,
    this.maxPrice,
    this.constructionType,
    this.occupation,
  });

  List<String>? subCity;
  List<String>? bedrooms;
  List<String>? category;
  List<String>? furnishType;
  CustomerId? id;
  String? propType;
  String? minPrice;
  String? maxPrice;
  String? constructionType;
  String? occupation;

  factory Preference.fromJson(Map<String, dynamic> json) => Preference(
        subCity: json["subCity"] == null
            ? null
            : List<String>.from(json["subCity"].map((x) => x)),
        bedrooms: json["bedrooms"] == null
            ? null
            : List<String>.from(json["bedrooms"].map((x) => x)),
        category: json["category"] == null
            ? null
            : List<String>.from(json["category"].map((x) => x)),
        furnishType: json["furnishType"] == null
            ? null
            : List<String>.from(json["furnishType"].map((x) => x)),
        id: json["_id"] == null ? null : CustomerId.fromJson(json["_id"]),
        propType: json["propType"] == null ? null : json["propType"],
        minPrice: json["minPrice"] == null ? null : json["minPrice"],
        maxPrice: json["maxPrice"] == null ? null : json["maxPrice"],
        constructionType:
            json["constructionType"] == null ? null : json["constructionType"],
        occupation: json["occupation"] == null ? null : json["occupation"],
      );

  Map<String, dynamic> toJson() => {
        "subCity":
            subCity == null ? null : List<dynamic>.from(subCity!.map((x) => x)),
        "bedrooms": bedrooms == null
            ? null
            : List<dynamic>.from(bedrooms!.map((x) => x)),
        "category": category == null
            ? null
            : List<dynamic>.from(category!.map((x) => x)),
        "furnishType": furnishType == null
            ? null
            : List<dynamic>.from(furnishType!.map((x) => x)),
        "_id": id == null ? null : id!.toJson(),
        "propType": propType == null ? null : propType,
        "minPrice": minPrice == null ? null : minPrice,
        "maxPrice": maxPrice == null ? null : maxPrice,
        "constructionType": constructionType == null ? null : constructionType,
        "occupation": occupation == null ? null : occupation,
      };
}
