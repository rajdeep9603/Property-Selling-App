import 'package:com.propacy.b2c/model/chat_model/message_model.dart';
import 'package:com.propacy.b2c/model/chat_model/user_model.dart';
import 'package:com.propacy.b2c/utils/global%20variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Map> dataList = [];

class ChatService {
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static Future<void> getCurrentUserUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      userUid = auth.currentUser!.uid;
    }
  }

  static Future<String?> getChatId(String uid) async {
    DatabaseReference ref1 = database.ref(uid + userUid);
    DatabaseReference ref2 = database.ref(userUid + uid);

    DatabaseEvent snap1 = await ref1.once();
    DatabaseEvent snap2 = await ref2.once();

    if (snap1.snapshot.exists) {
      return uid + userUid;
    } else if (snap2.snapshot.exists) {
      return userUid + uid;
    }
  }

  static Future<bool> sendMessage(MessageModel msgModel, String chatId) async {
    try {
      await database.ref(chatId).push().set(msgModel.textJson());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> setUserDetail(
      List<UserDetail> chatUsers, String chatID) async {
    try {
      // await database.ref(chatID).child('userDetails').set(chatUsers);
      await database.ref(chatID).child('userDetails').child("0").set(
          {"userId": chatUsers[0].userId, "userName": chatUsers[0].userName});
      await database.ref(chatID).child('userDetails').child("1").set(
          {"userId": chatUsers[1].userId, "userName": chatUsers[1].userName});
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Stream<DatabaseEvent> getMessageStream(String chatId) {
    return database.ref().child(chatId).orderByChild('timestamp').onValue;
  }

  static List<MessageModel> getMessageList(DataSnapshot data) {
    try {
      List<MessageModel> msgList = [];
      Map map = data.value as Map;
      List<Map<String, dynamic>> list = [];

      map.forEach((key, value) {
        list.add({'key': key, ...value});
      });

      list.forEach((element) {
        msgList.add(MessageModel.fromJson(element));
      });
      return msgList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static bool isNewMessage(Map userData, String user2Id) {
    if (userData['chatUsers'] == null) {
      return false;
    }
    Map chatUser = userData['chatUsers'];
    List<Map> item = [];
    chatUser.forEach((index, data) {
      item.add({"key": index, ...data});
    });
    int index = 0;

    for (int i = 0; i < item.length; i++) {
      if (item[i]['messageCollectionId'].toString().contains(user2Id)) {
        index = i;
        break;
      }
    }
    if (item[index]['unReadMessage'] == 'Y') {
      return true;
    } else {
      return false;
    }
  }

  static String getLastMessageTime(Map userData, String user2Id) {
    if (userData['chatUsers'] == null) {
      return "";
    }
    Map chatUser = userData['chatUsers'];
    List<Map> item = [];
    chatUser.forEach((index, data) {
      item.add({"key": index, ...data});
    });
    int index = 0;

    for (int i = 0; i < item.length; i++) {
      if (item[i]['messageCollectionId'].toString().contains(user2Id)) {
        index = i;
        break;
      }
    }
    return item[index]['lastModified'];
  }

  static String getLastMessage(Map userData, String user2Id) {
    String lastmsg="";
    if (userData['chatUsers'] == null) {
      return "";
    }
    Map chatUser = userData['chatUsers'];
    List<Map> item = [];
    chatUser.forEach((index, data) {
      item.add({"key": index, ...data});
    });
    int index = 0;

    for (int i = 0; i < item.length; i++) {
      if (item[i]['messageCollectionId'].toString().contains(user2Id)) {
        lastmsg=item[i]['lastMessage'];
        index = i;
        break;
      }
    }
    return lastmsg;
  }

  static String getfcmToken(Map userData, String user2Id) {
    if (userData['chatUsers'] == null) {
      return "";
    }
    Map chatUser = userData['chatUsers'];
    List<Map> item = [];
    chatUser.forEach((index, data) {
      item.add({"key": index, ...data});
    });
    int index = 0;

    for (int i = 0; i < item.length; i++) {
      if (item[i]['messageCollectionId'].toString().contains(user2Id)) {
        index = i;
        break;
      }
    }
    return item[index]['fcmToken'];
  }

  static Future<void> setUser(String deviceToken) async {
    bool flag = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var uId = prefs.getString("userId");
      print(uId);
      DatabaseEvent db = await database.ref('users').child(uId!).once();
      flag = db.snapshot.exists;
      if (flag == false) {
        var phoneNumber = prefs.getString("userMobile");
        var fcmToken = prefs.getString("deviceToken");
        print("deviceToken");
        print(fcmToken);
        UserModel userModel = UserModel();
        userModel = UserModel(
            avatar: "https://cdnacy.com/common/images/default-avatar.jpg",
            deviceToken: deviceToken,
            name: phoneNumber.toString().replaceRange(2, 7, "*****"),
            phone: phoneNumber.toString(),
            status: "online");
        var userId = prefs.getString("userId");
        await database.ref('users').child(userId!).set(userModel.toJson());
      }
      else if(flag==true){
        var userId = prefs.getString("userId");
        await database.ref('users').child(userId!).update({
          "deviceToken":deviceToken
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static void setChatUser(String anotherUid, String mono, String name,
      String chatId, String lastmessage, String peerTyp) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString("userId");
      var fcmToken = prefs.getString("deviceToken");
      List<UserDetail> userdetails = [];
      userdetails.add(UserDetail(userId: userId, userName: mono));
      userdetails.add(UserDetail(userId: anotherUid, userName: name));
      print(fcmToken);
      ChatUsers chatUsers = ChatUsers(
        fcmToken: fcmToken,
        lastModified: DateFormat('dd/MM/yyyy, kk:mm')
            .format(DateTime.now())
            .toString(),
        messageCollectionId: chatId,
        peerMemberType: peerTyp,
        pushNotification: "N",
        unReadMessage: "N",
        lastMessage: lastmessage,
        userDetails: userdetails,
      );

      await database
          .ref('users')
          .child(userUid)
          .child('chatUsers')
          .push()
          .set(chatUsers.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  static void updateChatUser(String anotherUid, String mono, String name,
      String chatId, String lastmessage) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString("userId");
      var fcmToken = prefs.getString("deviceToken");
      List<UserDetail> userdetails = [];
      userdetails.add(UserDetail(userId: userUid, userName: mono));
      userdetails.add(UserDetail(userId: anotherUid, userName: name));
      print(fcmToken);
      ChatUsers chatUsers = ChatUsers(
        fcmToken: fcmToken,
        lastModified: DateFormat('dd/MM/yyyy, kk:mm')
            .format(DateTime.now())
            .toString(),
        messageCollectionId: chatId,
        peerMemberType: "CT",
        pushNotification: "N",
        unReadMessage: "N",
        lastMessage: lastmessage,
        userDetails: userdetails,
      );
      await database
          .ref('users')
          .child(anotherUid)
          .child('chatUsers')
          .push()
          .set(chatUsers.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  static void updateValues(
      String uid, String chatId, String lastmessage,String fcmToken) async {
    List key = [];
    List<Map> item = [];
    await ChatService.database.ref('users').child(uid).get().then((value) {
      Map map = value.value as Map;
      print(map['chatUsers']);
      Map data = map['chatUsers'];
      data.forEach((index, data) {
        item.add({"key": index, ...data});
        key.add(index);
      });
      print(item);
    });
    for (int i = 0; i < item.length; i++) {
      if (item[i]['messageCollectionId'] == chatId) {
        database
            .ref('users')
            .child(uid)
            .child('chatUsers')
            .child(item[i]['key'])
            .update({
          "fcmToken":fcmToken,
          "lastModified": DateFormat('dd/MM/yyyy, kk:mm')
              .format(DateTime.now())
              .toString(),
          "unReadMessage": "Y",
          "lastMessage": lastmessage
        });
        break;
      }
    }
    print(key);
  }

  static void updateCurrentUserValues(
      String uid, String chatId, String lastmessage,String fcmToken) async {
    print("updateCurrentuserValues");
    List key1 = [];
    List<Map> item1 = [];
    await ChatService.database.ref('users').child(userUid).get().then((value) {
      Map map = value.value as Map;
      print(map['chatUsers']);
      if (map['chatUsers'] != "") {
        Map data = map['chatUsers'];
        data.forEach((index, data) {
          item1.add({"key": index, ...data});
          key1.add(index);
        });
        print(item1);
      }
    });
    for (int i = 0; i < item1.length; i++) {
      if (item1[i]['messageCollectionId'] == chatId) {
        database
            .ref('users')
            .child(userUid)
            .child('chatUsers')
            .child(item1[i]['key'])
            .update({
          "fcmToken":fcmToken,
          "lastModified": DateFormat('dd/MM/yyyy, kk:mm')
              .format(DateTime.now())
              .toString(),
          "unReadMessage": "Y",
          "lastMessage": lastmessage
        });
        break;
      }
    }
    print(key1);
  }

  static bool getName(Map userData, String user2Id) {
    if (userData['chatUsers'] == null) {
      return false;
    }
    Map chatUser = userData['chatUsers'];
    List<Map> item = [];
    chatUser.forEach((index, data) {
      item.add({"key": index, ...data});
    });
    int index = 0;
    for (int i = 0; i < item.length; i++) {
      if (item[i]['messageCollectionId'].toString().contains(userUid)) {
        index = i;
        return true;
      }
    }
    return false;
  }
}
