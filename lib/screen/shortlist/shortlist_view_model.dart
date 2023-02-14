import 'package:com.propacy.b2c/model/get_shortlist_data_model.dart';
import 'package:com.propacy.b2c/model/post_explore_model.dart';
import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:com.propacy.b2c/rest_api/get_shortlist_data_api.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/screen/property_details/property_details_screen.dart';
import 'package:com.propacy.b2c/screen/shortlist/shortlist_screen.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/show_vidio_screen.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/vidio_view_model.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class ShortListViewModel extends BaseViewModel {
  GetShortListDataModel shortListModel = GetShortListDataModel();

  // ignore: non_constant_identifier_names
  String? tapping;
  int indexBottem = 1;
  ArrMatch? details;
  String? customerId;
  bool? dateCome = false;
  String errorText = '';
  List<Map<String, dynamic>> infoList = [
    {
      "image": "assets/image/house.jpg",
      "title": "96% Match",
      "sub": "Lodha Bel Air",
      "bhk": "3 bhk .1120 area",
      "area": "Patel Street Jogeshvari E",
    },
    {
      "image": "assets/image/house.jpg",
      "title": "96% Match",
      "sub": "Lodha Bel Air",
      "bhk": "3 bhk .1120 area",
      "area": "Patel Street Jogeshvari E",
    },
    // {
    //   "image": "assets/image/propertyHome.png",
    //   "title": "96awdwed% Match",
    //   "sub": "Lodha Bel Air",
    //   "bhk": "3 Bhk .1120 area",
    //   "area": "Patel Street Jogeshvari E",
    // },
  ];

  Future<void> init() async {
    FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cShortlist, Str.load, Str.lProperties_shortlisted_page);
    await getCoustID();
    getShortListedData();
    tapping = infoList[0]["title"];
    // var tempDate = new DateFormat(shortListModel.data![0].createdTime).parse(savedDateString);
  }

  Future<void> getCoustID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    customerId = prefs.getString("loginCustomerId");
    print("CUSTOMER ID====>  " + customerId.toString());
  }

  // String? dateTime(){
  //  final now = shortListModel.data![0].createdTime;
  //   time = DateFormat('dd-MM-yyyy').format(now);
  // }

  getShortListedData() async {
    setBusy(true);
    notifyListeners();
    await GetShortListedDataApi.getShortListData(cId: customerId).then((value) {
      if (value != null) {
        print("success");

        shortListModel = value;
        print(shortListModel);
        errorText = '';
      } else {
        errorText = 'No Property data found';
        return null;
      }
    });
    setBusy(false);
    notifyListeners();
    /*   await GetShortListedDataApi.getareaDetail().then((value) {
      print(value);
    });*/
  }

  void onHomeTap() {
    indexBottem = 0;
    notifyListeners();
    Get.to(() => VidioScreen(
          feedModel: feedModel == null ? null : feedModel,
        ));
  }

  void onDetailTap() {
    Get.to(() => PropertyDetailsScreen());
  }

  void onShortListTap() {
    FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cShortlist, Str.click, Str.lProperty_shortlisted);
    indexBottem = 1;
    notifyListeners();
    Get.to(() => ShortListScreen());
  }

  void onSettingTap() {
    indexBottem = 2;
    notifyListeners();
    Get.to(() => InterSelectionScreen());
  }
}
