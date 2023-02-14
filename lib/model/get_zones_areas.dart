// To parse this JSON data, do
//
//     final getZonesModel = getZonesModelFromJson(jsonString);

import 'dart:convert';

GetZonesModel getZonesModelFromJson(String str) =>
    GetZonesModel.fromJson(json.decode(str));

String getZonesModelToJson(GetZonesModel data) => json.encode(data.toJson());

class GetZonesModel {
  GetZonesModel({
    this.status,
    this.errorCode,
    this.errorMsg,
    this.data,
  });

  final String? status;
  final String? errorCode;
  final String? errorMsg;
  final Data? data;

  factory GetZonesModel.fromJson(Map<String, dynamic> json) => GetZonesModel(
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
    this.cityCode,
    this.zones,
  });

  final CityCode? cityCode;
  final List<Zone>? zones;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cityCode: cityCodeValues.map[json["cityCode"]],
        zones: List<Zone>.from(json["zones"].map((x) => Zone.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cityCode": cityCodeValues.reverse[cityCode],
        "zones": List<dynamic>.from(zones!.map((x) => x.toJson())),
      };
}

enum CityCode { BOM }

final cityCodeValues = EnumValues({"BOM": CityCode.BOM});

class Zone {
  Zone({
    this.zoneCode,
    this.groups,
  });

  final String? zoneCode;
  final List<Group>? groups;

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
        zoneCode: json["zoneCode"],
        groups: List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "zoneCode": zoneCode,
        "groups": List<dynamic>.from(groups!.map((x) => x.toJson())),
      };
}

class Group {
  Group({
    this.name,
    this.groupCode,
    this.areas,
  });

  final String? name;
  final String? groupCode;
  final List<Area>? areas;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        name: json["name"],
        groupCode: json["groupCode"],
        areas: List<Area>.from(json["areas"].map((x) => Area.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "groupCode": groupCode,
        "areas": List<dynamic>.from(areas!.map((x) => x.toJson())),
      };
}

class Area {
  Area({
    this.id,
    this.cityCode,
    this.name,
    this.pinCodes,
    this.subCityCode,
    this.lat,
    this.lng,
    this.groupCode,
  });

  final String? id;
  final CityCode? cityCode;
  final String? name;
  final List<PinCode>? pinCodes;
  final String? subCityCode;
  final String? lat;
  final String? lng;
  final String? groupCode;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["_id"],
        cityCode: cityCodeValues.map[json["cityCode"]],
        name: json["name"],
        pinCodes: List<PinCode>.from(
            json["pinCodes"].map((x) => PinCode.fromJson(x))),
        subCityCode: json["subCityCode"],
        lat: json["lat"],
        lng: json["lng"],
        groupCode: json["groupCode"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "cityCode": cityCodeValues.reverse[cityCode],
        "name": name,
        "pinCodes": List<dynamic>.from(pinCodes!.map((x) => x.toJson())),
        "subCityCode": subCityCode,
        "lat": lat,
        "lng": lng,
        "groupCode": groupCode,
      };
}

class PinCode {
  PinCode({
    this.pinCode,
    this.pinTitle,
  });

  final String? pinCode;
  final String? pinTitle;

  factory PinCode.fromJson(Map<String, dynamic> json) => PinCode(
        pinCode: json["pinCode"],
        pinTitle: json["pinTitle"],
      );

  Map<String, dynamic> toJson() => {
        "pinCode": pinCode,
        "pinTitle": pinTitle,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
