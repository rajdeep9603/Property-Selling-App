import 'dart:async';
import 'package:com.propacy.b2c/model/chat_model/chat_api_resp_model.dart';
import 'package:com.propacy.b2c/model/get_shortlist_data_model.dart';
import 'package:com.propacy.b2c/model/post_explore_model.dart';
import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:com.propacy.b2c/rest_api/chat_api.dart';
import 'package:com.propacy.b2c/rest_api/post_preference_api.dart';
import 'package:com.propacy.b2c/screen/chat/chat_screen/chat_screen.dart';
import 'package:com.propacy.b2c/screen/property_details/property_details_screen.dart';
import 'package:com.propacy.b2c/screen/property_details/widgets/widget.dart';
import 'package:com.propacy.b2c/screen/shortlist/shortlist_screen.dart';
import 'package:com.propacy.b2c/services/chat_service/chat_service.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/app.dart';
import 'package:com.propacy.b2c/utils/color_res.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:com.propacy.b2c/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class PropertyDetailsViewModel extends BaseViewModel {
  String? onBottemTap;
  String? tabTitle;
  String? min;
  String? max;

  bool isLoading = false;

  // bool isShortListed = false;
  PostPreferenceModel postPreferenceModelData = PostPreferenceModel();
  bool isVisitScheduled = false;
  String? customerId;
  String? propertyId;
  bool shortListTap = false;
  ChatApiResponseModel? chatApiResponseModel;
  bool dateIsSelect = false;

  ArrMatch arr = ArrMatch();
  List<String> tabbarListSubtitle = [];

  init({required String pId, required ArrMatch arrMatch}) async {
    // getPropertyDetails();
    getCoustID();
    propertyId = pId.toString();
    arr = arrMatch;
    getPropertyDetails();

    // setBusy(true);
    // isLoading = true;
    // notifyListeners();

    // final response = await http.post(
    //   Uri.parse('https://connect.propacy.com/api/uv/matches'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: json.encode(<String, dynamic>{
    //     "userProfile": "Professional",
    //     "intent": "BS",
    //     "type": "Ready to move",
    //     "category": ["Apartment"],
    //     "area": ["1", "2"],
    //     "minPrice": "1000",
    //     "maxPrice": "500000000",
    //     "locality": ["Malad", "Borivali", "Bandra"],
    //     "customerId": "61783d68e749a41cbae49103",
    //     "appCode": "connectand",
    //     "furnishType": ["Full", "Semi", "None"]
    //   }),
    // );
    // print(response.statusCode);
    // print(response.body);

    // await PostPreferenceApi.postPrefenceApi().then((value) {
    //   setBusy(false);
    //   postPreferenceModelData = value!;
    //
    //   print(
    //       "postPreferenceModelData.result!.arrMatches![0] ${postPreferenceModelData.result!.arrMatches![0].images![0].link}");
    //   isLoading = false;
    //   notifyListeners();
    // });
  }

  getCoustID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    customerId = prefs.getString("loginCustomerId");
    print("CUSTOMER ID====>  " + customerId.toString());
  }

  getPropertyDetails() async {
    setBusy(true);
    isLoading = true;
    notifyListeners();

    tabbarListSubtitle.add(arr.bedroom.toString());
    tabbarListSubtitle.add(arr.bathroom.toString());
    tabbarListSubtitle.add(arr.furnishType.toString());
    tabbarListSubtitle.add(arr.area.toString() + " sq.ft.");
    tabbarListSubtitle.add(arr.floor.toString());
    tabbarListSubtitle.add(arr.carParking.toString());
    tabbarListSubtitle.add(arr.years.toString() + " years");
    String min1 = arr.minPrice.toString();
    int logmin = int.parse(min1.toString().split(".").first.toString());
    if (logmin >= 10000000) {
      double d = logmin / 10000000;
      min = d.toString() + " Cr";
    } else if (logmin >= 100000) {
      double d = logmin / 100000;
      min = d.toString() + " Lac";
    } else if (logmin >= 1000) {
      double d = logmin / 1000;
      min = d.toString() + " K";
    }
    print("min" + min.toString());

    String max1 = arr.maxPrice.toString();
    int logmax = int.parse(max1.toString().split(".").first.toString());
    if (logmax >= 10000000) {
      double d = logmax / 10000000;
      max = d.toString() + " Cr";
    } else if (logmax >= 100000) {
      double d = logmax / 100000;
      max = d.toString() + " Lac";
    } else if (logmax >= 1000) {
      double d = logmax / 1000;
      max = d.toString() + " K";
    }
    var range = "$min - $max";
    print("$min - $max");
    print("Range : " + range);
    tabbarListSubtitle.add(range);
    print("value set in property details tab" + tabbarListSubtitle.toString());
    isLoading = false;
    setBusy(false);
    notifyListeners();
    /*setBusy(true);
    isLoading = true;
    await PostPreferenceApi.postPrefenceApi().then((value) {
      setBusy(false);
      postPreferenceModelData = value!;
      notifyListeners();
      print(
          "postPreferenceModelData.result!.arrMatches![0] ${postPreferenceModelData.data!.arrMatches![0].images![0].link}");
      tabbarListSubtitle.add(postPreferenceModelData.data!.arrMatches![0].bedroom.toString());
      tabbarListSubtitle.add(postPreferenceModelData.data!.arrMatches![0].bathroom.toString());
      tabbarListSubtitle.add(postPreferenceModelData.data!.arrMatches![0].furnishType.toString());
      tabbarListSubtitle.add(postPreferenceModelData.data!.arrMatches![0].area.toString()+" sq.ft.");
      tabbarListSubtitle.add(postPreferenceModelData.data!.arrMatches![0].floor.toString());
      tabbarListSubtitle.add(postPreferenceModelData.data!.arrMatches![0].carParking.toString());
      tabbarListSubtitle.add(postPreferenceModelData.data!.arrMatches![0].years.toString()+" years");
      String min1 = postPreferenceModelData.data!.arrMatches![0].minPrice.toString();
      int logmin = int.parse(min1.toString().split(".").first.toString());
      if(logmin>=10000000){
        double d = logmin / 10000000;
        min= d.toString() + " Cr";
      }else if(logmin>= 100000){
        double d = logmin / 100000;
        min= d.toString() + " Lac";
      }else if(logmin >= 1000){
        double d = logmin / 1000;
        min = d.toString() + " K";
      }
      print("min"+min.toString());

      String max1= postPreferenceModelData.data!.arrMatches![0].maxPrice.toString();
      int logmax = int.parse(max1.toString().split(".").first.toString());
      if(logmax>=10000000){
        double d = logmax / 10000000;
        max= d.toString() + " Cr";
      }else if(logmax>= 100000){
        double d = logmax / 100000;
        max= d.toString() + " Lac";
      }else if(logmax >= 1000){
        double d = logmax / 1000;
        max = d.toString() + " K";
      }
      var range = "$min - $max";
      print("$min - $max");
      print("Range : "+range);
      // tabbarListSubtitle.add(range);
      print("value set in property details tab"+tabbarListSubtitle.toString());
      isLoading = false;
      notifyListeners();
    });*/
  }

  onShortlistCalled({
    String? date,
    String? status,
    String? command,
    // String? status,
  }) async {
    /*isLoading = true;
    notifyListeners();*/
    print("called");
    PostPreferenceApi.shortlist(
            status: status,
            date: date,
            cId: customerId,
            pId: propertyId,
            command: command)
        .then((value) {
      /*setBusy(false);
      isLoading = false;*/
      notifyListeners();
      print("Yeah, this line is printed after 3 seconds");
      // Get.to(()=>ShortListScreen());
    });
  }

  List<String> tabbarList = [
    "Details",
    "Amenities(13)",
    "Nearby(3)",
  ];

  List<String> details = [
    "Bedroom",
    "Bathroom",
    "Furnish type",
    "Carpet area",
    "Floor",
    "Car parking",
    "Years",
    // "Price"
  ];

