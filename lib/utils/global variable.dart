import 'package:com.propacy.b2c/model/get_preference_model.dart';
import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:flutter/animation.dart';

bool firstopenvideo = false;
String? selectedMinPrize;
String? selectedMaxPrize;
String? radioBuy;
List<String> furnishType2 = ["Full", "Semi", "None"];
double? max1;
double? min1;
var occupationName;
List? imageList;
// var loginOccupation;
var loginLocality;
var loginLocalityList;
// var loginBedroom;
var loginCategory;
// var loginFurnishType;
// var loginType;
var loginMinPrice;
var loginMaxPrice;
var loginReadyToMove;
var loginRange;
var checkLoginPreference;
var isPrefHasData;
var selectedbhk;
var selectedApartment;
var isThisScreenFromProfile = false;
bool? lsIsThisScreenFromProfile;
bool showPop = true;
bool loginHasPref = false;
bool loginArea = false;
bool localArea = false;
String? checkUid;

List<String> displayCat = [];
List<String> displayFurnish = [];
List<String> displayBedRooms = [];
List<String> displayLocality = [];
List<String> selectedAreas = [];

List<String?> bgImages = [];

String? userProfileFromTap;
String? intentFromTap;
String? typeFromTap;
var categoryFromTap;
var localityFromTap;
var locOnTap;
var furnishTypeFromTap;
var bedRoomFromTap;
String? minPriceFromTap;
String? maxPriceFromTap;
String? rangeOnTap;
bool isProceedTap = false;

String? range1;
String? range2;
var range3;
var radio1;
String? indexTab;
List<String> categoriesList = [];
Map<String, dynamic> categoryMap = {};
List<String> furnishTypesList = [];
Map<String, dynamic> furnishTypesMap = {};
List<String> bedRoomList = [];
Map<String, dynamic> bedRoomMap = {};
List<String> lockList = [];
Map<String, dynamic> lockMap = {};

List<String> loc = [];

var radioReadytomove;

GetPreferenceModel preferenceModel = GetPreferenceModel();
PostPreferenceModel feedModel = PostPreferenceModel();

List<String> propertyRangeList = [];

String? minP;
String? maxP;

List<String> ab2 = [];
List<String> ab = [];

String userUid = '';

//animation
// bool isTopCollapsed = true;
// final Duration duration = const Duration(seconds: 3);
// AnimationController? controller;
