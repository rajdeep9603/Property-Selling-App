import 'package:com.propacy.b2c/screen/chat/chat_screen/chat_screen.dart';
import 'package:com.propacy.b2c/services/chat_service/chat_service.dart';
import 'package:com.propacy.b2c/utils/analytics_function.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
List item1=[];
List key=[];
bool flag = false;

class ChatHomePageViewModel extends BaseViewModel {
  final userRef = FirebaseDatabase.instance.ref().child('users');
  List phone=[];
  List avatar=[];
  List item = [];
  List key = [];
  bool loader=true;
  bool isLoad=true;

  Future<void> init() async {
    FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cChat, Str.load, Str.lChat_initiated);
    await getCurrentUser();
   await createUserCollection();
   Future.delayed(Duration(seconds: 1),(){
     loader=false;
     notifyListeners();
   });

  }

  Future<void> getCurrentUser() async {

    if (userUid == '') {
      await ChatService.getCurrentUserUid();
      print("userUid");
      print(userUid);
    }
 await  ChatService.database
        .ref('users')
        .child(userUid)
        .child('chatUsers')
        .once()
        .then((value) {
      item=[];
      flag = value.snapshot.exists;
      Map data= value.snapshot.value as Map;
      data.forEach((index,data) {
        item.add({"key": index,...data});
        key.add(index);
      });
      print(item);
      notifyListeners();
    });
    item=item.toSet().toList();
    item.forEach((element) async{
      await ChatService.database.ref('users').child(element['userDetails'][1]['userId']).once().then((value){
        Map data= value.snapshot.value as Map;
        avatar.add(data['avatar'].toString());
        phone.add(data['phone'].toString());
      });
      
    });
  }

  void onBackBtnTap() {
    FirebaseAnalyticsService.sendAnalyticsEvent2(Str.cChat, Str.click, Str. lChat_back_button);
    Get.back();
  }

  void onUserTap(String uid, String name, String fcmToken,String phone) {
    Get.to(() => ChatScreen(
          uid: uid,
          name: name,
          fcmToken: fcmToken,
          anpotherPhone:phone,
      peerType: "",
        ));
  }

  Future<void> createUserCollection() async {
    DatabaseEvent event = await ChatService.database.ref(userUid).once();
    bool available = event.snapshot.exists;

    if (available == false) {
      ///TODO: create new collection of user
    }
  }
}
