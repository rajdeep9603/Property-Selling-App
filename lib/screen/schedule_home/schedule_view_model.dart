import 'package:stacked/stacked.dart';

class ScheduleViewModel extends BaseViewModel {
  void init() {
    tabTitle = tabbarList[0].toString();
    // tabbarList = tabbarList[0].toString() as List<String>;
  }

  String? tabTitle;
  List<String> tabbarList = [
    "Details",
    "Amenities(13)",
    "Nearby(3)",
  ];

  List<String> tabbarListTitle = [
    "Floor",
    "Bedroooms",
    "bathrooms",
    "Property age",
  ];
  List<String> tabbarListSubtitle = [
    "14th",
    "4",
    "3",
    "5-10 yrs",
  ];
}
