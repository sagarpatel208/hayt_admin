import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hayt_admin/Common/AppServices.dart';
import 'package:hayt_admin/Common/Constants.dart' as cnst;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationToBuyer extends StatefulWidget {
  @override
  _NotificationToBuyerState createState() => _NotificationToBuyerState();
}

class _NotificationToBuyerState extends State<NotificationToBuyer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController edtName = new TextEditingController();

  TextEditingController edtDescription = new TextEditingController();
  String name = "";
  String Title;
  String bodymessage;
  ProgressDialog pr;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Please wait..");
    getLocal();
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

  getLocal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      name = "${pref.getString(cnst.Session.name)}";
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  _sendNotification() async {
    try {
      pr.show();
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //pr.show();

        FormData d = FormData.fromMap(
            {"title": edtName.text, "description": edtDescription.text});

        AppServices.SendNotificationToBuyer(d).then((data) async {
          pr.hide();
          if (data.data == "0") {
            Fluttertoast.showToast(
                msg: data.message,
                textColor: cnst.appPrimaryMaterialColor[700],
                backgroundColor: Colors.grey.shade100,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_SHORT);
            Navigator.pushReplacementNamed(context, '/NotificationToBuyer');
          } else {
            showMsg("Something went wrong.");
          }
        }, onError: (e) {
          pr.hide();
          showMsg("Something went wrong.");
        });
      }
    } on SocketException catch (_) {
      pr.hide();
      showMsg("No Internet Connection.");
    }
  }

  showMsg(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Hayt Admin"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Close",
                style: TextStyle(color: cnst.appPrimaryMaterialColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Notification to Buyer"),
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              _openDrawer();
            },
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                var list = List<PopupMenuEntry<Object>>();
                list.add(
                  PopupMenuItem(
                    child: Text("Settings"),
                    value: 1,
                  ),
                );
                return list;
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            )
          ],
        ),
        drawerEnableOpenDragGesture: false,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Padding(
                    padding: EdgeInsets.only(bottom: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/user.png",
                            height: 70,
                            width: 70,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            '${name.toUpperCase()}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                      cnst.appPrimaryMaterialColor,
                      cnst.appPrimaryMaterialColor[600]
                    ])),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/Shops');
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shop,
                            size: 23,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                "Shop",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/Services');
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.spa,
                            size: 23,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                "Services",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/Products');
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.spa,
                            size: 23,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                "Products",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/Feeds');
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.feedback,
                            size: 23,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                "Feeds",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/VIP');
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.verified_user,
                            size: 23,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                "VIP",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/ApproveShops');
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            //Icons.speaker_notes,
                            Icons.shop_two,
                            size: 23,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                "Approve Shops",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/ApproveServices');
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.class_,
                            size: 23,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                "Approve Services",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/ApproveProducts');
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.class_,
                            size: 23,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                "Approve Products",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/Category');
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.chrome_reader_mode,
                            size: 23,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                "Category",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/ChatWithBuyer');
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.chat_bubble,
                            size: 23,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                "Chat with Buyer",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/ChatWithSeller');
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.chat,
                            size: 23,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                "Chat with Seller",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/NotificationToBuyer');
                    },
                    child: Container(
                      color: cnst.appPrimaryMaterialColor[200],
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.notification_important,
                              size: 23,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Text(
                                  "Send Notification to Buyer",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _logout();
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.power_settings_new,
                            size: 23,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                "Logout",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text("Title"),
                        ),
                        TextFormField(
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          scrollPadding: EdgeInsets.all(0),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                          cursorColor: cnst.appPrimaryMaterialColor,
                          controller: edtName,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                            hintText: "Title",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text("Description"),
                        ),
                        TextFormField(
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          scrollPadding: EdgeInsets.all(0),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                          cursorColor: cnst.appPrimaryMaterialColor,
                          controller: edtDescription,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                            hintText: "Description",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                MaterialButton(
                  elevation: 5.0,
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width,
                  color: cnst.appPrimaryMaterialColor,
                  child: new Text('SEND NOTIFICATION',
                      style:
                          new TextStyle(fontSize: 16.0, color: Colors.white)),
                  onPressed: () {
                    if (edtName.text == "") {
                      Fluttertoast.showToast(
                          msg: "Please enter Notification Title",
                          textColor: Colors.white,
                          backgroundColor: cnst.appPrimaryMaterialColor,
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_SHORT);
                    } else if (edtDescription.text == null) {
                      Fluttertoast.showToast(
                          msg: "Please enter Notification Description",
                          textColor: Colors.white,
                          backgroundColor: cnst.appPrimaryMaterialColor,
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_SHORT);
                    } else {
                      _sendNotification();
                    }
                    //  showNotification("Sagar", "Patel");
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
