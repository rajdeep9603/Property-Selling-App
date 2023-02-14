import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? logCustomerId;
// String? customerId;
// getCoustID() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   customerId = prefs.getString("loginCustomerId");
//   print("CUSTOMER ID ANALYTICS====>  " + customerId.toString());
// }


class FirebaseAnalyticsService {
  static final FirebaseAnalytics analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver appAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: analytics);

  static Future<void> sendAnalyticsEvent1(category, action, eventName) async {
    await analytics.logEvent(
      name: category,
      parameters: <String, dynamic>{"action": action, "label": eventName},
    );
    // setMessage('logEvent succeeded');
    print(
        '-------*--------*-------logEvent succeeded $category, $action, $eventName');
  }

  static Future<void> sendAnalyticsEvent2(
      category, action, eventName, ) async {
    await analytics.logEvent(
      name: category,
      parameters: <String, dynamic>{
        "Action": action,
        "Label": eventName,
        "memberId": logCustomerId,
      },
    );
    // setMessage('logEvent succeeded');
    print('-------*--------*------- CATEGORY : $category, ACTION : $action, EVENT NAME : $eventName, CUSTOMER ID : $logCustomerId');
  }

  static Future<void> sendAnalyticsEvent3(
      category, action, eventName, propertyId) async {
    await analytics.logEvent(
      name: category,
      parameters: <String, dynamic>{
        "Action": action,
        "Label": eventName,
        "memberId": logCustomerId,
        "propertyId": propertyId
      },
    );
    // setMessage('logEvent succeeded');
    print('-------*--------*------- CATEGORY : $category, ACTION : $action, EVENT NAME : $eventName, CUSTOMER ID : $logCustomerId, PROPERTY ID :$propertyId');
  }
}

class Str {
  //action
  static const click = "click";
  static const load = "load";

  //category
  static const cLogin = "LOGIN";
  static const cSchedule = "SCHEDULE";
  static const cShortlist = "SHORTLIST";
  static const cPreferenceAdd = "PREFERENCE ADD";
  static const cPreferenceEdit = "PREFERENCE EDIT";
  static const cFeeds = "FEEDS";
  static const cChat = "CHAT";
  static const cCall = "CALL";
  static const cPropertyDetails = "PROPERTY DETAIL";

  // Label-  {category page},memberId,propertyId

  //LOGIN/SIGNUP
  static const lEnter_phoneNumber_Page = "enter_phoneNumber_page"; //done1
  static const lEnter_phoneNumber = "enter_phoneNumber"; //extra1
  static const lRequest_otp = "request_otp"; //no
  static const lOtp_fill_page = "otp_fill_page"; //done1
  static const lVerify_otp = "verify_otp"; //done1
  static const lWrong_otp_page = "wrong_otp_page"; //done1
  static const lLogged_successfully_page = "logged_successfully_page"; //done1
  static const lRequest_received_page = "request_received_page"; //no

  //  PREFERENCE ADD/EDIT
  static const lPreference_statement_page = "preference_statement_page"; //done2
  static const lPreferences_sent = "preferences_sent";//done2
  static const lPreferences_userType_dropdown = "preferences_userType_dropdown";//done2
  static const lPreferences_userType_page = "preferences_userType_page";//done2
  static const lPreferences_userType_selected = "preferences_userType_selected";//done2
  static const lPreferences_location_dropdown = "preferences_location_dropdown";//done2
  static const lPreferences_location_page = "preferences_location_page";//done2
  static const lPreferences_location_selected = "preferences_location_selected";//done2 2 full row & drop down both
  static const lPreferences_price_dropdown = "preferences_price_dropdown,";//done2
  static const lPreferences_price_page = "preferences_price_page";//done2
  static const lPreferences_price_selected = "preferences_price_selected";//done2 - on tap done
  static const lPreferences_bedroom_dropdown = "preferences_bedroom_dropdown";//done2
  static const lPreferences_bedroom_page = "preferences_bedroom_page";//done2
  static const lPreferences_bedroom_selected = "preferences_bedroom_selected";//done2
  static const lPreferences_propType_dropdown = "preferences_propType_dropdown";//done2
  static const lPreferences_propType_page = "preferences_propType_page";//done2
  static const lPreferences_propType_selected = "preferences_propType_selected";//done2 - buy tap
  static const lPreferences_category_dropdown = "preferences_category_dropdown";//done2
  static const lPreferences_category_page = "preferences_category_page";//done2 - buy page
  static const lPreferences_category_selected = "preferences_category_selected";//done2

  static const lWeb_view_page="web_view_page";//d2
  static const lWeb_view_page_back_button="web_view_page_back_button";//d2

  //FEEDS
  static const lWelcome_message_page = "welcome_message_page";//no
  static const lGetting_started_page = "getting_started_page";//no
  static const lVideo_played = "video_played"; // --pending
  static const lForYou_page = "forYou_page";//done2
  static const lExplore_page = "explore_page";//done2

  static const lSound_on_off="sound_on_off";//d2
  static const l360_view="360_view";//d3
  static const l360_view_page="360_view_page";//d3
  static const l360_view_page_back_button="360_view_page_back_button";//d3


  //PROPERTY DETAIL
  static const lProperty_detail = "property_detail";//done3
  static const lProperty_detail_page = "property_detail_page";//done3
  static const lProperty_detail_back_button = "property_detail_back_button";//done3

  //SCHEDULE
  static const lSchedule_page = "schedule_page"; //done3
  static const lPhysical_schedule = "physical_schedule"; //done3
  static const lSchedule_edit = "schedule_edit";//d3
  static const lSchedule_edit_done = "schedule_edit_done";//d3
  static const lVirtual_schedule = "virtual_schedule";     //no

  //SHORTLIST
  static const lProperty_shortlisted = "property_shortlisted";//done2
  static const lProperties_shortlisted_page = "properties_shortlisted_page";//done2

  //CHAT
  static const lChat_initiated = "chat_initiated";//done2
  static const lChat_box_page = "chat_box_page";//done2
  static const lChat_back_button = "chat_back_button";//done2
  static const lChat_view_page="chat_view_page";//d3
  static const lChat_view_page_back_button="chat_view_page_back_button";//d2
  static const lChat_view="chat_view";//d3

  //CALL
  static const lCall = "call";//done2
  static const lCall_page = "call_page"; //no

}
