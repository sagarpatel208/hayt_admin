import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hayt_admin/Common/Constants.dart' as cnst;
import 'package:hayt_admin/Screens/AddCategory.dart';
import 'package:hayt_admin/Screens/ApproveFeeds.dart';
import 'package:hayt_admin/Screens/ApproveProducts.dart';
import 'package:hayt_admin/Screens/ApproveServices.dart';
import 'package:hayt_admin/Screens/ApproveShops.dart';
import 'package:hayt_admin/Screens/Category.dart';
import 'package:hayt_admin/Screens/ChatWithBuyer.dart';
import 'package:hayt_admin/Screens/ChatWithSeller.dart';
import 'package:hayt_admin/Screens/Feeds.dart';
import 'package:hayt_admin/Screens/Login.dart';
import 'package:hayt_admin/Screens/NotificationToBuyer.dart';
import 'package:hayt_admin/Screens/Products.dart';
import 'package:hayt_admin/Screens/Services.dart';
import 'package:hayt_admin/Screens/Shops.dart';
import 'package:hayt_admin/Screens/VIP.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  StreamSubscription iosSubscription;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String Title;
  String bodymessage;
  @override
  void initState() {
    // TODO: implement initState

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        Title = message["notification"]["title"];
        bodymessage = message["notification"]["body"];
        //Get.to(OverlayScreen(message))
        print("onMessage  $message");
        showNotification('$Title', '$bodymessage');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings);
    print("1");
  }

  showNotification(String title, String body) async {
    var android = new AndroidNotificationDetails('com.hayt_admin',
        'Hayt Admin Notification', 'Hayt Notification Description',
        priority: Priority.High, importance: Importance.Max, playSound: true);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(0, '$title', '$body', platform);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HAYT Admin",
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/VIP': (context) => VIP(),
        '/Shops': (context) => Shops(),
        '/ApproveServices': (context) => ApproveServices(),
        '/Category': (context) => Category(),
        '/ChatWithBuyer': (context) => ChatWithBuyer(),
        '/ChatWithSeller': (context) => ChatWithSeller(),
        '/ApproveShops': (context) => ApproveShops(),
        '/AddCategory': (context) => AddCategory(),
        '/Products': (context) => Products(),
        '/Services': (context) => Services(),
        '/ApproveProducts': (context) => ApproveProducts(),
        '/ApproveFeeds': (context) => ApproveFeeds(),
        '/Feeds': (context) => Feeds(),
        '/NotificationToBuyer': (context) => NotificationToBuyer(),
      },
      theme: ThemeData(
          fontFamily: 'Montserrat',
          primarySwatch: cnst.appPrimaryMaterialColor,
          accentColor: cnst.appPrimaryMaterialColor,
          buttonColor: cnst.appPrimaryMaterialColor),
    );
  }
}
