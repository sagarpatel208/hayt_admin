import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hayt_admin/Common/AppServices.dart';
import 'package:hayt_admin/Common/Constants.dart' as cnst;
import 'package:hayt_admin/Screens/FeedsComments.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Feeds extends StatefulWidget {
  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  DateTime currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String name = "";
  List _feeds = [];
  bool isLoading = true;
  @override
  void initState() {
    getLocal();
    getAllFeeds();
  }

  getAllFeeds() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String id = prefs.getString(cnst.Session.id);
        AppServices.GetAllFeeds(id, {}).then((data) async {
          if (data.data == "0") {
            setState(() {
              isLoading = false;
              //_feeds = data.value;
            });
            List shop = data.value;
            for (int i = 0; i < shop.length; i++) {
              if (shop[i]["status"] == "1") {
                _feeds.add(shop[i]);
              }
            }
          } else {
            setState(() {
              isLoading = false;
              _feeds.clear();
            });
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
            _feeds.clear();
          });
          showMsg("Something went wrong.");
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isLoading = false;
        _feeds.clear();
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
        title: Text("Feeds"),
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
                  child: Container(
                    color: cnst.appPrimaryMaterialColor[200],
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
          : _feeds.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: _feeds.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FeedsComponents(_feeds[index]);
                  })
              : Center(
                  child: Text("No feeds available",
                      style: TextStyle(fontSize: 20, color: Colors.black54)),
                ),
    );
  }
}

class FeedsComponents extends StatefulWidget {
  var _feeds;
  FeedsComponents(this._feeds);
  @override
  _FeedsComponentsState createState() => _FeedsComponentsState();
}

class _FeedsComponentsState extends State<FeedsComponents> {
  ProgressDialog pr;
  @override
  void initState() {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Please wait..");
  }

  addFollow() async {
    try {
      pr.show();
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String id = prefs.getString(cnst.Session.id);
        FormData data = FormData.fromMap({
          "sellerid": widget._feeds["sellerid"],
          "status": "0",
          "userid": id
        });
        AppServices.AddFollow(data).then((data) async {
          pr.hide();
          if (data.data == "0") {
            setState(() {
              widget._feeds["isFollow"] = "1";
            });
            Fluttertoast.showToast(
                msg: "Follow successfully",
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

  deleteFollow() async {
    try {
      pr.show();
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData data = FormData.fromMap({});
        print("id: ${widget._feeds["followid"]}");
        AppServices.DeleteFollow(widget._feeds["followid"], data).then(
            (data) async {
          pr.hide();
          if (data.data == "0") {
            setState(() {
              widget._feeds["isFollow"] = "0";
            });
            Fluttertoast.showToast(
                msg: "Unfollow successfully",
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

  addLike() async {
    try {
      pr.show();
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String id = prefs.getString(cnst.Session.id);
        FormData data =
            FormData.fromMap({"userid": id, "feedid": widget._feeds["id"]});
        AppServices.GiveFeedLike(data).then((data) async {
          pr.hide();
          if (data.data == "0") {
            setState(() {
              widget._feeds["isLike"] = "1";
              widget._feeds["total_likes"] =
                  (int.parse(widget._feeds["total_likes"]) + 1).toString();
            });
            Fluttertoast.showToast(
                msg: "Like give",
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

  removeLike() async {
    try {
      pr.show();
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String id = prefs.getString(cnst.Session.id);
        FormData data =
            FormData.fromMap({"userid": id, "feedid": widget._feeds["id"]});
        AppServices.RemoveFeedLike(data).then((data) async {
          pr.hide();
          if (data.data == "0") {
            setState(() {
              widget._feeds["isLike"] = "0";
              widget._feeds["total_likes"] =
                  (int.parse(widget._feeds["total_likes"]) - 1).toString();
            });
            Fluttertoast.showToast(
                msg: "Like removed",
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

  _deleteFeed() async {
    try {
      pr.show();
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData data = FormData.fromMap({"status": "0"});
        AppServices.UpdateFeedStatus(widget._feeds["id"], data).then(
            (data) async {
          pr.hide();
          if (data.data == "0") {
            Fluttertoast.showToast(
                msg: "Feeds deleted",
                textColor: cnst.appPrimaryMaterialColor[700],
                backgroundColor: Colors.grey.shade100,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_SHORT);
            Navigator.pushReplacementNamed(context, '/Feeds');
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
          widget._feeds["image"] == "" || widget._feeds["image"] == null
              ? Image.asset(
                  "assets/background.png",
                  height: 210,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                )
              : FadeInImage.assetNetwork(
                  placeholder: "assets/background.png",
                  image: widget._feeds["image"],
                  height: 210,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade300,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget._feeds["shopname"] == null ||
                                widget._feeds["shopname"] == ""
                            ? "Shopname"
                            : widget._feeds["shopname"],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      MaterialButton(
                        elevation: 5.0,
                        height: 40,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: new Text('DELETE',
                              style: new TextStyle(
                                  fontSize: 16.0, color: Colors.black)),
                        ),
                        onPressed: () {
                          _deleteFeed();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("${widget._feeds["description"]}"),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          widget._feeds["isLike"] == "1"
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget._feeds["isLike"] == "1"
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () {
                          if (widget._feeds["isLike"] == "1") {
                            removeLike();
                          } else {
                            addLike();
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.comment),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FeedsComments(widget._feeds["id"], () {
                                        setState(() {
                                          widget._feeds["total_comments"] =
                                              int.parse(widget._feeds[
                                                      "total_comments"]) +
                                                  1;
                                        });
                                      })));
                        },
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "${widget._feeds["total_likes"]} likes",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 5, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FeedsComments(widget._feeds["id"], () {
                                      setState(() {
                                        widget._feeds["total_comments"] =
                                            int.parse(widget
                                                    ._feeds["total_comments"]
                                                    .toString()) +
                                                1;
                                      });
                                    })));
                      },
                      child: Text(
                        "View All ${widget._feeds["total_comments"]} Comments",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ),
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
