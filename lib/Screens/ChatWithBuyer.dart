import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hayt_admin/Common/AppServices.dart';
import 'package:hayt_admin/Common/Constants.dart' as cnst;
import 'package:hayt_admin/Screens/ConversationWithBuyer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatWithBuyer extends StatefulWidget {
  @override
  _ChatWithBuyerState createState() => _ChatWithBuyerState();
}

class _ChatWithBuyerState extends State<ChatWithBuyer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String adminId = "", name = "";
  List _chatlist = [];
  bool isLoading = true;
  @override
  void initState() {
    getLocal();
    _getBuyertoAdminChat();
  }

  _getBuyertoAdminChat() async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //pr.show();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String id = prefs.getString(cnst.Session.id);
        FormData data = FormData.fromMap({"adminid": id});
        print("iiii: ${id}");
        AppServices.GetUsersToAdminChatList(data).then((data) async {
          setState(() {
            isLoading = false;
          });
          if (data.data == "0") {
            setState(() {
              _chatlist = data.value;
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });

          showMsg("Something went wrong.");
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isLoading = false;
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
      adminId = pref.getString(cnst.Session.id);
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
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
        title: Text("Chat with Buyer"),
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
                  child: Container(
                    color: cnst.appPrimaryMaterialColor[200],
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
          : _chatlist.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: _chatlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return UserChatListComponents(adminId, _chatlist[index]);
                  })
              : Center(
                  child: Text(
                  "No Chats available",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                )),
    );
  }
}

class UserChatListComponents extends StatefulWidget {
  String _adminId;
  var _buyer;
  UserChatListComponents(this._adminId, this._buyer);
  @override
  _UserChatListComponentsState createState() => _UserChatListComponentsState();
}

class _UserChatListComponentsState extends State<UserChatListComponents> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ConversationWithBuyer(
                        widget._adminId,
                        widget._buyer["id"].toString(),
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              widget._buyer['logo'] == null || widget._buyer['logo'] == ""
                  ? ClipOval(
                      child: Image.asset("assets/user.png",
                          height: 65, width: 65, fit: BoxFit.cover),
                    )
                  : ClipOval(
                      child: Image.network(
                        widget._buyer['logo'],
                        height: 65,
                        width: 65,
                        fit: BoxFit.fill,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                    "${widget._buyer["name"]} ${widget._buyer["surname"]}"),
              ),
            ],
          ),
        ));
  }
}
