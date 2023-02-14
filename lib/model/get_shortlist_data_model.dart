// To parse this JSON data, do
//
//     final getShortListDataModel = getShortListDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:com.propacy.b2c/model/post_explore_model.dart';
import 'package:com.propacy.b2c/model/post_preference_model.dart';

GetShortListDataModel getShortListDataModelFromJson(String str) =>
    GetShortListDataModel.fromJson(json.decode(str));

String getShortListDataModelToJson(GetShortListDataModel data) =>
    json.encode(data.toJson());

class GetShortListDataModel {
  GetShortListDataModel({
    this.status,
    this.errorCode,
    this.errorMsg,
    this.data,
  });

  String? status;
  String? errorCode;
  String? errorMsg;
  List<ArrMatch>? data;

  factory GetShortListDataModel.fromJson(Map<String, dynamic> json) =>
      GetShortListDataModel(
        status: json["status"] == null ? null : json["status"],
        errorCode: json["errorCode"] == null ? null : json["errorCode"],
        errorMsg: json["errorMsg"] == null ? null : json["errorMsg"],
        data: json["data"] == null
            ? null
            : List<ArrMatch>.from(
                json["data"].map((x) => ArrMatch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "errorCode": errorCode == null ? null : errorCode,
        "errorMsg": errorMsg == null ? null : errorMsg,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

/*class ArrMatch {
  ArrMatch({
    this.id,
    this.status,
    this.customerId,
    this.title,
    this.exactMatchct,
    this.similarMatchct,
    this.minPrice,
    this.maxPrice,
    this.city,
    this.subCity,
    this.constructionType,
    this.furnishType,
    this.lat,
    this.lng,
    this.description,
    this.amenities,
    this.nearByAmenities,
    this.vrLink,
    this.area,
    this.category,
    this.parentCategory,
    this.depositAmount,
    this.agreementValue,
    this.isNegotiable,
    this.dueDate,
    this.floor,
    this.carParking,
    this.sellingPoint,
    this.bedroom,
    this.createdTime,
    this.updatedTime,
    this.bathroom,
    this.expectedTat,
    this.garage,
    this.years,
    this.images,
    this.videos,
    this.tourType,
    this.dtmSchedule,
  });

  String? id;
  String? status;
  String? customerId;
  String? title;
  String? exactMatchct;
  String? similarMatchct;
  int? minPrice;
  String? maxPrice;
  String? city;
  String? subCity;
  String? constructionType;
  String? furnishType;
  String? lat;
  String? lng;
  String? description;
  List<String>? amenities;
  List<String>? nearByAmenities;
  List<dynamic>? vrLink;
  dynamic area;
  String? category;
  String? parentCategory;
  int? depositAmount;
  int? agreementValue;
  String? isNegotiable;
  DateTime? dueDate;
  String? floor;
  int ?carParking;
  String? sellingPoint;
  String? bedroom;
  String? createdTime;
  String? updatedTime;
  String? bathroom;
  String? expectedTat;
  String? garage;
  String? years;
  List<Images>? images;
  List<dynamic>? videos;
  String? tourType;
  DateTime? dtmSchedule;

  factory ArrMatch.fromJson(Map<String, dynamic> json) => ArrMatch(
    id: json["_id"] == null ? null : json["_id"],
    status: json["status"] == null ? null : json["status"],
    customerId: json["customerId"] == null ? null : json["customerId"],
    title: json["title"] == null ? null : json["title"],
    exactMatchct: json["exactMatchct"] == null ? null : json["exactMatchct"],
    similarMatchct: json["similarMatchct"] == null ? null : json["similarMatchct"],
    minPrice: json["minPrice"] == null ? null : json["minPrice"],
    maxPrice: json["maxPrice"].toString() == null ? null : json["maxPrice"].toString(),
    city: json["city"] == null ? null : json["city"],
    subCity: json["subCity"] == null ? null : json["subCity"],
    constructionType: json["constructionType"] == null ? null : json["constructionType"],
    furnishType: json["furnishType"] == null ? null : json["furnishType"],
    lat: json["lat"] == null ? null : json["lat"],
    lng: json["lng"] == null ? null : json["lng"],
    description: json["description"] == null ? null : json["description"],
    amenities: json["amenities"] == null ? null : List<String>.from(json["amenities"].map((x) => x)),
    nearByAmenities: json["nearByAmenities"] == null ? null : List<String>.from(json["nearByAmenities"].map((x) => x)),
    vrLink: json["vrLink"] == null ? null : List<dynamic>.from(json["vrLink"].map((x) => x)),
    area: json["area"] == null ? null : json["area"],
    category: json["category"] == null ? null : json["category"],
    parentCategory: json["parentCategory"] == null ? null : json["parentCategory"],
    depositAmount: json["depositAmount"] == null ? null : json["depositAmount"],
    agreementValue: json["agreementValue"] == null ? null : json["agreementValue"],
    isNegotiable: json["isNegotiable"] == null ? null : json["isNegotiable"],
    dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
    floor: json["floor"] == null ? null : json["floor"],
    carParking: json["carParking"] == null ? null : json["carParking"],
    sellingPoint: json["sellingPoint"] == null ? null : json["sellingPoint"],
    bedroom: json["bedroom"] == null ? null : json["bedroom"],
    createdTime: json["createdTime"] == null ? null : json["createdTime"],
    updatedTime: json["updatedTime"] == null ? null : json["updatedTime"],
    bathroom: json["bathroom"] == null ? null : json["bathroom"],
    expectedTat: json["expectedTAT"] == null ? null : json["expectedTAT"],
    garage: json["garage"] == null ? null : json["garage"],
    years: json["years"].toString() == null ? null : json["years"].toString(),
    images: json["images"] == null ? null : List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
    videos: json["videos"] == null ? null : List<dynamic>.from(json["videos"].map((x) => x)),
    tourType: json["tourType"] == null ? null : json["tourType"],
    dtmSchedule: json["dtmSchedule"] == null ? null : DateTime.parse(json["dtmSchedule"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "status": status == null ? null : status,
    "customerId": customerId == null ? null : customerId,
    "title": title == null ? null : title,
    "exactMatchct": exactMatchct == null ? null : exactMatchct,
    "similarMatchct": similarMatchct == null ? null : similarMatchct,
    "minPrice": minPrice == null ? null : minPrice,
    "maxPrice": maxPrice.toString() == null ? null : maxPrice.toString(),
    "city": city == null ? null : city,
    "subCity": subCity == null ? null : subCity,
    "constructionType": constructionType == null ? null : constructionType,
    "furnishType": furnishType == null ? null : furnishType,
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
    "description": description == null ? null : description,
    "amenities": amenities == null ? null : List<dynamic>.from(amenities!.map((x) => x)),
    "nearByAmenities": nearByAmenities == null ? null : List<dynamic>.from(nearByAmenities!.map((x) => x)),
    "vrLink": vrLink == null ? null : List<dynamic>.from(vrLink!.map((x) => x)),
    "area": area == null ? null : area,
    "category": category == null ? null : category,
    "parentCategory": parentCategory == null ? null : parentCategory,
    "depositAmount": depositAmount == null ? null : depositAmount,
    "agreementValue": agreementValue == null ? null : agreementValue,
    "isNegotiable": isNegotiable == null ? null : isNegotiable,
    "dueDate": dueDate == null ? null : dueDate!.toIso8601String(),
    "floor": floor == null ? null : floor,
    "carParking": carParking == null ? null : carParking,
    "sellingPoint": sellingPoint == null ? null : sellingPoint,
    "bedroom": bedroom == null ? null : bedroom,
    "createdTime": createdTime == null ? null : createdTime,
    "updatedTime": updatedTime == null ? null : updatedTime,
    "bathroom": bathroom == null ? null : bathroom,
    "expectedTAT": expectedTat == null ? null : expectedTat,
    "garage": garage == null ? null : garage,
    "years": years.toString()== null ? null : years.toString(),
    "images": images == null ? null : List<dynamic>.from(images!.map((x) => x.toJson())),
    "videos": videos == null ? null : List<dynamic>.from(videos!.map((x) => x)),
    "tourType": tourType == null ? null : tourType,
    "dtmSchedule": dtmSchedule == null ? null : dtmSchedule!.toIso8601String(),
  };
}

class Images {
  Images({
    this.tag,
    this.link,
  });

  String? tag;
  String? link;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    tag: json["tag"] == null ? null : json["tag"],
    link: json["link"] == null ? null : json["link"],
  );

  Map<String, dynamic> toJson() => {
    "tag": tag == null ? null : tag,
    "link": link == null ? null : link,
  };
}*/
