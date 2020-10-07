import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hayt_admin/Common/AppServices.dart';
import 'package:hayt_admin/Common/Constants.dart' as cnst;
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCategory extends StatefulWidget {
  var _category;

  EditCategory(this._category);

  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  TextEditingController edtName = new TextEditingController();

  File _image;
  ProgressDialog pr;
  @override
  void initState() {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Please wait..");
    _setData();
  }

  _setData() {
    edtName.text = widget._category["name"];
  }

  _updateCategory() async {
    try {
      pr.show();
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //pr.show();
        String img = '';
        List<int> imageBytes;
        String filename = "";
        String filePath = "";
        File compressedFile;
        String base64Image;
        if (_image != null) {
          imageBytes = await _image.readAsBytesSync();
          base64Image = base64Encode(imageBytes);
          img = base64Image;
          print(img);

          ImageProperties properties =
              await FlutterNativeImage.getImageProperties(_image.path);
          compressedFile = await FlutterNativeImage.compressImage(_image.path,
              quality: 80,
              targetWidth: 600,
              targetHeight:
                  (properties.height * 600 / properties.width).round());
          filename = _image.path.split("/").last;
          filePath = compressedFile.path;
        }
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String id = prefs.getString(cnst.Session.id);
        FormData d = FormData.fromMap({
          "name": edtName.text == "" ? "" : edtName.text,
          "img": _image == null
              ? widget._category["image"]
              : await MultipartFile.fromFile(filePath, filename: filename),
        });

        AppServices.UpdateCategory(widget._category["id"], d).then(
            (data) async {
          pr.hide();
          if (data.data == "0") {
            Fluttertoast.showToast(
                msg: data.message,
                textColor: cnst.appPrimaryMaterialColor[700],
                backgroundColor: Colors.grey.shade100,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_SHORT);
            Navigator.pushReplacementNamed(context, '/Category');
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

  void _productImagePopup(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera_alt),
                    title: new Text('Camera'),
                    onTap: () async {
                      var image = await ImagePicker.pickImage(
                        source: ImageSource.camera,
                      );
                      Navigator.pop(context);
                      if (image != null) {
                        setState(() {
                          _image = image;
                        });
                      }
                    }),
                new ListTile(
                    leading: new Icon(Icons.photo),
                    title: new Text('Gallery'),
                    onTap: () async {
                      var image = await ImagePicker.pickImage(
                        source: ImageSource.gallery,
                      );
                      Navigator.pop(context);
                      if (image != null) {
                        setState(() {
                          _image = image;
                        });
                      }
                    }),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacementNamed(context, '/Category');
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text("Edit Category"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/Category');
            },
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
                          child: Text("Name"),
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
                            hintText: "Name",
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
                Stack(
                  children: [
                    _image == null
                        ? widget._category["image"] == "" ||
                                widget._category["image"] == null
                            ? Image.asset(
                                "assets/background.png",
                                height: 200.0,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                widget._category["image"],
                                height: 200.0,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              )
                        : Image.file(File(_image.path),
                            height: 200.0,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover),
                    Positioned(
                      bottom: 0,
                      child: MaterialButton(
                        height: 40,
                        minWidth: MediaQuery.of(context).size.width,
                        color: cnst.appPrimaryMaterialColor[700],
                        child: Center(
                          child: new Text('PICK IMAGE',
                              style: new TextStyle(
                                  fontSize: 16.0, color: Colors.white)),
                        ),
                        onPressed: () {
                          _productImagePopup(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                MaterialButton(
                  elevation: 5.0,
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width,
                  color: cnst.appPrimaryMaterialColor,
                  child: new Text('UPDAE CATEGORY',
                      style:
                          new TextStyle(fontSize: 16.0, color: Colors.white)),
                  onPressed: () {
                    if (edtName == "") {
                      Fluttertoast.showToast(
                          msg: "Please enter Category name",
                          textColor: Colors.white,
                          backgroundColor: cnst.appPrimaryMaterialColor,
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_SHORT);
                    } else {
                      _updateCategory();
                    }
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
