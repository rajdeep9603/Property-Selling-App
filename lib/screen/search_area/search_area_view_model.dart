import 'dart:convert';

import 'package:com.propacy.b2c/model/get_zones_areas.dart';
import 'package:com.propacy.b2c/rest_api/get_zones_areas_api.dart';
import 'package:com.propacy.b2c/screen/search_area/search_select_area.dart';
import 'package:com.propacy.b2c/services/sharedpreference.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:stacked/stacked.dart';

List<List<List<bool>>> areaList = [];

// List<Zone>? zone;
class SearchAreaViewModel extends BaseViewModel {
  Map<String, bool> map = {};
  Map<String, bool> submap = {};

  TextEditingController searchController = TextEditingController();
  List<String> tabList = ["anyZone", "south", "westurn", "central", "upper"];
  List<String> checkList = [
    "mahima to bandra ",
    "khar to andheri",
    "jogeshvari to borivali",
    "dahisar to virar",
    "palghar to beyond"
  ];
  List<String> checkListDetails = [
    "Jogeshvari",
    "Oshiwara",
    "Goregaun",
    "Malad",
    "Kandivali",
    "Borivali"
  ];
  String? areaTitle;
  bool on3ContainerTap = false;
  int categorySelected = 0;
  int checkArea = 1;
  List<Group>? zoneExpansionList;

  List<Group>? filterList = [];
  List<Group>? filterList1 = [];
  bool zonesCome = false;
  List<Area>? areas;
  bool? areaCome = false;
  List<Zone>? getZones;
  List<Group>? getZonesDisplay;
  List<Zone>? filterZone;
  String? contain;
  List<Zone>? searchZone;
  List<String>? groupList;
  List<String>? groupSearchRes = [];
  List<String> initGroup = [];
  List<bool> groupClick = [];
  List<List<String>> zn = [];
  List<Map<String, bool>> grpCheck = [];
  List<dynamic> key = [];
  Map<String, bool> grpClick = {};
  int tabIndex = 0;

  GetZonesModel zoneNewModel = GetZonesModel();

  // List<Group>? groupNewList;

  List<bool>? checkBoolListSize;
  List<String>? list2;
  List<bool>? checkBoolList = [];

  List? searchresult;

//   onChange(value,zoneModel){
//     var zones = getZones!.where((allzones) {
//       final titleLower = allzones.zoneCode!.toLowerCase();
//       // final authorLower = book.author.toLowerCase();
//       final searchLower = value.toLowerCase();
//
//       return titleLower.contains(searchLower);
//     }).toList();
//     filterZone = zones;
//     print(zones);
//     notifyListeners();
//     // setState(() {
//     //
//     //   this.books = books;
//     // });
//
// }

  getZonesModel() async {
    // selectArea = !selectArea;
    setBusy(true);
    await GetZonesApi.getZones().then((value) {
      zoneNewModel = value!;
      zoneNewModel.data!.zones!.forEach((element) {
        element.groups!.forEach((ele) {
          lockMap.addAll({ele.name.toString(): false});
        });
      });
      zoneExpansionList = value.data!.zones![0].groups;
      groupClick.clear();
      zoneExpansionList!.forEach((element) {
        groupClick.add(false);
        grpClick.addAll({element.name!: false});
      });
      print(zoneNewModel);
      setBusy(false);
      notifyListeners();
    });

    notifyListeners();
  }

  init(GetZonesModel? zoneModel) {
    FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cPreferenceAdd, Str.load, Str.lPreferences_location_page);
    if (zoneModel!.data == null) {
      Fluttertoast.showToast(
          msg: "Zones Not found",
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          toastLength: Toast.LENGTH_SHORT);
    } else {
      //getZonesModel();
      getZones = zoneModel.data!.zones;
      // getZonesDisplay = getZones!.cast<Group>();
      zoneExpansionList = zoneModel.data!.zones![0].groups;
      groupClick.clear();
      zoneExpansionList!.forEach((element) {
        groupClick.add(false);
        grpCheck.add({element.name.toString(): false});
      });

      //filterList = zoneModel.data!.zones![0].groups;
      // initGroup = zoneModel.result!.zones![0].groups![0].name.toString() as List<String>;
      getData(zoneModel);
      notifyListeners();
    }
  }

  getData(GetZonesModel? zoneModel) {
    //lts2.clear();
    // List<List<bool>> list = [];
    areaList = [];
    zoneModel!.data!.zones!.forEach((element) {
      //  groupClick.add(false);
      List<bool> lts = [];
      List<List<bool>> l1 = [];
      element.groups!.forEach((el) {
        List<bool> l2 = [];
        el.areas!.forEach((ele) async {
          ///ele.name== preference name  {l2.add true}else{l2.add false}
          if (loginHasPref == true) {
            print("AB2 " + ab2.toString());
            if (ab2
                .toString()
                .toLowerCase()
                .contains(ele.name.toString().toLowerCase())) {
              l2.add(true);
              displayLocality.add(ele.name.toString());
              print("ADD TRUE " + ele.name.toString());
              print("LOGIN AREA" + ab2.toString());
            } else {
              l2.add(false);
              print("ADD FALSE " + ele.name.toString());
            }
          } else {
            print("AB " + ab.toString());
            if (ab
                .toString()
                .toLowerCase()
                .contains(ele.name.toString().toLowerCase())) {
              l2.add(true);
              print("ADD TRUE " + ele.name.toString());
              displayLocality.add(ele.name.toString());
            } else {
              l2.add(false);
              print("ADD FALSE " + ele.name.toString());
            }
          }
          // l2.add(false);
          // print("ADD FALSE OUTSIDE " + ele.name.toString());
        });
        //filterList!.add(el);
        map.addAll({el.name!.toLowerCase(): false});
        l1.add(l2);
        lts.add(false);
      });
      // list.add(lts);
      //lts2.add(lts);
      areaList.add(l1);
    });

    print("map");
    print(map['mahim to bandra']);
    notifyListeners();
  }

  //for extra
//   getData(GetZonesModel? zoneModel){
//     lts2.clear();
// List<List<bool>>list=[];
//     zoneModel!.result!.zones!.forEach((element) {
//       List<bool>lts=[];
//       element.groups!.forEach((el) {
//         lts.add(false);
//       });
//       list.add(lts);
//       lts2.add(lts);
//     });
//     print(list);
//     notifyListeners();
//   }
//
//

  // void searchOperation(String searchText,GetZonesModel? zoneModel) {
  //   if(searchresult!=null){
  //     searchresult!.clear();
  //   }
  //
  //   // if (_isSearching != null) {
  //     for (int i = 0; i < zoneModel.//zoneExpansionList!.length; i++) {
  //       String data = zoneExpansionList![i] as String;
  //       if (data.toLowerCase().contains(searchText.toLowerCase())) {
  //
  //         searchresult!.add(data);
  //
  //       }
  //     }
  //   notifyListeners();

  searchValidation({String? value, GetZonesModel? zoneModel}) {
    value = zoneModel!.data!.zones![0].zoneCode.toString();
  }

  List<bool> isChecked = List.generate(100, (index) => false);
  List<bool> isChecked2 = List.generate(100, (index) => false);
  List<bool> isChecked3 = List.generate(100, (index) => false);
  List<bool> isChecked4 = List.generate(100, (index) => false);
}
