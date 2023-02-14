class SendNotificationModel {
  String? id;
  String? roomId;
  String? title;
  String? body;
  String? fcmToken;
  List<String>? fcmTokens;
  String? roomName;
  String? userName;

  SendNotificationModel({
    this.roomId,
    this.title,
    this.body,
    this.id,
    this.fcmToken,
    this.fcmTokens,
    this.roomName,
    this.userName,
  });

  Map<String, dynamic> toMap() => {
        "${fcmToken == null ? "registration_ids" : "to"}":
            fcmToken == null ? fcmTokens : fcmToken,
        "data": {
          "id": id,
          "roomId": roomId,
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "sound": "default",
          "room_name": roomName,
          "userName": userName,
        },
        "priority": "high",
        "notification": {
          "title": title,
          "body": body,
          "room_name": roomName,
        }
      };
}
