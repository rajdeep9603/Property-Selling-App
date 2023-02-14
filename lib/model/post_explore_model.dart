// To parse this JSON data, do
//
//     final postExploreVideoModel = postExploreVideoModelFromJson(jsonString);

import 'dart:convert';

PostExploreVideoModel postExploreVideoModelFromJson(String? str) =>
    PostExploreVideoModel.fromJson(json.decode(str!));

String? postExploreVideoModelToJson(PostExploreVideoModel data) =>
    json.encode(data.toJson());

class PostExploreVideoModel {
  PostExploreVideoModel({
    this.status,
    this.errorCode,
    this.errorMsg,
    this.data,
  });

  bool? status;
  String? errorCode;
  String? errorMsg;
  Result? data;

  factory PostExploreVideoModel.fromJson(Map<String, dynamic> json) =>
      PostExploreVideoModel(
        status: json["status"] == null ? null : json["status"],
        errorCode: json["erroCode"] == null ? null : json["erroCode"],
        errorMsg: json["errorMessage"] == null ? null : json["errorMessage"],
        data: json["data"] == null || json["status"] == "false"
            ? null
            : Result.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "erroCode": errorCode == null ? null : errorCode,
        "errorMessage": errorMsg == null ? null : errorMsg,
        "result": data == null ? null : data!.toJson(),
      };
}

class Result {
  Result({
    this.arrMatches,
  });

  List<ArrMatch>? arrMatches;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        arrMatches: json["arrMatches"] == null
            ? null
            : List<ArrMatch>.from(
                json["arrMatches"].map((x) => ArrMatch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "arrMatches": arrMatches == null
            ? null
            : List<dynamic>.from(arrMatches!.map((x) => x.toJson())),
      };
}

class ArrMatch {
  ArrMatch({
    this.agent,
    this.amenities,
    this.nearByAmenities,
    this.images,
    this.arrMatchingRequirements,
    this.arrDeals,
    this.id,
    this.status,
    this.tenantId,
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
    this.vrLink,
    this.area,
    this.category,
    this.parentCategory,
    this.depositAmount,
    this.agreementValue,
    this.type,
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
    this.videos,
    this.tourType,
    this.dtmSchedule,
    this.shortList,
  });

  List<Agent>? agent;
  List<String>? amenities;
  List<String>? nearByAmenities;
  List<Images>? images;
  List<ArrMatchingRequirement>? arrMatchingRequirements;
  List<ArrDeal>? arrDeals;
  String? id;
  String? status;
  String? tenantId;
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
  List<dynamic>? vrLink;
  String? area;
  String? category;
  String? parentCategory;
  int? depositAmount;
  int? agreementValue;
  String? type;
  String? isNegotiable;
  DateTime? dueDate;
  String? floor;
  int? carParking;
  String? sellingPoint;
  String? bedroom;
  String? createdTime;
  String? updatedTime;
  String? bathroom;
  String? expectedTat;
  String? garage;
  String? years;
  List<Images>? videos;
  String? tourType;
  DateTime? dtmSchedule;
  bool? shortList;

  factory ArrMatch.fromJson(Map<String, dynamic> json) => ArrMatch(
        agent: json["agent"] == null
            ? null
            : List<Agent>.from(json["agent"].map((x) => Agent.fromJson(x))),
        amenities: json["amenities"] == null
            ? null
            : List<String>.from(json["amenities"].map((x) => x)),
        nearByAmenities: json["nearByAmenities"] == null
            ? null
            : List<String>.from(json["nearByAmenities"].map((x) => x)),
        images: json["images"] == null
            ? null
            : List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
        arrMatchingRequirements: json["arrMatchingRequirements"] == null
            ? null
            : List<ArrMatchingRequirement>.from(json["arrMatchingRequirements"]
                .map((x) => ArrMatchingRequirement.fromJson(x))),
        arrDeals: json["arrDeals"] == null
            ? null
            : List<ArrDeal>.from(
                json["arrDeals"].map((x) => ArrDeal.fromJson(x))),
        id: json["_id"] == null ? null : json["_id"],
        status: json["status"] == null ? null : json["status"],
        tenantId: json["tenantId"] == null ? null : json["tenantId"],
        customerId: json["customerId"] == null ? null : json["customerId"],
        title: json["title"] == null ? null : json["title"],
        exactMatchct:
            json["exactMatchct"] == null ? null : json["exactMatchct"],
        similarMatchct:
            json["similarMatchct"] == null ? null : json["similarMatchct"],
        minPrice: json["minPrice"] == null ? null : json["minPrice"],
        maxPrice: json["maxPrice"] == null ? null : json["maxPrice"].toString(),
        city: json["city"] == null ? null : json["city"],
        subCity: json["subCity"] == null ? null : json["subCity"],
        constructionType:
            json["constructionType"] == null ? null : json["constructionType"],
        furnishType: json["furnishType"] == null ? null : json["furnishType"],
        lat: json["lat"] == null ? null : json["lat"],
        lng: json["lng"] == null ? null : json["lng"],
        description: json["description"] == null ? null : json["description"],
        vrLink: json["vrLink"] == null
            ? null
            : List<dynamic>.from(json["vrLink"].map((x) => x)),
        area: json["area"] == null ? null : json["area"].toString(),
        category: json["category"] == null ? null : json["category"].toString(),
        parentCategory: json["parentCategory"] == null
            ? null
            : json["parentCategory"].toString(),
        depositAmount:
            json["depositAmount"] == null ? null : json["depositAmount"],
        agreementValue:
            json["agreementValue"] == null ? null : json["agreementValue"],
        type: json["type"] == null ? null : json["type"],
        isNegotiable:
            json["isNegotiable"] == null ? null : json["isNegotiable"],
        dueDate:
            json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
        floor: json["floor"] == null ? null : json["floor"],
        carParking: json["carParking"] == null ? null : json["carParking"],
        sellingPoint:
            json["sellingPoint"] == null ? null : json["sellingPoint"],
        bedroom: json["bedroom"] == null ? null : json["bedroom"].toString(),
        createdTime:
            json["createdTime"] == null ? null : json["createdTime"].toString(),
        updatedTime:
            json["updatedTime"] == null ? null : json["updatedTime"].toString(),
        bathroom: json["bathroom"] == null ? null : json["bathroom"].toString(),
        expectedTat:
            json["expectedTAT"] == null ? null : json["expectedTAT"].toString(),
        garage: json["garage"] == null ? null : json["garage"].toString(),
        years: json["years"] == null ? null : json["years"].toString(),
        videos: json["videos"] == null
            ? null
            : List<Images>.from(json["videos"].map((x) => Images.fromJson(x))),
        tourType: json["tourType"] == null ? null : json["tourType"].toString(),
        dtmSchedule: json["dtmSchedule"] == null
            ? null
            : DateTime.parse(json["dtmSchedule"]),
        shortList: json['shortList'],
      );

