import 'dart:async';
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

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController edtUsername = new TextEditingController();
  TextEditingController edtPassword = new TextEditingController();
  ProgressDialog pr;
  StreamSubscription iosSubscription;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String fcm = "";
  @override
  void initState() {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Please wait..");
    _configureNotification();
  }

  _configureNotification() async {
    if (Platform.isIOS) {
      iosSubscription =
          _firebaseMessaging.onIosSettingsRegistered.listen((data) async {
        await _getFCMToken();
      });
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    } else {
      await _getFCMToken();
    }
  }

  _getFCMToken() {
    _firebaseMessaging.getToken().then((String token) {
      setState(() {
        fcm = token;
      });
      print("fcm: ${token}");
    });
    getLocal();
  }

  getLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString(cnst.Session.id);
    print("id: ${id}");
    if (id != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/Shops', (Route<dynamic> route) => false);
    }
  }

  _login() {
    print("fcm token: ${fcm}");
    if (edtUsername.text == "") {
      Fluttertoast.showToast(
          msg: "Please enter your username",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else if (edtPassword.text == "") {
      Fluttertoast.showToast(
          msg: "Please enter Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey.shade300,
          textColor: Colors.black,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else {
      _adminLogin();
    }
  }

  _adminLogin() async {
    try {
      pr.show();
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData d = FormData.fromMap({
          "username": edtUsername.text,
          "password": edtPassword.text,
          "fcm_token": fcm
        });
        AppServices.AdminLogin(d).then((data) async {
          pr.hide();
          if (data.data == "0") {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString(cnst.Session.id, data.value[0]["id"]);
            prefs.setString(cnst.Session.name, data.value[0]["name"]);
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/Shops', (Route<dynamic> route) => false);
          } else {
            Fluttertoast.showToast(
                msg: "Invalid username or password",
                textColor: cnst.appPrimaryMaterialColor[700],
                backgroundColor: Colors.grey.shade100,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_SHORT);
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
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              textAlign: TextAlign.start,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
              cursorColor: cnst.appPrimaryMaterialColor,
              controller: edtUsername,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                //filled: true,
                //fillColor: Colors.grey.withOpacity(0.1),
                hintText: "Username",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade100, width: 0.1),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              obscureText: true,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
              cursorColor: cnst.appPrimaryMaterialColor,
              controller: edtPassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                //filled: true,
                //fillColor: Colors.grey.withOpacity(0.1),
                hintText: "Password",
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade100, width: 0.1),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 20),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              elevation: 5.0,
              height: 50,
              minWidth: MediaQuery.of(context).size.width,
              color: cnst.appPrimaryMaterialColor,
              child: new Text('LOGIN',
                  style: new TextStyle(fontSize: 16.0, color: Colors.white)),
              onPressed: () {
                _login();
              },
            ),
          ],
        ),
      ),
    ));
  }
}
