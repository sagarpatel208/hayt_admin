import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hayt_admin/Common/Constants.dart' as cnst;
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController edtName = new TextEditingController();

  TextEditingController edtDescription = new TextEditingController();

  File _image;
  ProgressDialog pr;
  @override
  void initState() {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Please wait..");
  }

  addProduct() async {
    /* try {
      pr.show();
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //pr.show();
        String img = '';
        List<int> imageBytes = await _image.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        img = base64Image;
        print(img);

        String filename = "";
        String filePath = "";
        File compressedFile;
        if (_image != null) {
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
          "oldprice": edtOldPrice.text == "" ? "" : edtOldPrice.text,
          "sellingprice":
              edtSellingPrice.text == "" ? "" : edtSellingPrice.text,
          "placeofproduct":
              edtPlaceOfProduct.text == "" ? "" : edtPlaceOfProduct.text,
          "city": edtCity.text == "" ? "" : edtCity.text,
          "district": edtDistrict.text == "" ? "" : edtDistrict.text,
          "quantity": edtQuantity.text == "" ? "" : edtQuantity.text,
          "color": edtColor.text == "" ? "" : edtColor.text,
          "size": edtSize.text == "" ? "" : edtSize.text,
          "description": edtDescription.text == "" ? "" : edtDescription.text,
          "picture": await MultipartFile.fromFile(filePath, filename: filename),
          "discount": edtDiscount.text == "" ? "" : edtDiscount.text,
          "sellerid": id.toString(),
          "status": "",
          "vipstatus": "",
        });

        AppServices.AddProduct(d).then((data) async {
          pr.hide();
          if (data.data == "0") {
            Fluttertoast.showToast(
                msg: data.message,
                textColor: cnst.appPrimaryMaterialColor[700],
                backgroundColor: Colors.grey.shade100,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_SHORT);
            Navigator.pushReplacementNamed(context, '/Products');
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
    }*/
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
                        /* File croppedFile = await ImageCropper.cropImage(
                            sourcePath: _imageAdvertisementPhoto.path,
                            aspectRatioPresets: Platform.isAndroid
                                ? [
                                    CropAspectRatioPreset.square,
                                    CropAspectRatioPreset.ratio3x2,
                                    CropAspectRatioPreset.original,
                                    CropAspectRatioPreset.ratio4x3,
                                    CropAspectRatioPreset.ratio16x9
                                  ]
                                : [
                                    CropAspectRatioPreset.original,
                                    CropAspectRatioPreset.square,
                                    CropAspectRatioPreset.ratio3x2,
                                    CropAspectRatioPreset.ratio4x3,
                                    CropAspectRatioPreset.ratio5x3,
                                    CropAspectRatioPreset.ratio5x4,
                                    CropAspectRatioPreset.ratio7x5,
                                    CropAspectRatioPreset.ratio16x9
                                  ],
                            androidUiSettings: AndroidUiSettings(
                                toolbarTitle: 'Cropper',
                                toolbarColor: Colors.deepOrange,
                                toolbarWidgetColor: Colors.white,
                                initAspectRatio: CropAspectRatioPreset.original,
                                lockAspectRatio: false),
                            iosUiSettings: IOSUiSettings(
                              title: 'Cropper',
                            ));
                        if (croppedFile != null) {
                          _imageAdvertisementPhoto = croppedFile;
                          // sendAdvertiseImages();
                        } else {
                          //sendAdvertiseImages();
                        }*/

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
                        /*File croppedFile = await ImageCropper.cropImage(
                            sourcePath: _imageAdvertisementPhoto.path,
                            aspectRatioPresets: Platform.isAndroid
                                ? [
                                    CropAspectRatioPreset.square,
                                    CropAspectRatioPreset.ratio3x2,
                                    CropAspectRatioPreset.original,
                                    CropAspectRatioPreset.ratio4x3,
                                    CropAspectRatioPreset.ratio16x9
                                  ]
                                : [
                                    CropAspectRatioPreset.original,
                                    CropAspectRatioPreset.square,
                                    CropAspectRatioPreset.ratio3x2,
                                    CropAspectRatioPreset.ratio4x3,
                                    CropAspectRatioPreset.ratio5x3,
                                    CropAspectRatioPreset.ratio5x4,
                                    CropAspectRatioPreset.ratio7x5,
                                    CropAspectRatioPreset.ratio16x9
                                  ],
                            androidUiSettings: AndroidUiSettings(
                                toolbarTitle: 'Cropper',
                                toolbarColor: Colors.deepOrange,
                                toolbarWidgetColor: Colors.white,
                                initAspectRatio: CropAspectRatioPreset.original,
                                lockAspectRatio: false),
                            iosUiSettings: IOSUiSettings(
                              title: 'Cropper',
                            ));
                        if (croppedFile != null) {
                          _imageAdvertisementPhoto = croppedFile;
                          //sendAdvertiseImages();
                        } else {
                          //sendAdvertiseImages();
                        }*/
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
          title: Text("Add Category"),
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
                          keyboardType: TextInputType.multiline,
                          minLines: 4,
                          maxLines: 6,
                          scrollPadding: EdgeInsets.all(0),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                          cursorColor: cnst.appPrimaryMaterialColor,
                          controller: edtDescription,
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
                Stack(
                  children: [
                    _image == null
                        ? Container(
                            height: 200,
                            color: Colors.grey.shade100,
                            width: MediaQuery.of(context).size.width,
                            child: Icon(
                              Icons.image,
                              size: 40,
                            ))
                        : Image.file(File(_image.path),
                            height: 200.0,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill),
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
                  child: new Text('ADD CATEGORY',
                      style:
                          new TextStyle(fontSize: 16.0, color: Colors.white)),
                  onPressed: () {
                    addProduct();
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
