// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.avatar,
    this.chatUsers,
    this.deviceToken,
    this.memberType,
    this.name,
    this.phone,
    this.status,
  });

  String? avatar;
  ChatUsers? chatUsers;
  String? deviceToken;
  String? memberType;
  String? name;
  String? phone;
  String? status;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        avatar: json["avatar"],
        chatUsers: ChatUsers.fromJson(json["chatUsers"]),
        deviceToken: json["deviceToken"],
        memberType: json["memberType"],
        name: json["name"],
        phone: json["phone"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        //"chatUsers": chatUsers == null ? "" : chatUsers!.toJson(),
        "deviceToken": deviceToken,
        //"memberType": memberType,
        "name": name,
        "phone": phone,
        "status": status,
      };
}

// To parse this JSON data, do
//
//     final chatUsers = chatUsersFromJson(jsonString);

ChatUsers chatUsersFromJson(String str) => ChatUsers.fromJson(json.decode(str));

String chatUsersToJson(ChatUsers data) => json.encode(data.toJson());

class ChatUsers {
  ChatUsers(
      {this.fcmToken,
      this.lastModified,
      this.messageCollectionId,
      this.peerMemberType,
      this.pushNotification,
      this.unReadMessage,
      this.userDetails,
      this.lastMessage});

  String? fcmToken;
  String? lastModified;
  String? messageCollectionId;
  String? peerMemberType;
  String? pushNotification;
  String? unReadMessage;
  String? lastMessage;
  List<UserDetail>? userDetails;

  factory ChatUsers.fromJson(Map<String, dynamic> json) => ChatUsers(
        fcmToken: json["fcmToken"],
        lastModified: json["lastModified"],
        messageCollectionId: json["messageCollectionId"],
        peerMemberType: json["peerMemberType"],
        pushNotification: json["pushNotification"],
        unReadMessage: json["unReadMessage"],
        lastMessage: json['lastMessage'],
        userDetails: List<UserDetail>.from(
            json["userDetails"].map((x) => UserDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fcmToken": fcmToken,
        "lastModified": lastModified,
        "messageCollectionId": messageCollectionId,
        "peerMemberType": peerMemberType,
        "pushNotification": pushNotification,
        "unReadMessage": unReadMessage,
        "lastMessage": lastMessage,
        "userDetails": List<dynamic>.from(userDetails!.map((x) => x.toJson())),
      };
}

class UserDetail {
  UserDetail({
    this.userId,
    this.userName,
  });

  String? userId;
  String? userName;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        userId: json["userId"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
      };
}
