import 'dart:convert';
import 'dart:io';

import 'package:com.propacy.b2c/model/post_preference_model.dart';
import 'package:com.propacy.b2c/rest_api/get_preference_api.dart';
import 'package:com.propacy.b2c/rest_api/login_api.dart';
import 'package:com.propacy.b2c/screen/authorization/enter_mobile_screen.dart';
import 'package:com.propacy.b2c/screen/demo.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_screen.dart';
import 'package:com.propacy.b2c/screen/inter_selection/inter_selection_view_model.dart';
import 'package:com.propacy.b2c/screen/login_successfull_screen/login_successfull.dart';
import 'package:com.propacy.b2c/screen/personal_property_details/personal_property_details_screen.dart';
import 'package:com.propacy.b2c/screen/property_details/property_details_screen.dart';
import 'package:com.propacy.b2c/screen/shortlist/shortlist_screen.dart';
import 'package:com.propacy.b2c/screen/splash/splash_screen.dart';
import 'package:com.propacy.b2c/screen/vidio_home_screeen/show_vidio_screen.dart';
import 'package:com.propacy.b2c/screen/vidio_splash/vidio_splash_screen.dart';
import 'package:com.propacy.b2c/services/sharedpreference.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() {
    print("compleye");
  });
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  String? token = await FirebaseAppCheck.instance.getToken();
  print(token);
  String? token1 = await FirebaseAppCheck.instance.getToken(true);
  FirebaseAppCheck.instance.onTokenChange.listen((token2) {
    print(token2);
  });
  await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  firebaseMessaging();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

class _MyAppState extends State<MyApp> {
  //PostPreferenceModel? postPreferenceModelData;

  var isLogin;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen());
  }
}

Future<void> firebaseMessaging() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin!.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    print("onSelectNotification Called");
    //Get.to(() => ReadMsgScreen(message.notification!.body));
    //Get.to(() => ReadMsgScreen("hello"));
  });

  await flutterLocalNotificationsPlugin!
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel!);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification notification = message.notification!;
    flutterLocalNotificationsPlugin!.show(
      notification != null ? notification.hashCode : 0,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel!.id,
          channel!.name,
          channel!.description,
          icon: '@mipmap/ic_launcher',

          /*styleInformation: BigPictureStyleInformation(
            FilePathAndroidBitmap(imagePath),
            hideExpandedLargeIcon: false,
          ),*/
        ),
      ),
    );
    print("onMessage Called");
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print("onMessageOpenedApp Called ");
    //Navigator.push(context, MaterialPageRoute(builder: (context) => ReadMsgScreen(message.notification!.body)));
    // Get.to(() => ReadMsgScreen(message.notification!.body));
  });

  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? message) async {
    print("getInitialMessage Called ");
    if (message != null) {
      //Get.to(() => ReadMsgScreen(message.notification!.body));
    }
  });
}

Future onDidReceiveLocalNotification(
  int? id,
  String? title,
  String? body,
  String? payload,
) async {
  print("iOS notification $title $body $payload");
}