/*
*/

  // List<String> tabbarListSubtitle = [
  //   "14th",
  //   "4",
  //   "3",
  //   "5-10 yrs",
  //   "14th",
  //   "4",
  //   "3",
  //   "5-10 yrs",
  //   "14th",
  //   "4",
  //   "3",
  //   "5-10 yrs",
  //   "14th",
  //   "4",
  //   "3",
  //   "5-10 yrs",
  // ];

  Future<void> onDateSelect(context, pid) async {
    FirebaseAnalyticsService.sendAnalyticsEvent3(
        Str.cSchedule, Str.click, Str.lPhysical_schedule,pid);
    //schedule confirmation page
    Get.back();
    /*setBusy(true);
    notifyListeners();*/
    onShortlistCalled(
        date: selectedDateTime!.toIso8601String(),
        status: 'O',
        command: 'physicaltour');
    arr.dtmSchedule = selectedDateTime;
    arr.tourType = 'physicaltour';
    dateIsSelect = true;
    notifyListeners();
    /*setBusy(false);
    notifyListeners();*/
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          height: 240,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          color: ColorRes.containerbgColor,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Visit scheduled successfully!",
                    style: AppTextStyle(
                        textColor: ColorRes.textGrey,
                        size: 16,
                        weight: FontWeight.bold),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: Image.asset("assets/icons/editblue.png")),
                  SizedBox(width: 10.0),
                  Text(
                    "Edit",
                    style: AppTextStyle(
                      textColor: ColorRes.primaryBlue,
                      size: 16,
                      weight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 15.0),
                ],
              ),
              SizedBox(width: 12.0),
              Image.asset(
                "assets/icons/caltrue.png",
                height: 80.0,
                width: 80.0,
              ),
              Text(
                AppRes.glad,
                style: AppTextStyle(
                  textColor: ColorRes.white,
                  size: 16,
                  weight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                AppRes.yourVisit,
                style: AppTextStyle(
                  textColor: ColorRes.white,
                  size: 16,
                  weight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.0),
              InkWell(
                onTap: () {
                  print("================>selected : $selectedDateTime");
                  /*onShortlistCalled(
                    date: selectedDateTime!
                        .toIso8601String(),
                    status: 'A',
                  );*/

                  Get.back();
                  arr.tourType = 'physicaltour';

                  //Get.offAll(() => ShortListScreen());
                  isVisitScheduled = true;
                  notifyListeners();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF76CCDD),
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(
                      color: Color(0xFF76CCDD),
                      width: 1.7,
                    ),
                  ),
                  child: Text(
                    "Got it",
                    style: AppTextStyle(
                      textColor: ColorRes.containerbgColor,
                      size: 16,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> onEditBtnTap(context) async {
    FirebaseAnalyticsService.sendAnalyticsEvent3(
        Str.cSchedule, Str.click, Str.lSchedule_edit,propertyId);
    int index = 0;
    final _controller = CupertinoDatePickerController();
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
            builder: (context, setState) => Container(
                // height: 58,
                color: ColorRes.containerbgColor,
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 5.0,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Picka a time slot of your choice',
                        style: AppTextStyle(
                            textColor: ColorRes.textGrey,
                            size: 14,
                            weight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              index = 0;
                              _controller.scrollToDate(DateTime.now());
                            });
                          },
                          child: Container(
                            decoration: index == 0
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: ColorRes.raioContainer,
                                    border: Border.all(
                                      width: 2.0,
                                      color: ColorRes.grey,
                                    ),
                                  )
                                : BoxDecoration(),
                            height: 35,
                            width: Get.width / 3.5,
                            alignment: Alignment.center,
                            child: Text(
                              "This week",
                              style: AppTextStyle(
                                textColor: ColorRes.whiteText,
                                size: 14,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () {
                            if (index != 1) {
                              setState(() {
                                if (index == 2) {
                                  _controller.scrollToDate(selectedDateTime!
                                      .subtract(Duration(days: 7)));
                                } else {
                                  _controller.scrollToDate(
                                      selectedDateTime!.add(Duration(days: 7)));
                                }
                                index = 1;
                              });
                            }
                          },
                          child: Container(
                            decoration: index == 1
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: ColorRes.raioContainer,
                                    border: Border.all(
                                      width: 2.0,
                                      color: ColorRes.grey,
                                    ),
                                  )
                                : BoxDecoration(),
                            alignment: Alignment.center,
                            height: 35,
                            width: Get.width / 3.5,
                            child: Text(
                              "Next week",
                              style: AppTextStyle(
                                textColor: ColorRes.whiteText,
                                size: 14,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () {
                            if (index != 2) {
                              setState(() {
                                if (index == 2) {
                                  _controller.scrollToDate(selectedDateTime!
                                      .subtract(Duration(days: 21)));
                                } else {
                                  _controller.scrollToDate(selectedDateTime!
                                      .add(Duration(days: 21)));
                                }
                              });
                              index = 2;
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: index == 2
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: ColorRes.raioContainer,
                                    border: Border.all(
                                      width: 2.0,
                                      color: ColorRes.grey,
                                    ),
                                  )
                                : BoxDecoration(),
                            height: 35,
                            width: Get.width / 3.5,
                            child: Text(
                              "+2 weeks",
                              style: AppTextStyle(
                                textColor: ColorRes.whiteText,
                                size: 14,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: Get.height * 0.3,
                      child: CupertinoTheme(
                        data: CupertinoThemeData(
                          textTheme: CupertinoTextThemeData(
                            dateTimePickerTextStyle: TextStyle(
                              color: ColorRes.white,
                            ),
                          ),
                        ),
                        child: ControlledCupertinoDatePicker(
                          controller: _controller,
                          mode: CupertinoDatePickerMode.dateAndTime,
                          minimumDate: DateTime.now(),
                          initialDateTime: arr.dtmSchedule,
                          onDateTimeChanged: (value) {
                            if (value != selectedDateTime)
                              setState(() {
                                selectedDateTime = value;
                                print(
                                    "=============>>>>>>>>>>>>>$selectedDateTime");
                              });
                          },
                          // initialDateTime: selectedDate,
                          minuteInterval: 30,
                          minimumYear: 2019,
                          maximumYear: 2021,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        FirebaseAnalyticsService.sendAnalyticsEvent3(
                            Str.cSchedule, Str.click, Str.lSchedule_edit_done,propertyId);
                        Get.back();
                        /*setBusy(true);
                        notifyListeners();*/
                        arr.dtmSchedule = selectedDateTime;
                        dateIsSelect = true;
                        notifyListeners();
                        await onShortlistCalled(
                          date: selectedDateTime!.toIso8601String(),
                          status: 'O',
                          command: 'physicaltour',
                        );
                        /*arr.dtmSchedule = selectedDateTime;
                        dateIsSelect = true;*/
                        /*setBusy(false);
                        notifyListeners();*/
                        Get.bottomSheet(BottomSheet(
                          builder: (ctx) {
                            return Container(
                              height: 270,
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              color: ColorRes.containerbgColor,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Visit scheduled successfully!",
                                        style: AppTextStyle(
                                            textColor: ColorRes.textGrey,
                                            size: 16,
                                            weight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                          onTap: () => Get.back(),
                                          child: Image.asset(
                                              "assets/icons/editblue.png")),
                                      SizedBox(width: 10.0),
                                      Text(
                                        "Edit",
                                        style: AppTextStyle(
                                          textColor: ColorRes.primaryBlue,
                                          size: 16,
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 15.0),
                                    ],
                                  ),
                                  SizedBox(width: 12.0),
                                  Image.asset(
                                    "assets/icons/caltrue.png",
                                    height: 80.0,
                                    width: 80.0,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    AppRes.glad,
                                    style: AppTextStyle(
                                      textColor: ColorRes.white,
                                      size: 16,
                                      weight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    AppRes.yourVisit,
                                    style: AppTextStyle(
                                      textColor: ColorRes.white,
                                      size: 16,
                                      weight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 15.0),
                                  InkWell(
                                    onTap: () {
                                      isVisitScheduled = true;
                                      Get.back();
                                      //Get.back(result: true);
                                      setState(() {});
                                      notifyListeners();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      alignment: Alignment.center,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF76CCDD),
                                        borderRadius: BorderRadius.circular(99),
                                        border: Border.all(
                                          color: Color(0xFF76CCDD),
                                          width: 1.7,
                                        ),
                                      ),
                                      child: Text(
                                        "Got it",
                                        style: AppTextStyle(
                                          textColor: ColorRes.containerbgColor,
                                          size: 16,
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          onClosing: () {},
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        alignment: Alignment.center,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF76CCDD),
                          borderRadius: BorderRadius.circular(99),
                          border:
                              Border.all(color: Color(0xFF76CCDD), width: 1.7),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.directions_walk_outlined,
                                color: Color(0xFF76CCDD)),
                            SizedBox(width: 10),
                            Text(
                              "Done",
                              style: AppTextStyle(
                                  textColor: ColorRes.containerbgColor,
                                  size: 16,
                                  weight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  chatViewScreen() async {
    ChatApi.chatApiResp(propertyId.toString()).then((value) {
      chatApiResponseModel = value;
      Get.to(() => ChatScreen(
            anpotherPhone: chatApiResponseModel!.data!.buddy!.number,
            uid: chatApiResponseModel!.data!.buddy!.uid.toString(),
            name: chatApiResponseModel!.data!.buddy!.name!,
        peerType:  chatApiResponseModel!.data!.buddy!.memberType,
          ));
    });
  }
}

/*
  "Floor",
    "Bedroooms",
    "Bathrooms",
    "Property age",
    "Floor",
    "Bedroooms",
    "Bathrooms",
    "Property age",
    "Floor",
    "Bedroooms",
    "Bathrooms",
    "Property age",
    "Floor",
    "Bedroooms",
    "Bathrooms",
    "Property age",

    */
String imageString(String imageName) {
  switch (imageName) {
    case "Swimming Pool":
      return "assets/icons/Swimming Pool.png";
    case "Garden":
      return "assets/icons/Garden.png";
    case "Spa":
      return "assets/icons/Spa.png";
    case "Gymnasium":
      return "assets/icons/Gymnasium.png";
    case "Senior Zone":
      return "assets/icons/Senior Zone.png";
    case "Club House":
      return "assets/icons/Club House.png";
    case "Guest Parking":
      return "assets/icons/Guest Parking.png";
    case "Lift":
      return "assets/icons/Lift.png";
    case "Mandir":
      return "assets/icons/Mandir.png";
    case "Mosque":
      return "assets/icons/Mosque.png";
    case "Church":
      return "assets/icons/Church.png";
    case "Store":
      return "assets/icons/Store.png";
    case "ATM":
      return "assets/icons/ATM.png";
    case "Bank":
      return "assets/icons/Bank.png";
    case "School":
      return "assets/icons/School.png";
    case "Hospital":
      return "assets/icons/Hospital.png";
    case "Metro":
      return "assets/icons/Metro.png";
    case "Transport":
      return "assets/icons/Transport.png";
    case "Bedroom":
      return "assets/icons/Bedroom.png";
    case "Bathroom":
      return "assets/icons/Bathroom.png";
    case "Furnish type":
      return "assets/icons/Furnish type.png";
    case "Carpet area":
      return "assets/icons/Carpet area.png";
    case "Floor":
      return "assets/icons/Floor.png";
    case "Car parking":
      return "assets/icons/Car parking.png";
    case "Years":
      return "assets/icons/Years.png";
    case "Price":
      return "assets/icons/Price.png";
    default:
      return "assets/icons/Spa.png";
  }
}
