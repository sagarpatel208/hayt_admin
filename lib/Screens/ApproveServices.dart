import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hayt_admin/Common/AppServices.dart';
import 'package:hayt_admin/Common/Constants.dart' as cnst;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApproveServices extends StatefulWidget {
  @override
  _ApproveServicesState createState() => _ApproveServicesState();
}

class _ApproveServicesState extends State<ApproveServices> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String name = "";
  List _services = [];
  bool isLoading = true;

  @override
  void initState() {
    getLocal();
    getAllServices();
  }

  getAllServices() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        AppServices.GetAllServices({}).then((data) async {
          if (data.data == "0") {
            setState(() {
              isLoading = false;
              //_services = data.value;
            });
            List shop = data.value;
            for (int i = 0; i < shop.length; i++) {
              if (shop[i]["status"] == "1") {
                _services.add(shop[i]);
              }
            }
          } else {
            setState(() {
              isLoading = false;
              _services.clear();
            });
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
            _services.clear();
          });
          showMsg("Something went wrong.");
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isLoading = false;
        _services.clear();
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Approve Services"),
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
                    Navigator.pushReplacementNamed(context, '/ApproveServices');
                  },
                  child: Container(
                    color: cnst.appPrimaryMaterialColor[200],
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
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/ApproveProducts');
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
                    Navigator.pushReplacementNamed(context, '/ChatWithSeller');
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
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 10),
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _services.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: _services.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ApproveServiceComponents(_services[index]);
                  })
              : Center(
                  child: Text("No shops available",
                      style: TextStyle(fontSize: 20, color: Colors.black54)),
                ),
    );
  }
}

class ApproveServiceComponents extends StatefulWidget {
  var _approveService;

  ApproveServiceComponents(this._approveService);

  @override
  _ApproveServiceComponentsState createState() =>
      _ApproveServiceComponentsState();
}

class _ApproveServiceComponentsState extends State<ApproveServiceComponents> {
  ProgressDialog pr;
  @override
  void initState() {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Please wait..");
  }

  _declinedService() async {
    try {
      pr.show();
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData data = FormData.fromMap({"status": "0"});
        AppServices.UpdateServiceStatus(widget._approveService["id"], data)
            .then((data) async {
          pr.hide();
          if (data.data == "0") {
            Fluttertoast.showToast(
                msg: "Service declined successfully",
                textColor: cnst.appPrimaryMaterialColor[700],
                backgroundColor: Colors.grey.shade100,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_SHORT);
            Navigator.pushReplacementNamed(context, '/ApproveServices');
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
    _removeVIPService();
  }

  _removeVIPService() async {
    try {
      pr.show();
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData data = FormData.fromMap({"vipstatus": "0"});
        AppServices.MakeVIPService(widget._approveService["id"], data).then(
            (data) async {
          pr.hide();
          if (data.data == "0") {
            Fluttertoast.showToast(
                msg: "Service is no more VIP",
                textColor: cnst.appPrimaryMaterialColor[700],
                backgroundColor: Colors.grey.shade100,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_SHORT);
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          widget._approveService["picture"] == null ||
                  widget._approveService["picture"] == "" ||
                  widget._approveService["picture"].length == 0 ||
                  widget._approveService["picture"]["images"].length == 0 ||
                  widget._approveService["picture"]["images"] == null
              ? Image.asset(
                  "assets/background.png",
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                )
              : FadeInImage.assetNetwork(
                  placeholder: "assets/background.png",
                  image: widget._approveService["picture"]["images"][0],
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade300,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${widget._approveService["name"]}"),
                      MaterialButton(
                        elevation: 5.0,
                        height: 40,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: new Text('DECLINE',
                              style: new TextStyle(
                                  fontSize: 16.0, color: Colors.black)),
                        ),
                        onPressed: () {
                          _declinedService();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child:
                              Text("${widget._approveService["description"]}")),
                      Text("${widget._approveService["placeofservice"]}"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
