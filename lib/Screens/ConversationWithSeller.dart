import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hayt_admin/Common/AppServices.dart';
import 'package:hayt_admin/Common/Constants.dart' as cnst;
import 'package:progress_dialog/progress_dialog.dart';

class ConversationWithSeller extends StatefulWidget {
  String adminId, sellerId;
  ConversationWithSeller(this.adminId, this.sellerId);
  @override
  _ConversationWithSellerState createState() => _ConversationWithSellerState();
}

class _ConversationWithSellerState extends State<ConversationWithSeller> {
  TextEditingController edtMessage = new TextEditingController();

  bool isLoading = true;
  List _msgList = [];
  ProgressDialog pr;
  @override
  void initState() {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Please wait..");
    print("a: ${widget.adminId}, s: ${widget.sellerId}");
    GetChatMsg();
  }

  GetChatMsg() async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData data = FormData.fromMap(
            {"adminid": widget.adminId, "sellerid": widget.sellerId});
        AppServices.GetSellertoAdminChatMsg(data).then((data) async {
          setState(() {
            isLoading = false;
          });
          if (data.data == "0") {
            setState(() {
              _msgList = data.value;
            });
            print("d: ${_msgList}");
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

  _sendMessage() async {
    pr.show();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData d = FormData.fromMap({
          "message": edtMessage.text,
          "fromtype": "1",
          "adminid": widget.adminId,
          "sellerid": widget.sellerId
        });
        print("s: ${edtMessage.text} ${widget.adminId} ${widget.sellerId}");

        AppServices.SendSellertoAdminMessage(d).then((data) async {
          pr.hide();
          if (data.data == "0") {
            Fluttertoast.showToast(
                msg: data.message,
                textColor: cnst.appPrimaryMaterialColor[700],
                backgroundColor: Colors.grey.shade100,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_SHORT);
            edtMessage.text = "";
            GetChatMsg();
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
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Conversation"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                    child: _msgList.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: _msgList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return MessageComponents(_msgList[index]);
                            })
                        : Center(
                            child: Text(
                            "No Message",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                          ))),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1.5),
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 15, top: 10),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          minLines: 2,
                          scrollPadding: EdgeInsets.all(0),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                          cursorColor: cnst.appPrimaryMaterialColor,
                          controller: edtMessage,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.send,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                _sendMessage();
                              },
                            ),
                            hintText: "Message",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
    );
  }
}

class MessageComponents extends StatefulWidget {
  var _msg;
  MessageComponents(this._msg);
  @override
  _MessageComponentsState createState() => _MessageComponentsState();
}

class _MessageComponentsState extends State<MessageComponents> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: widget._msg["fromtype"] == "1"
          ? Row(
              children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        child: Text(widget._msg["message"]),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/user.png",
                      height: 45,
                      width: 45,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            )
          : Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/user.png",
                    height: 45,
                    width: 45,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          child: Text(widget._msg["message"]),
                        )),
                  ),
                ),
              ],
            ),
    );
  }
}