  Map<String, dynamic> toJson() => {
        "agent": agent == null
            ? null
            : List<dynamic>.from(agent!.map((x) => x.toJson())),
        "amenities": amenities == null
            ? null
            : List<dynamic>.from(amenities!.map((x) => x)),
        "nearByAmenities": nearByAmenities == null
            ? null
            : List<dynamic>.from(nearByAmenities!.map((x) => x)),
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "arrMatchingRequirements": arrMatchingRequirements == null
            ? null
            : List<dynamic>.from(
                arrMatchingRequirements!.map((x) => x.toJson())),
        "arrDeals": arrDeals == null
            ? null
            : List<dynamic>.from(arrDeals!.map((x) => x.toJson())),
        "_id": id == null ? null : id,
        "status": status == null ? null : status,
        "tenantId": tenantId == null ? null : tenantId,
        "customerId": customerId == null ? null : customerId,
        "title": title == null ? null : title,
        "exactMatchct": exactMatchct == null ? null : exactMatchct,
        "similarMatchct": similarMatchct == null ? null : similarMatchct,
        "minPrice": minPrice == null ? null : minPrice,
        "maxPrice": maxPrice == null ? null : maxPrice,
        "city": city == null ? null : city,
        "subCity": subCity == null ? null : subCity,
        "constructionType": constructionType == null ? null : constructionType,
        "furnishType": furnishType == null ? null : furnishType,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
        "description": description == null ? null : description,
        "vrLink":
            vrLink == null ? null : List<dynamic>.from(vrLink!.map((x) => x)),
        "area": area == null ? null : area,
        "category": category == null ? null : category,
        "parentCategory": parentCategory == null ? null : parentCategory,
        "depositAmount": depositAmount == null ? null : depositAmount,
        "agreementValue": agreementValue == null ? null : agreementValue,
        "type": type == null ? null : type,
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
        "years": years == null ? null : years,
        "videos": videos == null
            ? null
            : List<dynamic>.from(videos!.map((x) => x.toJson())),
        "tourType": tourType == null ? null : tourType,
        "dtmSchedule":
            dtmSchedule == null ? null : dtmSchedule!.toIso8601String(),
        "shortList": shortList,
      };
}

class Agent {
  Agent({
    this.agentId,
    this.startDate,
    this.endDate,
    this.status,
  });

  String? agentId;
  String? startDate;
  String? endDate;
  String? status;

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        agentId: json["agentId"] == null ? null : json["agentId"],
        startDate: json["startDate"] == null ? null : json["startDate"],
        endDate: json["endDate"] == null ? null : json["endDate"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "agentId": agentId == null ? null : agentId,
        "startDate": startDate == null ? null : startDate,
        "endDate": endDate == null ? null : endDate,
        "status": status == null ? null : status,
      };
}

class ArrDeal {
  ArrDeal({
    this.status,
    this.buyerId,
    this.sellerId,
    this.sellPrice,
    this.purchasePrice,
    this.marketValue,
    this.downPayment,
    this.loan,
    this.agentCommission,
    this.transactionDateTime,
    this.arrRent,
    this.arrDocs,
    this.tenure,
    this.startDate,
    this.endDate,
    this.landlordId,
    this.tenantId,
    this.termsCondition,
  });

