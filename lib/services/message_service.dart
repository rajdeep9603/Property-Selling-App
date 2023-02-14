import 'dart:convert';

import 'package:com.propacy.b2c/model/chat_model/notification_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class MessageService {
  FirebaseMessaging message = FirebaseMessaging.instance;
  static const String serverToken =
      'AAAALymiWTU:APA91bF2YE6mi7XqNYE0tP2R9b9270T1xsAL1xEKNQaLTcGVZ_y3n80dPzNeYBWC_3vmjcuRzLS4b6rXHjkV7jQ95ch5KymkLwRIR_v1MVrLVExej6viFVE8XVWJIOIsd5GJNKfVp7rN';

  Future<String?> getFcmTokne() async {
    return await message.getToken();
  }

  void sendNotification(SendNotificationModel notification) async {
    print("token = ${notification.fcmTokens}");
    http.Response response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(notification.toMap()),
    );
    print(response.statusCode);
    print(response.body);
  }
}