  String? status;
  String? buyerId;
  String? sellerId;
  String? sellPrice;
  String? purchasePrice;
  String? marketValue;
  String? downPayment;
  String? loan;
  String? agentCommission;
  String? transactionDateTime;
  List<ArrRent>? arrRent;
  List<ArrDoc>? arrDocs;
  String? tenure;
  String? startDate;
  String? endDate;
  String? landlordId;
  String? tenantId;
  String? termsCondition;

  factory ArrDeal.fromJson(Map<String, dynamic> json) => ArrDeal(
        status: json["status"] == null ? null : json["status"],
        buyerId: json["buyerId"] == null ? null : json["buyerId"],
        sellerId: json["sellerId"] == null ? null : json["sellerId"],
        sellPrice: json["sellPrice"] == null ? null : json["sellPrice"],
        purchasePrice:
            json["purchasePrice"] == null ? null : json["purchasePrice"],
        marketValue: json["marketValue"] == null ? null : json["marketValue"],
        downPayment: json["downPayment"] == null ? null : json["downPayment"],
        loan: json["loan"] == null ? null : json["loan"],
        agentCommission:
            json["agentCommission"] == null ? null : json["agentCommission"],
        transactionDateTime: json["transactionDateTime"] == null
            ? null
            : json["transactionDateTime"],
        arrRent: json["arrRent"] == null
            ? null
            : List<ArrRent>.from(
                json["arrRent"].map((x) => ArrRent.fromJson(x))),
        arrDocs: json["arrDocs"] == null
            ? null
            : List<ArrDoc>.from(json["arrDocs"].map((x) => ArrDoc.fromJson(x))),
        tenure: json["tenure"] == null ? null : json["tenure"],
        startDate: json["startDate"] == null ? null : json["startDate"],
        endDate: json["endDate"] == null ? null : json["endDate"],
        landlordId: json["landlordId"] == null ? null : json["landlordId"],
        tenantId: json["tenantId"] == null ? null : json["tenantId"],
        termsCondition:
            json["termsCondition"] == null ? null : json["termsCondition"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "buyerId": buyerId == null ? null : buyerId,
        "sellerId": sellerId == null ? null : sellerId,
        "sellPrice": sellPrice == null ? null : sellPrice,
        "purchasePrice": purchasePrice == null ? null : purchasePrice,
        "marketValue": marketValue == null ? null : marketValue,
        "downPayment": downPayment == null ? null : downPayment,
        "loan": loan == null ? null : loan,
        "agentCommission": agentCommission == null ? null : agentCommission,
        "transactionDateTime":
            transactionDateTime == null ? null : transactionDateTime,
        "arrRent": arrRent == null
            ? null
            : List<dynamic>.from(arrRent!.map((x) => x.toJson())),
        "arrDocs": arrDocs == null
            ? null
            : List<dynamic>.from(arrDocs!.map((x) => x.toJson())),
        "tenure": tenure == null ? null : tenure,
        "startDate": startDate == null ? null : startDate,
        "endDate": endDate == null ? null : endDate,
        "landlordId": landlordId == null ? null : landlordId,
        "tenantId": tenantId == null ? null : tenantId,
        "termsCondition": termsCondition == null ? null : termsCondition,
      };
}

class ArrDoc {
  ArrDoc({
    this.docName,
    this.docUrl,
  });

  String? docName;
  String? docUrl;

  factory ArrDoc.fromJson(Map<String, dynamic> json) => ArrDoc(
        docName: json["docName"] == null ? null : json["docName"],
        docUrl: json["docURL"] == null ? null : json["docURL"],
      );

  Map<String, dynamic> toJson() => {
        "docName": docName == null ? null : docName,
        "docURL": docUrl == null ? null : docUrl,
      };
}

class ArrRent {
  ArrRent({
    this.year,
    this.rent,
  });

  String? year;
  String? rent;

  factory ArrRent.fromJson(Map<String, dynamic> json) => ArrRent(
        year: json["year"] == null ? null : json["year"],
        rent: json["rent"] == null ? null : json["rent"],
      );

  Map<String, dynamic> toJson() => {
        "year": year == null ? null : year,
        "rent": rent == null ? null : rent,
      };
}

class ArrMatchingRequirement {
  ArrMatchingRequirement({
    this.reqId,
    this.matchDateTime,
    this.seen,
  });

  String? reqId;
  String? matchDateTime;
  String? seen;

  factory ArrMatchingRequirement.fromJson(Map<String, dynamic> json) =>
      ArrMatchingRequirement(
        reqId: json["reqId"] == null ? null : json["reqId"],
        matchDateTime:
            json["matchDateTime"] == null ? null : json["matchDateTime"],
        seen: json["seen"] == null ? null : json["seen"],
      );

  Map<String, dynamic> toJson() => {
        "reqId": reqId == null ? null : reqId,
        "matchDateTime": matchDateTime == null ? null : matchDateTime,
        "seen": seen == null ? null : seen,
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
}
